Return-Path: <linux-fpga+bounces-969-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94ABA9D3379
	for <lists+linux-fpga@lfdr.de>; Wed, 20 Nov 2024 07:16:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D11628441F
	for <lists+linux-fpga@lfdr.de>; Wed, 20 Nov 2024 06:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1673D3F9C5;
	Wed, 20 Nov 2024 06:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YfYKtpCa"
X-Original-To: linux-fpga@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2062.outbound.protection.outlook.com [40.107.236.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93F5E545;
	Wed, 20 Nov 2024 06:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732083373; cv=fail; b=Gt0GXx9cyr1vIg3uaSeTu8ZegF5ke+HkD9cL7q7Hj+FEqJ19/b/H1qg3dezIVJfTtYXm/h+l6+B1nZ+tgw4NHUIkyP/8cglTFFwzKB8kv0VBAp7TTXQDm7ZUz1B27epeEwbbJhT9EVBfPPsU3YbOMHxb8JAHaef3zOkLp0L6Vxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732083373; c=relaxed/simple;
	bh=+ny7dzEr1IENV4cOdD90BLk9rIMA6TJkMmjDwaILS/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=d/0pPRkIub38Q2NDWnGru5bNpbORX9l6ELB5sNrKf3bmp+ds3mHS3ipKfrUAys0fq+gOWuMLymEcnDLoxeUqQ5otJtezVa2b/Bv+nt0EV0OzlrfSovXX5zi80Kkwe+uikCJiPhuqiYaUTpPHO1KLwqrbLu9hMAyPWEZ666GaEoE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YfYKtpCa; arc=fail smtp.client-ip=40.107.236.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fybg3qyKVw16nhhk8r1poCnmW62d1SSKny463y5W1uk8pC/KB4GCMQ91n4UsbcUTG0ctB8YOmqsUbjc0+JKV39O8rPl3+4lS93jSSx8m/492ab5pbdDLf115Qchs7/SnxXkVcEIV1uSU+3exnDOYujYuGYDxKUA1/JJyDjJ4r9fCs3u3e8Q+Sok91h2C4X7eQQuD4oe82NoGCNGHFacUjth71uYCW3tnrIBESFsXxhCb7hKQHlG/TmLK1Uf8gQAu+JDhgCy1ysNwWNeJc8V9aOCQDr6Ftu8THlDBtnnPQiMHbYl+CSYdbfYz++zyntZLVDZblrOJKf3Kw5pZFLEPug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PNlMkqmnIIw2IT9qWlvCQwbj+WFJMa+l3j/FFj4flu4=;
 b=i7j2CT+1u3w4mgtRauPUFfyE9htBtmYEoK/XDvDlXulgXm/eyIESCy22GccnTx0+HT7vclG4w4o/TG4Cb7QktLjV1UQ8Y3k4yeGkVhpi4DaGKNYO0I7GyRXqy92SnOUALnveDGzoT/fXex3BYFcemEXSfRt8hlygPT5H30hAzS3z3LNAYuZS7PWVmPG7dGHH1jFNIGxEGUGbzq+KaHNSMFLUBAeF83jJn0Fn5dYsnqxiEFwYkE/eT0w+f4tpu0dxAsf9hfpe24seYp59TdxcaJ8IKtGh87Wr+ihL9y5XglBftWd8Hu87qSK0sFO9CaRbOAjJdNbUMqsEUGzPHQAiiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PNlMkqmnIIw2IT9qWlvCQwbj+WFJMa+l3j/FFj4flu4=;
 b=YfYKtpCaz6eTmQZ1a20ipfPWna+HXCCeoxGToxU2PQXxzpo3mLgUfBUrRAwTbyRB3DnLBacSBXatTfYIkIFsy3MEx3MJnH0dO3Pxvi5xcHjoEDh+c58R/1rgaqJJUCJXzW93rhe3u3ElJ9hoMcW7AsJgwbjL09thR5T5BNmYqwU=
Received: from MW4P220CA0025.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::30)
 by SJ1PR12MB6074.namprd12.prod.outlook.com (2603:10b6:a03:45f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Wed, 20 Nov
 2024 06:16:07 +0000
Received: from SJ1PEPF00002321.namprd03.prod.outlook.com
 (2603:10b6:303:115:cafe::bd) by MW4P220CA0025.outlook.office365.com
 (2603:10b6:303:115::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.25 via Frontend
 Transport; Wed, 20 Nov 2024 06:16:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.12) by
 SJ1PEPF00002321.mail.protection.outlook.com (10.167.242.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.16 via Frontend Transport; Wed, 20 Nov 2024 06:16:06 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Nov
 2024 00:16:05 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Nov
 2024 00:16:05 -0600
Received: from [172.19.74.143] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 20 Nov 2024 00:16:04 -0600
Message-ID: <d27e09ac-2bd2-46e3-8f92-dfbacb9cc436@amd.com>
Date: Tue, 19 Nov 2024 22:15:59 -0800
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 1/3] drivers/fpga/amd: Add new driver for AMD Versal
 PCIe card
Content-Language: en-US
To: Xu Yilun <yilun.xu@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-fpga@vger.kernel.org>,
	<mdf@kernel.org>, <hao.wu@intel.com>, <yilun.xu@intel.com>,
	<lizhi.hou@amd.com>, DMG Karthik <Karthik.DMG@amd.com>, Nishad Saraf
	<nishads@amd.com>, Prapul Krishnamurthy <prapulk@amd.com>
References: <20241007220128.3023169-1-yidong.zhang@amd.com>
 <ZxH9Xjd0eU/7IDGC@yilunxu-OptiPlex-7050>
 <56421e2e-062c-407b-b731-0c1d585a1277@amd.com>
 <Zzw5MOb6dUD6BLYh@yilunxu-OptiPlex-7050>
From: Yidong Zhang <yidong.zhang@amd.com>
In-Reply-To: <Zzw5MOb6dUD6BLYh@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB05.amd.com: yidong.zhang@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002321:EE_|SJ1PR12MB6074:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a50c9a4-609a-4623-905c-08dd092ad1d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NjJlN0poanZEcXdpbmpXT0t6NWErWXN1K1ZNWFF2cFpURGY5RlVTcHN1cWxr?=
 =?utf-8?B?dFRZRUltWk4zdUk5dTUwaW9qUkxpTHBQVnIrKzczdkswTHoxNU9UV0QwY0pV?=
 =?utf-8?B?LzhESEhLRng1SzNib2RSdk81YlZLWEYwalIxbDRkNktjUGZLRXVycDhIQndm?=
 =?utf-8?B?cFczTEo2b080K3B0ZG1jcmdyNC9Dbm04aW13UGVWUWNXYUhXLzVIbkdlTWYy?=
 =?utf-8?B?dDFuNFFiSXBVd3BpTU45UVpCZFpUR3NyRk1JSDBJUGJNREdtRm1OM0kzamRp?=
 =?utf-8?B?bC9GUFErVkh5dEhPREtiNWNOeU5ZV05tZTZwbzZXVnpJVEdncktiTmtUajl2?=
 =?utf-8?B?V3dueWgvYkZVYkRrYlNmaTZjS1VtYk1uRFBqVG9VVG45bHVvbjVBcXhRcklP?=
 =?utf-8?B?VThwWGMrN2JrQVlESFBYZ2Z1NzZFS2xkak9SVncvd1NZa1UzZlVzbmlPaEk1?=
 =?utf-8?B?a0paUmlGazBic20vazJxU3ZEaU85NGszMnpFY205VlN4OHBUTmdqbUhkT0Ri?=
 =?utf-8?B?alBpRjkwdjZtdUZ1ai93RnB0cHNCTkxrbFpsR2hSMDZEY0trNHRFODZ5by9O?=
 =?utf-8?B?S0NBdmQrbjZEaiswc1dCNXdnclhlbDBNWE1lTGs4bElveVpRTjRPWm1hVFhO?=
 =?utf-8?B?R2VPVHdXZ2hDVTVyaEZJODA5OTRqTUZNc2QxMlNkZ2pGWDJ1M0g3eFppNWQ3?=
 =?utf-8?B?dENTaVZSeENpdHdzN21lWWY4bEVuQkRac3luZkNZb0tZeEFweUVISTNISUZv?=
 =?utf-8?B?N28waTVHakZSWFM2cWJLWDVMeUI2SFNMaTVYSDU2UUI1cTRLU3g0Z3l4azRv?=
 =?utf-8?B?SkVIYm1HdlMzcTZ2VHRiVGVCTVh5M0pmUmNwNjJNODNuRStzOWFaN1luZmhJ?=
 =?utf-8?B?LzFqVS9qcjZ5dUszV2p0c2VxSW5BcGZwa2dvQm9CKzc3dUtWSXlqVXNVekd4?=
 =?utf-8?B?S1B4alVTaGFEdytQZjgxaVBIa2N2RWJHOWxqb01sNE8zYnZkczJJYTVkWGhY?=
 =?utf-8?B?d3lKd3FmY0RjcmZxa2lRTWhESDAwNmd4OEdmY2NqSGJ6QnJPZ3hHMXRGb2xK?=
 =?utf-8?B?SnJUTUpuMWxOdWh4VjlEdzVBMEJkQ21RY2RXYkQ3bkxlYlJxY1pTaHAxL1p2?=
 =?utf-8?B?NXhlKzNETk5sTkQyNjc1RWd1VlVDWlRLclYxczg5MjJEZVVRc2o1VktLU2Vm?=
 =?utf-8?B?OTdlRXpqaHN1UXBVazh2bEd0UUdUY0JTcXhXYm1uKzVORlJzRmMvaGk4MzVJ?=
 =?utf-8?B?eVJpWmJGY3RKaDlkdFQvVG8wN0NVbVNyM2p2MjdjOWpTUDVZY2RoblVzQlcz?=
 =?utf-8?B?ZjhEV051OWtTR0tCZkpoNmFYbmE4OG90dHhRekVuQjUwOG5WS3UrV1dLd1lS?=
 =?utf-8?B?QzVnTWROTmI0QkQ5WjVVWjVHcXg5WXhPVlhtZUE1dGpIL1VoSVhvOFJzZ2I5?=
 =?utf-8?B?NjVQR0t6aHFSSHlGVkVTNDE4ZmlmMUNHTkFnamQ0R0JRUFE4Ty9WRktESFVo?=
 =?utf-8?B?dlh3RDhSMmROaFFtTy9lbFdjNnh5Mm9JcEJ1UmN0ajZMZ2FqaDBxMTRwZnB0?=
 =?utf-8?B?OFJyRmV5ckR6WjZGSzE5ZmdEeHdTQVZ2ckFPTmE2ZWFrbWJHcVltbkZyeHgy?=
 =?utf-8?B?UjBMZHZ3dlAwWWJuQi9ESEphUm1Gc2hnQjk2N1JxT1Y1b3RXbGtWVFZPZ0NM?=
 =?utf-8?B?UHhOSjlsYTljYjRDS2h3OVZJSHhIbnVsQmZMeFFhOFNOZlBkWnBiNHR5dDFy?=
 =?utf-8?B?dnVmR0FSeUN5WFp6N1Z3UmJsS041aHFvOXRrejJPek9mdm5hTFBaakM5QnN0?=
 =?utf-8?B?N0ovRFZxWlQxaFNYcXFob1J0b3NIZENLUEhqTGRHMm5NRGhVL0lWZjc0a1d1?=
 =?utf-8?B?ZXdsdlpxRmMveHh6c1BXVXBsaWVlSTFiMjJDR2NTc2N1amc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:atlvpn-bp.amd.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 06:16:06.8208
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a50c9a4-609a-4623-905c-08dd092ad1d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.12];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002321.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6074



