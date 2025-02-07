Return-Path: <linux-fpga+bounces-1046-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25522A2B98F
	for <lists+linux-fpga@lfdr.de>; Fri,  7 Feb 2025 04:16:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22FDC188992F
	for <lists+linux-fpga@lfdr.de>; Fri,  7 Feb 2025 03:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73EB2156F3A;
	Fri,  7 Feb 2025 03:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oXn10Ton"
X-Original-To: linux-fpga@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F94A1420A8;
	Fri,  7 Feb 2025 03:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738898204; cv=fail; b=s84c+kJ0n017H00WV0htRj42HDSxj4/gwy6Pq/mLIK8Rur8HZBPG2+qWOGwoWmGa9NLHt186ihl21ILtzeJEUKy8QWLfEIZyh7rAQkAzQEBzoOO6PDaNK9ovJLRt/kpTNJq3+57bASqCRHcZmjJpX+5t+8i+OqCiSA8dqv7RG98=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738898204; c=relaxed/simple;
	bh=HF8auZivKlnwuIsiB/wrWB2SfdrcWP/V7EQNg+zgqw0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LXvDzgm6w+6uo6YcQDNUQHJMYJAcjJzY5Oo8F2Rk+rV8NJJVe1YjL33NFKDO9H60aVLl74KZjZRtV7ZOvqWuTFU16vqz6Mq3pXl9MA2enVb4RZ/NQAVZtj0Uw+GrESmzqDo4LmjBMDy+DBfoI36frWVW9CZlWse5P4w0WP6MgsE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oXn10Ton; arc=fail smtp.client-ip=40.107.237.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QIDXoCQSWOAc30eFS4LjHNa/OFOnbmzRMWbYAElL8LyLi97yCEDgvUvU93zKIEXd1MuC3HuQ8qYIfkGp4h2aFDYnOa8OOSdlLuUIdz6CSDe08/QyFWWG8rn+qerJynoPY7no/vMtry05t3XJOlZFtWuppEALDAxAUF1URSHPRzwm8YKjP6UUtoNu/tHlfabpk6l0jArCDGlgUk0WYNN2MRZ6PYER1o1R1BjPjVQe+YcWBEcMG+9uWCKpAM+OdCZvAEkpHcPj+P0FveKjYc0MqFMlhEeGFyFY0IgujlRo5YZsYj38Rk2CamKf2lv3BlxIPxU8HtxEHRRS2QHdnETcEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rs8Kwgjo9KO/wv3P2udf9m+IMvtjpRL9DbRC523S3z8=;
 b=LL8oyLd12xD3c2elM1e4EjHQcI0EBEL4UsxA3CVDZoKzlbgRdSywb87Tr08zW3Oo7DCUzJMQlOSKMGM7RJVupo7ZnhHkfoEgGL2A7H3HBr29loqigLKMaDy2PPylsv6rC87PsEPIlnmJuGwNH/ETxzD9Si4+drYSkounD2AxUJ72q7vqPZbOpT1avdyBjVetL74VVgzocFcLLH15DpPB67SipynrBB5pVDpW7BzQfDGSnL/2hOFwQGy9onuy9+3E1tm+iOJTxpCxPK8OviLPSupGdkmjbk5M+GYmQIYncU8UnrL5T+8ePieXbw42sEaNB+JLsX4wIS4eWs0/Ug03Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rs8Kwgjo9KO/wv3P2udf9m+IMvtjpRL9DbRC523S3z8=;
 b=oXn10Tonu+HE5x1dmLmnbXGh7xjs+6DTeFlKyliVcU/OEfdHnFdBx3iM+IJu+QBN//N6TdxwGRDjLUM43CAeLAX3gazhybZ35BAa4T9Ho4drekiuXLUYo7hwjksbr30P2a9e7Xo4gMTsLkWYKywEEnn2wStaJEJzoMH4IJSRrAg=
