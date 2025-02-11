Return-Path: <linux-fpga+bounces-1050-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5AEA309F7
	for <lists+linux-fpga@lfdr.de>; Tue, 11 Feb 2025 12:31:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F16367A2903
	for <lists+linux-fpga@lfdr.de>; Tue, 11 Feb 2025 11:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7BCA1F754A;
	Tue, 11 Feb 2025 11:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CWoStOA1"
X-Original-To: linux-fpga@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAEF1F0E3E;
	Tue, 11 Feb 2025 11:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739273474; cv=fail; b=WVLD+0x7BcHjDfLhWhnNi3j78cilrfnHg7wekPnakWmEQCHmJ7vQyxstMhsFlY0CbD0zH6U2IypoTHJMumC1Hcpy2YEm4Jz7+kJG5+zE1iNd2hDqdgnx85tK/nVIPdGVJL7KMhzjeoPoU6EgGpWgyoRUmsRsX2omMbBWCBPLkhE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739273474; c=relaxed/simple;
	bh=3BR2MVF+NnaG3ZYRbJleINoI13SF9hwkSt8DrRBtrOY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dqN2M7UirPF0vYthmGjaXT12TedvNzLz6CWMAkSY+SSIJLxdJ/Sx35j1V1N8LrxEXP6C7nLUki4LXnP8dfUBuWZWQDF6l6q5J92qkoqsGnThoL+Ge7NJC8Fsm5eNj1ZUKFl9mccAH5DJJ0H2EcVIReHlY04aionihC/8pS6LVk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CWoStOA1; arc=fail smtp.client-ip=40.107.244.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mHEYAupBSEOjn7gZCYETBWkif7PVckIKEzChTEP1jKajNPC/V/XRhk0qJuirqMaC470B/E5BpSN8I3tMIRhD3rQdY5OMa8F253xV51IuC2kFH+mzGsQsVgDZ48XNf8hRsDyH4U9D5nE151rIV6EtWT8H5Ar6oOELLn2SbDziM6qP35NQguczMZOLaKCZHaWLdH/iT5Lls8z90kKoEWD7rynXkKY2DXoW69flVoFgyhBQvLbV7lrMB4kz3Ltvo/d0SB7c197cF1A0K/YdQMQo0X/obZ/05uhLi+pQ8GABieEo1/yE/PxL7ytynfgV8rSn16QRWicqD/PHUvAVzLcVKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YcUwO4mmHynJ+VvaDOO+Ff50qjWznQvVNAciFk17wAI=;
 b=R+3pRQs7MEKp5mGK3nWb1BpoFb/Ip968ftBLrWMmbAQM6gjd+ZMAKlKq0RBDcpjVFjavUwpPEbzCHLgRDlZjJi0Wp/7geKZfLqmV5rkv66lZQ/SVTAYRR8IUHm69zx6+veklk2HB+KMHlqhwf0RwGQHdnXIckCbCWRz/zeCkXHF16jW1V3ZAYB8lbAkm/8ieXY3KEKN4KgY+xqxk+gYEB7162CNpxkkr+q8wzdjzbkbKkG9+GzupeMZ/448XG8b4xCcTGTWl1D58OWlDILZY4g2/nPhRghlFBN5QxwJXib2017NN6bX+HZs59Px3P6YDTSnNtJxnzKuOablB9wDlfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YcUwO4mmHynJ+VvaDOO+Ff50qjWznQvVNAciFk17wAI=;
 b=CWoStOA1xQgLl45l1sYM/+cHpy7jSVDL9auyOcRhLiqrINqeAgC6kwsbiTdClsu+k0Z9N1N+08C3xl428We3xgS3BvOopYgdAeYzwUc1chp5yQSXbXflBIMoFCErgDg70MLSDhgt13/kBNloPce8OKbR/p3veqOxzoouylQchRM=