On 11/18/24 23:07, Xu Yilun wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
>>>> +obj-$(CONFIG_AMD_VERSAL_MGMT)                        += amd-vmgmt.o
>>>
>>> IMHO the naming vmgmt is hard to understand, any better idea?
>>
>> The "v" stand for Versal. We would change to amd-vpci for Versal based pcie
> 
> "v" + "pci" is quite a misleading term, maybe just versal-pci?

Sound good, I will rename the driver to versal-pci.

> 
>> devices.
>>
>>
> 
> [...]
> 
>>>
>>>> +{
>>>> +     struct comms_device *ccdev;
>>>> +
>>>> +     ccdev = devm_kzalloc(&vdev->pdev->dev, sizeof(*ccdev), GFP_KERNEL);
>>>> +     if (!ccdev)
>>>> +             return ERR_PTR(-ENOMEM);
>>>> +
>>>> +     ccdev->vdev = vdev;
>>>> +
>>>> +     ccdev->regmap = devm_regmap_init_mmio(&vdev->pdev->dev,
>>>> +                                           vdev->tbl + COMMS_PCI_BAR_OFF,
>>>> +                                           &comms_regmap_config);
>>>
>>> I'm not sure why a regmap is needed. All register accessing is within
>>> the same module/file, and I assume a base+offset is enough to position
>>> the register addr.
>>
>> I thought the regmap is preferred. We can use some common APIs like
>> regmap_bulk_*. The base+offset works too, then we will implement our own
>> bulk_* functions. Please let me know.
> 
> I didn't see any regmap_bulk_*. AFAICS regmap is not needed here.

The bulk_* is in the patch 0003. I can switch to base+offset in next 
version of the patches.

> 
> [...]
> 
>>>> +     /* create fgpa bridge, region for the base shell */
>>>> +     fdev->bridge = fpga_bridge_register(dev, "AMD Versal FPGA Bridge",
>>>> +                                         &vmgmt_br_ops, fdev);
>>>
>>> I didn't find the br_ops anywhere in this patchset. So how to gate the
>>> FPGA region when it is being reprogrammed? What is the physical link
>>> between the FPGA region and outside visitors?
>>
>> The FPGA region gate operation is done in the FW running in this PCIe card.
>> The FW will "freeze" the gate before programing the PL. After downloading
>> the new hardware. The FW will then "free" the gate.
> 
> So no OS operation is needed, then seems no need the fpga_bridge object.

Thanks, I will simplify this code.

> 
>>
>> No physical link between FPGA region and outside visitors, the FW handles
>> all requests.
>>
>>>
>>>> +     if (IS_ERR(fdev->bridge)) {
>>>> +             vmgmt_err(vdev, "Failed to register FPGA bridge, err %ld",
>>>> +                       PTR_ERR(fdev->bridge));
>>>> +             ret = PTR_ERR(fdev->bridge);
>>>> +             goto unregister_fpga_mgr;
>>>> +     }
>>>> +
>>>> +     region = (struct fpga_region_info) {
>>>> +             .compat_id = (struct fpga_compat_id *)&vdev->intf_uuid,
>>>> +             .get_bridges = vmgmt_get_bridges,
>>>> +             .mgr = fdev->mgr,
>>>> +             .priv = fdev,
>>>> +     };
>>>> +
>>>> +     fdev->region = fpga_region_register_full(dev, &region);
>>>
>>> I assume the fpga region represents the user PF, is it? If you
>>> reprogram the FPGA region, how does the user PF driver aware the HW is
>>> changing?
>>
>> The HW changing request is always requested from the user PF driver. The
> 
> I don't understand. In your patch the FPGA reprograming is triggered by
> an IOCTL, usually a userspace application calls it. But here says it is
> triggered by the user PF *driver*, which IIUC is a kernel driver.
> Anything I missed?
>

I will remove the IOCTL in the patch because this IOCTL is internal test 
only. The official request should always come from the user PF to avoid 
hardware crash due to hardware changes.

The userPF flow is described below.

>> user PF driver will make sure it is safe to change hardware. Then, the user
>> PF driver notify the mgmt PF driver by a unique identify of the HW bitstream
>> (PL Data).
>>
>> The mgmt PF driver, the amd-vpci driver, will check the unique identify and
>> then find the same PL Data from its local storage which is previously
>> installed, and start downloading it.
> 
> Is the flow included in this patchset? Please elaborate more.
> 

The userFP driver will send request to the mgmt PF driver (versal-pci).
The versal-pci driver will then find the same PL Data from its local 
storage (e.g. /lib/xilinx/fw_uuid/xclbin_uuid.xclbin).
The versal-pci driver will then read the firmware and download it.

I will port more code in next patch. The 1st patch did not include 
everything. I can use a single/separate patch for this specific flow so 
that it would be easy for you to review.

> [...]
> 
>>>> +/**
>>>> + * VERSAL_MGMT_LOAD_XCLBIN_IOCTL - Download XCLBIN to the device
>>>> + *
>>>> + * This IOCTL is used to download XCLBIN down to the device.
>>>> + * Return: 0 on success, -errno on failure.
>>>> + */
>>>> +#define VERSAL_MGMT_LOAD_XCLBIN_IOCTL        _IOW(VERSAL_MGMT_MAGIC,         \
>>>> +                                          VERSAL_MGMT_BASE + 0, void *)
>>>
>>> Many definitions are added in a batch but some are not used in this
>>> patch. Please reorganize the patches for easer review, even for first
>>> version.
>>>
>>> Thanks,
>>> Yilun
>>
>> Hi Yilun,
>>
>> Thanks for taking your time, and yes for sure I will make each patch more
>> self-contained.
>>
>> Here is my thoughts on upcoming patches structure:
>> 1st patch, adding driver probe and FPGA framework; the actual ops
> 
> Just adding driver probe for 1st patch please.
> 

Sure.

Thank,
David

> Thanks,
> Yilun
> 
>> of handling communication channel message and remote queue message
>> will present as no-op with comments.
>>
>> 2nd patch, adding the communication channel services
>> 3rd patch, adding the remote queue services
>> 4th patch, adding the callers of using the remote queue services
>>
>> Thanks,
>> David
>>
>>>
>>>> +
>>>> +#endif /* _UAPI_LINUX_VMGMT_H */
>>>> --
>>>> 2.34.1
>>>>
>>>>