Received: from CY8PR12CA0007.namprd12.prod.outlook.com (2603:10b6:930:4e::9)
 by SA3PR12MB8000.namprd12.prod.outlook.com (2603:10b6:806:31f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.10; Fri, 7 Feb
 2025 03:16:38 +0000
Received: from CY4PEPF0000FCC1.namprd03.prod.outlook.com
 (2603:10b6:930:4e:cafe::a5) by CY8PR12CA0007.outlook.office365.com
 (2603:10b6:930:4e::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.29 via Frontend Transport; Fri,
 7 Feb 2025 03:16:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000FCC1.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Fri, 7 Feb 2025 03:16:38 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Feb
 2025 21:16:26 -0600
Received: from [172.19.74.139] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 6 Feb 2025 21:16:26 -0600
Message-ID: <7b9bd24f-8f89-4d6c-a079-47c4c0b88a35@amd.com>
Date: Thu, 6 Feb 2025 19:16:25 -0800
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
	<nishads@amd.com>, Prapul Krishnamurthy <prapulk@amd.com>, Hayden Laccabue
	<hayden.laccabue@amd.com>
References: <20241210183734.30803-1-yidong.zhang@amd.com>
 <20241210183734.30803-2-yidong.zhang@amd.com>
 <Z5YPWHVmL29zuQNm@yilunxu-OptiPlex-7050>
 <3b520bab-d948-470a-b06f-5494243ebc1a@amd.com>
 <Z6Q3W2mUw/ZbtnWV@yilunxu-OptiPlex-7050>
 <796e2826-a423-4d0c-977a-105ed236e067@amd.com>
 <Z6Vtz/Bb8wsIH0pG@yilunxu-OptiPlex-7050>
Content-Language: en-US
From: Yidong Zhang <yidong.zhang@amd.com>
In-Reply-To: <Z6Vtz/Bb8wsIH0pG@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB03.amd.com: yidong.zhang@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC1:EE_|SA3PR12MB8000:EE_
X-MS-Office365-Filtering-Correlation-Id: 4117e93b-8e3d-4bfd-1e2f-08dd4725d5e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eERFVlFmZXZVZm9TeElGb216eXlnZVVrcW84RjA3SlJHMXlRWm1QRVFGUE9U?=
 =?utf-8?B?OXI4NnBNNGlCNlEwQ2N1L3NCREIvK2RTMGh0dHFPV0EvMmhYVUtmTVBaZS9v?=
 =?utf-8?B?eHlpOHJ5bzI4UWsxL2c3ME5Nbm9wODNkZFI3c3d0RnlvcmtXdHFVbUMyMHRV?=
 =?utf-8?B?aUx4TWtNTDZHU0h2dDJnM0FoQVZmam50SzVqWXVwa21TV0ZZUkxoejR1b2NV?=
 =?utf-8?B?UzUvZU5rODQzQlFqUDNTWlh6MitwczRCRFg2a3M0b2haZFV3dERDMnZkVU5O?=
 =?utf-8?B?SXY0MS9QZVBjUnYwcmJFdTlrajdBVHdSbHEycFlMMmFKclhTSHJOa2ZIYUJO?=
 =?utf-8?B?R2tOYVI1UGpUd0dDTjIvdGNCSjlxRGFSQUJ6d0gxalYySnlybGFpSDZuZTRu?=
 =?utf-8?B?V2ZIdldJait1UDhzTGdVcW8xVGJCelllTmpOdkdVSytwWDhlT25sdS9HM2RC?=
 =?utf-8?B?dW9oQUdweVFBSzhhMWRhT0FsWWdOcVFJWXhNWlp0TmNaUjRMcEQ4UkRkRWE4?=
 =?utf-8?B?YVRyV2UxaEZWR2NGa2RWYjRQU0RCbU1ZYTNnOFk1enN4bzFGSDY3VnVkRnlI?=
 =?utf-8?B?TmYrY2FQNTZyRFo3aXl1YkRiUFNXeitBTDFRVXBKNnpiWnpjbE5xNG0rcEcr?=
 =?utf-8?B?RGkwSmNMTmh2c3V0NnYrcTBzYWFBa3FIb3lzdlhKbmxTK0xiUTZycW5DMjEz?=
 =?utf-8?B?bXdlRjlHakIwakFuamw3YnZqVkxyUE9teXBWVFR1MVlyR0d1SmpQWHMyT0pG?=
 =?utf-8?B?cHhCYWZGdXlTSWNoU0hNT2VxTjBsL2NpbFdDc2FqK256MlZDSWNsUHhSRGc3?=
 =?utf-8?B?ZzI1SEgzSkVwRXpqMlNtSVVmQUE4MXZxclJ1M1hjVVltM3RrMmtMSGM5Qkt0?=
 =?utf-8?B?TkpqZitHeWM1Uko5b2hJL0dtdTdkNnVJcHNTTVd4Wms4K1Y4b0s1SVd3UURT?=
 =?utf-8?B?M1JkQzdGdkxtS2R5UWV1YzNrYk5kcjE3dEhReTFpUy9EbVhFVWVoMXN2YzRD?=
 =?utf-8?B?bk52L1VaUWNTVTBPMklZSkNYUzY4YmtSNWJUbU10akZIdlRpZDZLYWVBYmNk?=
 =?utf-8?B?dDltK29IL2oweDMzbkNOLytKOTdQRllUWDUwY1B2NnE0UGpoV2lRTXduN0V3?=
 =?utf-8?B?dHdmWU1YZUsxOU5wN2tvZDRpOUM5Qk1aSlc2S2hvMHVwbzkxMzF3YzlTektF?=
 =?utf-8?B?VkMyVFRHT2NwVTFaSEZQZTA5TkRYODlrUzdoSnhCSzVlejdqZ0NRTHUwQlFN?=
 =?utf-8?B?eFpOUUNBcGpZMllrVWhPb2RMY1JnL3g2YnE4MGJBS1ZTNGt2SUJvR0tVZDFm?=
 =?utf-8?B?K2xQRlEwNVp0a0h3TVZjTlVSNWRsMC8xU3dldUxKUUpkRXMyRlJLdjdmNENi?=
 =?utf-8?B?VzRtWGRvSkgwUzBITmI2OXNlYjR5YTRSSnJiSjlQZXkyUzZlWDV4K2xpb1Uy?=
 =?utf-8?B?dmlZS0FKRktvdmpWNnlQdFhqcFR2VWxKVE9hZHFnNEtnNnZ2Z1plKzZ3Y2JM?=
 =?utf-8?B?MU9zWStkWTI0Z0NhdGFEMmVyVmJtdUF1elhwNDJQM1RRT29zYVNycnFRcDhW?=
 =?utf-8?B?Ujk4VDZ4Sy9tY0lqZFphMGVDSkhpT2cwb2l5Z0ZWR3FmNFk2YmFicUhPeFYz?=
 =?utf-8?B?MGV5R3ZRV1grQTZUZVdHdkZrbi9KbmxZanlBSDkzVkp5SHJ0UkpueVdYeElV?=
 =?utf-8?B?b0d2cWk3VE8yd3lYei9YYi9xRHFob2Eyei96NWZhOVI1SHAzWFR3aGlPKzFu?=
 =?utf-8?B?SnR1Ykc3UWg1M3dsTnd1S09uUzU4anBnVlRTUkFjNjJwQU4vaVBQNE8zNnVh?=
 =?utf-8?B?Nks5cU0xQi9xZ2k3bzlnUXA0RXpoSVcralhwclBiTzQ0Ky9IUmllbEZOMFlt?=
 =?utf-8?B?MnZIY1JGSU1IT1NPQ3VyUDZOeE9PNXhkalpyZ2FIQUoydFdFZzFtRURXN3JZ?=
 =?utf-8?B?OEtIRVJoQzQwcjE2ZFp0YmFEQ0QrTHBRVXJNUWlodzU2bzZQSFFTRTI0eGpy?=
 =?utf-8?Q?2q17XMYrRLyRrA/8McmczVzJKwUQZQ=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 03:16:38.3102
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4117e93b-8e3d-4bfd-1e2f-08dd4725d5e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8000



On 2/6/25 18:19, Xu Yilun wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
>>> No need to detach a specific driver, remove all devices in the
>>> fpga-region. I imagine this could also be a generic flow for all PCI/e
>>> based FPGA cards.
>>
>> I see your point. Is there an existing example in current fpga driver for
>> PCI/e based cards?
> 
> No. The fpga-region re-enumeration arch is still WIP, so no existing
> implementation.

Got you. I can also help to test or provide feedback.
Actually, I had sent Nava my protype of using configfs for the non-OF 
driver. He should have the updated patch soon.

> 
>>
>> We will need to talk to our management team and re-design our driver.
>> I think we have 2 approaches:
>> 1) Align with linux fpga, having one driver for both userPF and mgmtPF; or
> 
> Don't get you. Linux FPGA doesn't require one driver for both PFs.

I assume when you said "generic flow for removing all devices in 
fpga-region" means that there is a single driver which use the 
fpga-region callbacks to remove all devices and then re-progream the FPGA.

On AMD V70 hardware, the userPF has different deviceid than the mgmtPF.
Thus, our current design is having 2 separate pcie drivers for each 
different deviceid.

Thus, in our current design, the fpga-region should be in the userPF 
driver which has callbacks to remove all devices. But in mgmtPF, it is 
more like a utility which only handles request from the userPF but it 
has the management privilege. Usually, cloud vendors require the mgmtPF 
deployed in their secured domain (can be a separate physical machine).

We can keep 2 drivers, one for userPF, one for mgmtPF. The userPF and 
mgmtPF communicate each other via the communication channel because they 
can be physically on different machine.

Are you looking for us to upstream both of them together?
If yes, I still think that the fpga-region should be in the userPF 
driver. The mgmtPF driver is still a utility driver.

Please correct me if I am wrong.:)

> 
>> 2) find a different location (maybe driver/misc) for the version-pci driver,
>> because it is an utility driver, not need to be tied with fpga framework.
> 
> I'm not the misc maintainer, but I assume in-tree utility driver +
> out-of-tree client driver is not generally welcomed.

Great info! Thanks! I will have to discuss this with my team too.

My understanding, so far based on your comments above, the drivers/fpga 
prefer to use fpga-region ops to handle FPGA re-program changes.

The current versal-pci driver is a utility driver.
The fpga-region should be within the userPF driver.

We can try to make our userPF driver in-tree as well. But the current 
plan is to do it later.

If you prefer we do both of them together. I can talk to my team.

Thanks,
David
> 
> Thanks,
> Yilun
> 
>>
>> Please let me know you thoughts. Which way is acceptable by you.
>>
>> Thanks,
>> David
>>>
>>> Thanks,
>>> Yilun
>>>
>>>> driver and allow the userPF driver re-enumerate all to match the new
>>>> hardware.
>>>>
>>>> I think my understanding is correct, it is doable.
>>>>
>>>> As long as we can keep our userPF driver as separate driver, the code change
>>>> won't be too big.
>>>>
>>>>>
>>>>> Thanks,
>>>>> Yilun