Received: from CH2PR20CA0009.namprd20.prod.outlook.com (2603:10b6:610:58::19)
 by LV8PR12MB9084.namprd12.prod.outlook.com (2603:10b6:408:18e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Tue, 11 Feb
 2025 11:31:08 +0000
Received: from DS2PEPF00003439.namprd02.prod.outlook.com
 (2603:10b6:610:58:cafe::58) by CH2PR20CA0009.outlook.office365.com
 (2603:10b6:610:58::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.12 via Frontend Transport; Tue,
 11 Feb 2025 11:31:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003439.mail.protection.outlook.com (10.167.18.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Tue, 11 Feb 2025 11:31:08 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Feb
 2025 05:31:07 -0600
Received: from [172.19.74.139] (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 11 Feb 2025 05:31:06 -0600
Message-ID: <84281771-52d8-4b1d-8478-1fedb6f31608@amd.com>
Date: Tue, 11 Feb 2025 03:31:06 -0800
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
 <e68be2e2-7fdd-4f09-b479-4b0e31af5be5@amd.com>
 <Z6sT20uzjes7SGzr@yilunxu-OptiPlex-7050>
Content-Language: en-US
From: Yidong Zhang <yidong.zhang@amd.com>
In-Reply-To: <Z6sT20uzjes7SGzr@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB04.amd.com: yidong.zhang@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003439:EE_|LV8PR12MB9084:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a64d153-4c86-443e-f790-08dd4a8f9410
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cDBRT1p0Y0lEeUl0RlJIR1VWWlgyUlpBOWlPUUcwb1dIcWhtSjgwQUtUd09h?=
 =?utf-8?B?T1duN0IzeFRma3FWRnZTMldPRHgvV3lEejZUYysvWjZRL1N1MVRHSDVhRitU?=
 =?utf-8?B?RmhUQ3NQekVaeVNBQ3l4NnVwZU80NXVDWEtReDZoZm12TEJJZDA1Mk1RTkFm?=
 =?utf-8?B?OUJKbXhPLzBOc1QrZE5reUpRREMyYWkyWk9rUTdIQ3Nsek1PR2U4RllVMzRt?=
 =?utf-8?B?dklZNkUyblZQdmdQUG1xMFJQU1FHcWxUdEVMRmhEL09Pak9hT1RkSXRSdVdk?=
 =?utf-8?B?M1JsSzlmOWZuQUxwWVU4c0FnYjZTcHV4eGZuZXhtMWh0VVJCSy8xTW9nbTBv?=
 =?utf-8?B?eU1QK25JdUFoL25wRnlHTVl1dWZFYzFwWFVCNXlRNVVENENscmdhZXk2T2VU?=
 =?utf-8?B?WmxNUUo1dWt4TW1FbFdXWDBtZ3ZvN0w5VlM3VW5qclRZNVBWVHFSbmw2amNk?=
 =?utf-8?B?RE5LUlRCdTVKMS9yclJ4WGxmUnJ4eVZRVGZ1RDlEa3pCTU0zZ0h3VCtOY2VW?=
 =?utf-8?B?U0tqUVFFOE5mTUFNeUczNm5qWUQxZGMwQnk5Y2pFSU93cTUwMStIMzBsb0s4?=
 =?utf-8?B?OHFTN0wyY09YVEpFaEhoKzBzaUU2QUJOcjZTVkxBZ0krSXZNSllrYmd0K0dH?=
 =?utf-8?B?RVh1clpUb1NTT1AwbngxV1JvUkR5SmNBdW5xRzJsVWhlWnpTTnI5UFB0U3Rq?=
 =?utf-8?B?bElkaUh4dG1JdFZmZGlia2VyRDBFOWEwMGVxZkh2d2o3eXcvZ3V1TmVNbG9M?=
 =?utf-8?B?WGEwQVpKSTA1OGVMRjBkSHR6akJMTmhrbVdkMVM2L0cveE5UTVpFVHlUMlk4?=
 =?utf-8?B?SGlXeEkwQklvMHRya0RVRVp5TUJNaWI4SEtxQkt2aGFXN0ZmeEJrdnF5SWNP?=
 =?utf-8?B?QWV2b1dBdWd2Rnd0ZVdBMVZyd3dRMDBoZUJ1aTdQdmFNeDhJUzdwVm1KVkp6?=
 =?utf-8?B?cXk1N0lSd0xFQVZUSDd3a3JZMUUrRGZ3ak80QXVjaXpYeGZwcGNMamFPRVhq?=
 =?utf-8?B?SmJVSDU5Tm05MmdwT0F0SG1xTEpaSE11V1RCTHNLeTNhM0FIZUVwTGNOWFd1?=
 =?utf-8?B?OWdPTkQ3MlAveE1Tblo4RUVhZWQxRjQ4N1J1SzQreGdQbkVXOXdvWm5VUnEr?=
 =?utf-8?B?d21JL21BcTNpRjlNMWcxblMzaGdVcytpM01HbURPbUUrMlp5VE5qeEYydUR2?=
 =?utf-8?B?cEVJWnFMNCtnQU9sZzlXUUNMK3NGSDZKVTNrbUZvOVZHQXZtTmFUVmw2UnRT?=
 =?utf-8?B?b3BMNlZBeDVIWWZzQ2JWdVJ1Z251bDdUbmN3TUUyc1NZTzVQVnBhSjFaeFg5?=
 =?utf-8?B?ZDR5MGFhYmdOS0NjbVVHY001d0YrMHZQbHFvRFV2OHUrUG1ma2JhSzFjS1NU?=
 =?utf-8?B?YW5VOXFkQk5PSnV1QWxSaUVPS1h5Nnp5QzBncGlVTUh6RzZuOE1YQUtxVmwz?=
 =?utf-8?B?RzVRaUE3dTIyVWNKb0J3SVN5eSsrT3g1MWI1eWdKcmxBcHJzV1p0Vm9aeGdQ?=
 =?utf-8?B?NzkxMkwvbHg3TmV4M3E2K2JBbGxPMHk0cVpxVFNNbEg1MkQrMldOUG1DTCs4?=
 =?utf-8?B?aW5nN1d0UVBPeWNDUlpiMjJnNk1lWmV1a2pZd0s4RVNIN3dwS3N3TWsxMzI1?=
 =?utf-8?B?bnhqcEEwYnJTSXZpRXFoUzVVRzZuR1lBVmdSc2hSV3E1VUd6SFo3d3ZUckNp?=
 =?utf-8?B?amEzRXgxbkQvVUVwZVFpWEdlNEU0MkZTVitFWHF3NUNCeVN3OHlKZ2tkWEd1?=
 =?utf-8?B?TEZBN2x2RktGamVONUM1OCt2R0kvR0Z3bmtJL0liUzdaa1puby9vQiswRnph?=
 =?utf-8?B?cUV0NzVUTndyMHF1b2NkOXNiZkNNWTNzUHJJTys5QU9UZUd2K04rMWp5NmZ5?=
 =?utf-8?B?bGVDWEREeVFhcllWVTAwWUx5cWVjTkFhbVpaZ2ZtMVpZNjE2ZDAyNzJISmRq?=
 =?utf-8?Q?EEMFpsm/VlM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 11:31:08.0303
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a64d153-4c86-443e-f790-08dd4a8f9410
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003439.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9084



On 2/11/25 01:09, Xu Yilun wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> On Mon, Feb 10, 2025 at 03:33:07AM -0800, Yidong Zhang wrote:
>>
>>
>> On 2/6/25 20:40, Xu Yilun wrote:
>>> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>>>
>>>
>>> On Thu, Feb 06, 2025 at 07:16:25PM -0800, Yidong Zhang wrote:
>>>>
>>>>
>>>> On 2/6/25 18:19, Xu Yilun wrote:
>>>>> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>>>>>
>>>>>
>>>>>>> No need to detach a specific driver, remove all devices in the
>>>>>>> fpga-region. I imagine this could also be a generic flow for all PCI/e
>>>>>>> based FPGA cards.
>>>>>>
>>>>>> I see your point. Is there an existing example in current fpga driver for
>>>>>> PCI/e based cards?
>>>>>
>>>>> No. The fpga-region re-enumeration arch is still WIP, so no existing
>>>>> implementation.
>>>>
>>>> Got you. I can also help to test or provide feedback.
>>>> Actually, I had sent Nava my protype of using configfs for the non-OF
>>>> driver. He should have the updated patch soon.
>>>>
>>>>>
>>>>>>
>>>>>> We will need to talk to our management team and re-design our driver.
>>>>>> I think we have 2 approaches:
>>>>>> 1) Align with linux fpga, having one driver for both userPF and mgmtPF; or
>>>>>
>>>>> Don't get you. Linux FPGA doesn't require one driver for both PFs.
>>>>
>>>> I assume when you said "generic flow for removing all devices in
>>>> fpga-region" means that there is a single driver which use the fpga-region
>>>> callbacks to remove all devices and then re-progream the FPGA.
>>>>
>>>> On AMD V70 hardware, the userPF has different deviceid than the mgmtPF.
>>>> Thus, our current design is having 2 separate pcie drivers for each
>>>> different deviceid.
>>>>
>>>> Thus, in our current design, the fpga-region should be in the userPF driver
>>>> which has callbacks to remove all devices. But in mgmtPF, it is more like a
>>>
>>> A question, if the FPGA logic is cleared, does the userPF still exist on
>>> PCIe bus?
>>
>> I am not sure I fully understand your question by "FPGA logic is cleared".
>> Based on our design, the userPF exists, but all services need to be
>> re-configured after hardware is changed.
> 
> I briefly read your XRT docs. IIUC we are talking about reprogramming
> the "Dynamic Region", not the "Shell".
> 
> The userPF's PCIe basic functionality is in Shell and is out of
> our reprograming discussion. So userPF PCI device always exists even if
> the "Dynamic Region" is being reprogrammed. In this case, we should
> create fpga-region for this "Dynamic Region" in userPF driver.
> 
> userPF uses some HW communication channel to require reprograming, so
> fpga-manager could also be implemented in userPF driver.
> 

Thanks for taking your time reading our documents. You are exactly 
correct. We will use fpga-manager and fpga-region in our userPF driver 
for upstreaming. If you think this is acceptable by linux fpga 
framework. I will talk to my team for next step.

> And I agree the mgmtPF driver is a utility driver that just monitor on
> the communication channel and serve requirements, nothing to do with
> FPGA framework. I have no objection to put it in misc or firmware
> directory.
> 
> What I'm not sure is whether a standalone utility driver in kernel tree
> is preferred (at least I don't). You may talk to other maintainers.
> 

My last question for this topic:
If we decide to upstream both userPF and mgmtPF driver together, could 
them be both within the drivers/fpga/amd as in-tree driver? This will 
help user find source code easily.

Thanks,
David

>>
>>
>>>
>>>> utility which only handles request from the userPF but it has the management
>>>> privilege. Usually, cloud vendors require the mgmtPF deployed in their
>>>> secured domain (can be a separate physical machine).
>>>
>>> I though mgmtPF & userPF are just 2 functions on one PCIe card, they are not?
>>> Then how the mgmtPF writes data to another physical machine and
>>> influence the userPF?
>>>
>>
>> They are functions but they also have different device id thus we can bind
>> different driver onto each of them.
>>
>> I think I should interrupt it accurately as Host and VM. See details here
>> please:
>> https://xilinx.github.io/XRT/2019.2/html/cloud_vendor_support.html
>>
>> But, my point is that we do have 2 separate drivers.
> 
> OK, having 2 separate drivers is definitely fine.
> 
> Thanks,
> Yilun

