Return-Path: <linux-fpga+bounces-1048-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 305DBA2EB2B
	for <lists+linux-fpga@lfdr.de>; Mon, 10 Feb 2025 12:33:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFCA43A161D
	for <lists+linux-fpga@lfdr.de>; Mon, 10 Feb 2025 11:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7751C173F;
	Mon, 10 Feb 2025 11:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pwb5SF70"
X-Original-To: linux-fpga@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2042.outbound.protection.outlook.com [40.107.102.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B304D158538;
	Mon, 10 Feb 2025 11:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739187198; cv=fail; b=Dwquu8P/5+psiS6yWNDoz5YYJB8ZQ8yfEcD0VBzRYx/+zp4ebm5tJSoJN4eZZOIU+3HUjIzSmt9Bx0TJ/yjgyMFBzoLaljq3R5EJPcqfE2JJ9WZa8cHYEhq3Fnhp7P2ABRYRapaVfZh3XWAFFVOVzHF9pL5+YbH1NbSW64UQbXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739187198; c=relaxed/simple;
	bh=LniGSPLnUO2uv4FlXRCYrau9nZ1gGfg/P59e4T4Id1U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VexEmriHk7Pnq2PfKZkUcRp8TFvgnFFCOHr5iedRz2ltaGI5W9CISqi+H3WPzK3LEgQBgaZwVjVHFR8/jvqG6p/scr+Rj0JPiFcMjqste/MI+MXgb/gUKBwe9LLlvqTZ/v+KCC2Ul10EyuzXCWTjZLYT7wBTsjeRS2V+nlI8k5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pwb5SF70; arc=fail smtp.client-ip=40.107.102.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eq7O4+ma6+OOY9YVy3QSLXSzxBgONlfYAdjkKGA5Dt+wUrE02y65fby/SBGCmrG9VPiILNlzSvNz3md3lHE7KhqPKPfCnZVgLw+oBs1oLVy7fFAovSD9nWDhI1hXxVunbHTwdclq6rklD/KCI6y5OWEHK5I9jgUSDNA84wUoW3SOeyAAT5D+ALwnc+G9AXNMemhk/SjBuYo4nw6/v3Vks1yBRqTzYtiCIRrdpIcpn389QTLRV4l68lR1yPbMabNUf3xT3D5Wm1ge+IbkeiHCusfZFnG5HM3VCOkQWDNgMvqNUmUd/IifbdJ+EhfZhQ5oTL6hzH/sSZ7dfgZGh5xmrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1lKKND+xu34FpLiII+BDdUKrnoGjoLbroB0kt4T1EHk=;
 b=RBQgB6MZiT8XtJkkgrN9qSzvJpgEQ8/2zjMPz1ztoesBJ/9mX1EylE76zmug3jXqEC3o3dhxQz5tMytDPVOD71BSIKxwul5vP/7bpxObx4rEos8zQ+KG8LuKJ7hET3701wSmQJFymkfK/PNEiMjlFcBzg3u1LeDXFEn91+ZdTWFCVyd/8i9glJkstftgpWDy8X1o4gzynJUbxHEWtAfNs/cw+tHrpf+OVC2ofwB2h/v4aQ2VxvwFXd0b6lhkqC+GcH/szJKGPmZIan/2AG4L7LCbIeQLrvUvzcpT1NKbNPZt/wcSXMebCgbbbBOmckYsHYc/5UXUcKWTtyIpcbnVQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1lKKND+xu34FpLiII+BDdUKrnoGjoLbroB0kt4T1EHk=;
 b=pwb5SF70gLlvKt1JtsXHgZ8Gtvu/mavBW1ao2xIRdGqdIE7kmoqwQ1x8JzfjYvDzJCvk6PnsQCAH24fBZp8FunGzNsh0GQKZdBGMIXdn0l8yJsZ+J3rCmVTTfF0vYgkt7pc7nysDaiooACRrQjfqdAqq7O07xE8gW80C5gq8IP0=
Received: from PH3PEPF000040A6.namprd05.prod.outlook.com (2603:10b6:518:1::55)
 by MW4PR12MB8611.namprd12.prod.outlook.com (2603:10b6:303:1ed::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.14; Mon, 10 Feb
 2025 11:33:10 +0000
Received: from SJ1PEPF000023DA.namprd21.prod.outlook.com
 (2a01:111:f403:c902::13) by PH3PEPF000040A6.outlook.office365.com
 (2603:1036:903:49::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.10 via Frontend Transport; Mon,
 10 Feb 2025 11:33:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023DA.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.0 via Frontend Transport; Mon, 10 Feb 2025 11:33:09 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Feb
 2025 05:33:08 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Feb
 2025 05:33:08 -0600
Received: from [172.19.74.139] (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 10 Feb 2025 05:33:07 -0600
Message-ID: <e68be2e2-7fdd-4f09-b479-4b0e31af5be5@amd.com>
Date: Mon, 10 Feb 2025 03:33:07 -0800
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/4] drivers/fpga/amd: Add new driver amd versal-pci
To: Xu Yilun <yilun.xu@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-fpga@vger.kernel.org>,
	<mdf@kernel.org>, <hao.wu@intel.com>, <yilun.xu@intel.com>,
	<lizhi.hou@amd.com>, DMG Karthik <Karthik.DMG@amd.com>, Nishad Saraf
	<nishads@amd.com>, Hayden Laccabue <hayden.laccabue@amd.com>
References: <20241210183734.30803-1-yidong.zhang@amd.com>
 <20241210183734.30803-2-yidong.zhang@amd.com>
 <Z5YPWHVmL29zuQNm@yilunxu-OptiPlex-7050>
 <3b520bab-d948-470a-b06f-5494243ebc1a@amd.com>
 <Z6Q3W2mUw/ZbtnWV@yilunxu-OptiPlex-7050>
 <796e2826-a423-4d0c-977a-105ed236e067@amd.com>
 <Z6Vtz/Bb8wsIH0pG@yilunxu-OptiPlex-7050>
 <7b9bd24f-8f89-4d6c-a079-47c4c0b88a35@amd.com>
 <Z6WO2Ktc9HoqdUSU@yilunxu-OptiPlex-7050>
Content-Language: en-US
From: Yidong Zhang <yidong.zhang@amd.com>
In-Reply-To: <Z6WO2Ktc9HoqdUSU@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023DA:EE_|MW4PR12MB8611:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bcf6537-66f9-488c-93d7-08dd49c6b23a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MHFTU044WTRpK0JjMEgrcnNnOXlPUGxwRkk0ckFjTUgxeTkydVVoMWhVSHlh?=
 =?utf-8?B?NnBvaDdJSVNMY0lKQ1BDa2pCUTVCNitxUXp3NGxlYWZjS0hieVhXcjNpcU0z?=
 =?utf-8?B?T3ByZFZ2ZzV1c3RiV21NVWV5eHgyNnFpVXdaNjFZZ2ZFK2g4cENDVE1xQmxC?=
 =?utf-8?B?cEtubG5SWEhwdXZSYStOS0FJMXl4MG80OTVIN0JJcE5qekNjVHdLTWtQNFRL?=
 =?utf-8?B?dDZndHc0eXRkQkRsbU9JZmUyRnUweXdBTUYzcFRWMmEvQkNjMXRmVUtLb3JT?=
 =?utf-8?B?QTdaSTVwZUtmbGNLQ3oyZlYzSjl3WUtDOXlzWmhrSjhMZTJsNm1qekYwWS9l?=
 =?utf-8?B?azRWVU1lZFo5S3BCV0lBd1FBK0FIVHRUUDBoQnBEbHRkMDJXbVRiYk9hYnRH?=
 =?utf-8?B?blFSbUE0SzUyVDNQNE5qQTVXYlF5WHc5T25nWEtRV2dMZkRYVDBzOWVEazQ0?=
 =?utf-8?B?bEZaZUNOemxVeE9rZVIzVjlwMHB4QXFUWDhrdlpJNndVRXV6dGlQS0VVbjli?=
 =?utf-8?B?c3dPeE5JRmI0N1FpWnRoR3BTNUlHWVF0UDR2M1VwTTZ0WnAybWFJMW9XeGZB?=
 =?utf-8?B?Qkc5ZU54MEYwb3BKY3Jwdms3dm9GNVV5TUdRWUxxNERab1Q3UGlaMkZmR2hP?=
 =?utf-8?B?N012cGlBRStub0RVaHorek1IZGJpV2t3cGhrdWU0OThPdk9Hakp5dXdMMndV?=
 =?utf-8?B?QWplNDRYNE9HMHZaelJoUkxldEs5MmhhYkFnUFpEalNzeXB1ZDRGTFZiT0tT?=
 =?utf-8?B?eUJ6K0RJbCtqcHROVFlEa1NUcitzZDUwZWw2dGV5TlA5L1RvNFMwNkdnZkdZ?=
 =?utf-8?B?U3pRV2JHeVhwbW1pbU1tRmhqTDlKVldUS3FBZE1zdC9SWHk3Y3ppY3RPZ0dy?=
 =?utf-8?B?aCtqYi9sSSszcXVLNE55anQvQms4ditoM3dvVGRnbTFKWEFLb1RJbG9TWDNp?=
 =?utf-8?B?a0FIbVpreVlBYzdXT0hXMHQ1QzUwL0xLNUJZWDRNaUswSUhWVnV4c05rdkNQ?=
 =?utf-8?B?VnZibG5XT3RJdE1HaTdFVUV0NVVVQ29rQ1B1VS9pRnhYMmJGdldSOXRqRDJF?=
 =?utf-8?B?M0NsK2daNGoxeVRLMXlVdFIvMXFOYnJpNnh3SVpwRHQwZ1pKRG9tVlZyN1lu?=
 =?utf-8?B?YVg5aGdKZVBKdDBNZDc5YmlrL3Rocjd1cjVUcFQ5YkwyRitZVU9wbllZS2s0?=
 =?utf-8?B?cEROTW55cTg1b1RBdktmNmVUNk4vMHVSdnVDbmZtcWFMR2pKUUVrMHBxbTR6?=
 =?utf-8?B?M1NsQ1lVU3pwQk1BUm01S3NDL2dwc2dmQ1AyZ1J1cllVTG5XQ3UrSEpIV3BB?=
 =?utf-8?B?Y3hDZ1BRUDYvUldBWGFUYjJzNkNUeU5Ialh2MjFTNzlhZ05kSFFnVnRLSTV6?=
 =?utf-8?B?Zm9MV2UvcGVGR1JDYngwaDRLK2pFM3Y2MnFIeDFQTWN4V2JsbXNEcmVIN0E1?=
 =?utf-8?B?a1BEdENBaWlKWnFIM2R3TjI3WUVlZnZydFlFaFRhTUozeWFDL3RrVlB4Vm12?=
 =?utf-8?B?MWZib0RvL1ZzVVBLdU5RdE93ZXNwMGFNazIzbUNlL1UyTXJualBOUlg2YWFk?=
 =?utf-8?B?VFA1dVdkazh1Y2JLL3pxNlk5Q3ZpR1NySzUxMHMwUFdBTGxBZkd5MjlxRnpv?=
 =?utf-8?B?b2dFd2M2bEpMcVJuNGJ1RUdyMDRzZ1FTQUFnVG1WTlFvRFF3QU1DdUZtT0Mr?=
 =?utf-8?B?QVpOakl5ZGRRQVZkOVF1OVB0M3orb0kxZmpmRURFazRVVENCRFdLSytQdUp2?=
 =?utf-8?B?OU5aNUdGc1NvVURJMVNRc1BtK2R5d0ptQ1VKQ1JLcDRSWHpEV2RsNVk0R1N1?=
 =?utf-8?B?NVYwc0VOSk5vQlgreWtrTWIvZWI3VTNXNXd0QTB1R25ESCtMb0MyS2NBd1Yy?=
 =?utf-8?B?YVJ1cTV2ZVNYT2dna2o4NUh3NzJoUExUWlYyRTg2bi9WaW52ODVCdXphU0t3?=
 =?utf-8?Q?IfZip29D/N4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 11:33:09.7451
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bcf6537-66f9-488c-93d7-08dd49c6b23a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB8611



On 2/6/25 20:40, Xu Yilun wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> On Thu, Feb 06, 2025 at 07:16:25PM -0800, Yidong Zhang wrote:
>>
>>
>> On 2/6/25 18:19, Xu Yilun wrote:
>>> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>>>
>>>
>>>>> No need to detach a specific driver, remove all devices in the
>>>>> fpga-region. I imagine this could also be a generic flow for all PCI/e
>>>>> based FPGA cards.
>>>>
>>>> I see your point. Is there an existing example in current fpga driver for
>>>> PCI/e based cards?
>>>
>>> No. The fpga-region re-enumeration arch is still WIP, so no existing
>>> implementation.
>>
>> Got you. I can also help to test or provide feedback.
>> Actually, I had sent Nava my protype of using configfs for the non-OF
>> driver. He should have the updated patch soon.
>>
>>>
>>>>
>>>> We will need to talk to our management team and re-design our driver.
>>>> I think we have 2 approaches:
>>>> 1) Align with linux fpga, having one driver for both userPF and mgmtPF; or
>>>
>>> Don't get you. Linux FPGA doesn't require one driver for both PFs.
>>
>> I assume when you said "generic flow for removing all devices in
>> fpga-region" means that there is a single driver which use the fpga-region
>> callbacks to remove all devices and then re-progream the FPGA.
>>
>> On AMD V70 hardware, the userPF has different deviceid than the mgmtPF.
>> Thus, our current design is having 2 separate pcie drivers for each
>> different deviceid.
>>
>> Thus, in our current design, the fpga-region should be in the userPF driver
>> which has callbacks to remove all devices. But in mgmtPF, it is more like a
> 
> A question, if the FPGA logic is cleared, does the userPF still exist on
> PCIe bus?

I am not sure I fully understand your question by "FPGA logic is 
cleared". Based on our design, the userPF exists, but all services need 
to be re-configured after hardware is changed.


> 
>> utility which only handles request from the userPF but it has the management
>> privilege. Usually, cloud vendors require the mgmtPF deployed in their
>> secured domain (can be a separate physical machine).
> 
> I though mgmtPF & userPF are just 2 functions on one PCIe card, they are not?
> Then how the mgmtPF writes data to another physical machine and
> influence the userPF?
> 

They are functions but they also have different device id thus we can 
bind different driver onto each of them.

I think I should interrupt it accurately as Host and VM. See details 
here please:
https://xilinx.github.io/XRT/2019.2/html/cloud_vendor_support.html

But, my point is that we do have 2 separate drivers.

Please let me know if you need more detailed info.

/David

> Thanks,
> Yilun
> 
>>
>> We can keep 2 drivers, one for userPF, one for mgmtPF. The userPF and mgmtPF
>> communicate each other via the communication channel because they can be
>> physically on different machine.
>>
>> Are you looking for us to upstream both of them together?
>> If yes, I still think that the fpga-region should be in the userPF driver.
>> The mgmtPF driver is still a utility driver.
>>
>> Please correct me if I am wrong.:)
>>
>>>
>>>> 2) find a different location (maybe driver/misc) for the version-pci driver,
>>>> because it is an utility driver, not need to be tied with fpga framework.
>>>
>>> I'm not the misc maintainer, but I assume in-tree utility driver +
>>> out-of-tree client driver is not generally welcomed.
>>
>> Great info! Thanks! I will have to discuss this with my team too.
>>
>> My understanding, so far based on your comments above, the drivers/fpga
>> prefer to use fpga-region ops to handle FPGA re-program changes.
>>
>> The current versal-pci driver is a utility driver.
>> The fpga-region should be within the userPF driver.
>>
>> We can try to make our userPF driver in-tree as well. But the current plan
>> is to do it later.
>>
>> If you prefer we do both of them together. I can talk to my team.
>>
>> Thanks,
>> David
>>>
>>> Thanks,
>>> Yilun
>>>
>>>>
>>>> Please let me know you thoughts. Which way is acceptable by you.
>>>>
>>>> Thanks,
>>>> David
>>>>>
>>>>> Thanks,
>>>>> Yilun
>>>>>
>>>>>> driver and allow the userPF driver re-enumerate all to match the new
>>>>>> hardware.
>>>>>>
>>>>>> I think my understanding is correct, it is doable.
>>>>>>
>>>>>> As long as we can keep our userPF driver as separate driver, the code change
>>>>>> won't be too big.
>>>>>>
>>>>>>>
>>>>>>> Thanks,
>>>>>>> Yilun

