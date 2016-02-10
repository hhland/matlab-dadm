function [Rules,FreqItemsets] = findRules(transactions, minSup, minConf, nRules, sortFlag, code, rulesfile)
%
% This function performs Association Analysis (Apriori Algorithm):  Given a set of transactions,
% find rules that will predict  the occurrence of an item based on the occurrences of other
% items in the transaction
% 
% Rules are of the form  A-> B (e.g., {milk, diaper} - > {Coke}), where
% support = minSup (minimum support threshold)
% confidence = minConf (minimum confidence threshold)
% 
% Support is the fraction of transactions that contain both A and B:
% Support(A,B) = P(A,B)
% 
% Confidence is the fraction of transactions where items in B appear in transactions  that contain A:
% Confidence(A,B) = P(B|A)
%
%
% INPUT:
%          transactions:  M x N matrix of binary transactions, where each row
%                                  represents one transaction and each column represents
%                                  one attribute/item
%          minSup:          scalar value that represents the minimum
%                                  threshold for support for each rule
%          minConf:        scalar value that represents the minimum
%                                  threshold for confidence of each rule
%          nRules:           scalar value indicating the number of rules
%                                  the user wants to find
%          sortFlag:         binary value indicating if the rules should be
%                                  sorted by support level or confidence level
%                                  1: sort by rule support level
%                                  2: sort by rule confidence level
%          code (labels): 编码规则            optional parameter that provides labels for
%                                  each attribute (columns of transactions),
%                                  by default attributes are represented
%                                  with increasing numerical values 1:N
%           
%          fname:            optional file name where rules are saved
%
% OUTPUT:
%          Rules:             2 x 1 cell array, where the first cell (Rules{1}{:})
%                                 contains the itemsets in the left side of the rule and second
%                                 cell (Rules{2}{:}) contains the itemsets
%                                 in the right side of the rule (e.g., if
%                                 the first rule is {1, 2} -> 3,
%                                 Rules{1}{1} = [1,2], Rules{2}{1} = [3])
%         FreqItemsets: A cell array of frequent itemsets of size 1, 2,
%                                 etc., with itemset support >= minSup,
%                                 where FreqItemSets{1} represents itemsets
%                                 of size 1, FreqItemSets{2} itemsets of
%                                 size 2, etc.
%         fname.txt:      The code creates a text file and stores all the
%                                 rules in the form left_side -> right_side.
%
% author: Narine Manukyan 07/08/2013

% Number of transactions in the dataset
M = size(transactions,1);
% Number of attributes in the dataset
N = size(transactions,2);

if nargin < 7
    fname = 'default';
end

if nargin < 6
    labels = cellfun(@(x){num2str(x)}, num2cell(1:N));
end

if nargin < 5
    sortFlag = 1;
end

if nargin < 4
    nRules = 100;
end

if nargin < 3
    minConf = 0.5;
end

if nargin < 2
    minSup = 0.5;
end

if nargin == 0
    error('No input arguments were supplied.  At least one is expected.');
end

% Preallocate memory for Rules and FreqItemsets
maxSize = 10^2;
Rules = cell(2,1);
Rules{1} = cell(nRules,1);
Rules{2} = cell(nRules,1);
FreqItemsets = cell(maxSize);
RuleConf = zeros(nRules,1);
RuleSup = zeros(nRules,1);
ct = 1;

% Find frequent item sets of size one (list of all items with minSup)
T = [];
for i = 1:N
    S = sum(transactions(:,i))/M;
    if S >= minSup
        T = [T; i];
    end
end
FreqItemsets{1} = T;

%Find frequent item sets of size >=2 and from those identify rules with minConf

for steps = 2:N
    
    % If there aren't at least two items  with minSup terminate
    U = unique(T);
    if isempty(U) || size(U,1) == 1
        Rules{1}(ct:end) = [];
        Rules{2}(ct:end) = [];
        FreqItemsets(steps-1:end) = [];
        break
    end
    
    % Generate all combinations of items that are in frequent itemset
    Combinations = nchoosek(U',steps);
    TOld = T;
    T = [];
    
    for j = 1:size(Combinations,1)
        if ct > nRules
            break;
        else
            % Apriori rule: if any subset of items are not in frequent itemset do not
            % consider the superset (e.g., if {A, B} does not have minSup do not consider {A,B,*})
            if sum(ismember(nchoosek(Combinations(j,:),steps-1),TOld,'rows')) - steps+1>0
                
                % Calculate the support for the new itemset
                S = mean((sum(transactions(:,Combinations(j,:)),2)-steps)>=0);
                if S >= minSup
                    T = [T; Combinations(j,:)];
                    
                    % Generate potential rules and check for minConf
                    for depth = 1:steps-1
                        R = nchoosek(Combinations(j,:),depth);
                        for r = 1:size(R,1)
                            if ct > nRules
                                break;
                            else
                                % Calculate the confidence of the rule
                                Ctemp = S/mean((sum(transactions(:,R(r,:)),2)-depth)==0);
                                if Ctemp > minConf
                                    
                                    % Store the rules that have minSup and minConf
                                    Rules{1}{ct} = R(r,:);
                                    Rules{2}{ct} = setdiff(Combinations(j,:),R(r,:));
                                    RuleConf(ct) = Ctemp;
                                    RuleSup(ct) = S;
                                    ct = ct+1;
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    
    % Store the freqent itemsets
    FreqItemsets{steps} = T;
end

% Get rid of unnecessary rows due to preallocation (helps with speed)
FreqItemsets(steps-1:end) = [];
RuleConf = RuleConf(1:ct-1);
RuleSup = RuleSup(1:ct-1);

% Sort the rules in descending order based on the confidence or support level
switch sortFlag
    case 1 % Sort by Support level
        [V ind] = sort(RuleSup,'descend');
    case 2 % Sort by Confidence level
        [V ind] = sort(RuleConf,'descend');
end

RuleConf = RuleConf(ind);
RuleSup = RuleSup(ind);

for i = 1:2
    temp = Rules{i,1};
    temp = temp(ind);
    Rules{i,1} = temp;
end

disp(['关联规则算法完成,规则数为：' num2str(size(RuleSup,1))]);

% Save the rule in a text file and print them on display
fid = fopen(rulesfile, 'w');
fprintf(fid, '%s   (%s, %s) \n', 'Rule', 'Support', 'Confidence');

for i = 1:size(Rules{1},1)
    s1 = '';
    s2 = '';
    for j = 1:size(Rules{1}{i},2)
        if j == size(Rules{1}{i},2)
            s1 = [s1 code{Rules{1}{i}(j)}];
        else
            s1 = [s1 code{Rules{1}{i}(j)} ','];
        end
    end
    for k = 1:size(Rules{2}{i},2)
        if k == size(Rules{2}{i},2)
            s2 = [s2 code{Rules{2}{i}(k)}];
        else
            s2 = [s2 code{Rules{2}{i}(k)} ','];
        end
    end
    s3 = num2str(RuleSup(i)*100);
    s4 = num2str(RuleConf(i)*100);
    fprintf(fid, '%s -> %s  (%s%%, %s%%)\n', s1, s2, s3, s4);
end
fclose(fid);
disp(['存储规则到文件‘' rulesfile '’完成'])
end