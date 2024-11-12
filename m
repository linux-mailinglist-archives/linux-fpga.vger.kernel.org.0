Return-Path: <linux-fpga+bounces-929-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD1A9C4A9A
	for <lists+linux-fpga@lfdr.de>; Tue, 12 Nov 2024 01:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 218531F22D5D
	for <lists+linux-fpga@lfdr.de>; Tue, 12 Nov 2024 00:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2991CEEB3;
	Tue, 12 Nov 2024 00:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ESMQh1IG"
X-Original-To: linux-fpga@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2044.outbound.protection.outlook.com [40.107.236.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F301586CB;
	Tue, 12 Nov 2024 00:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731370999; cv=fail; b=cfQbTFs3nJNKg91xQGF1VeoNmALXoCwLIVan5J7q6Pe3IKdKHLezu2nQ+O/Ww0fF7A1knwQdC+PxN3EAX6XZmsBwbYSWUPNL3cx4BRnRDEvtQ6LLkrpI+GqqehoMhyvg2DC+kLtz2l0d/6eeO1lBfXSbFPkvOX8e91X24MoqPn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731370999; c=relaxed/simple;
	bh=EEtF2cHEWhS6KcrO2ykOspkw6YgEIU8cYiSB9XntEL0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tlYrZMLglyLx60oQfEOSDxFnzK0Ng2VNCPFi1v8lb8tnM9KhzetHPR9GwWrTZDd5k4n8PehfdZhW6VotQwXnzprtWGaIVxSs9D4mTCrlrlpNu6cZuwt5S0z9yWO0Oxj5GTHyG6VDH+yUDU+hDnriiT3JB6cIJkdDnGvGYrW3D4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ESMQh1IG; arc=fail smtp.client-ip=40.107.236.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QXG96TbSKpHptHrqnbKhJ5yvQz1dZr1t6MgVzxgv6YC+1B/nxO9ijA1DfE2m8UZwg6E8GIUt1mF7ocuAgV2PQjhk5XZXyO8268Btkmci56NFsFKC4cLg1QtXnY5orY5B8WfzwAQJEDYVSD7j69vMuxB6tPMBPftxEkgnLeRH/8JcsUmfNcTQdG48C84IUaGktA/dbyVwwvi6kB1plq6/l6YMRx5rctbsntNcJAPkqQ+1zTHcO8JHfJBKPnauw36/FMg31GWDSOKmMPoJlAVZtehchjndjLLPe6WmugjtADhIiyQkzUx+tj4T9CrOE/Yns4Da912U1c+WYuDMZNhCUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OA0jnPZaHUE29xRbScgcql2KGVy78wNSp1k08XWblws=;
 b=Szf3ZGTJsMa4olloDdk7n/ILsSb5q7e+D2jBD6rSQ0DMLS0Vbp1b4sha/m9MdnpJq6hLmShtCRSCqEusIXEQ/IKCHsyC3UXhK1gDq5Zu8mRXERgd7EKSZ0I3hQXHCBSxucc0+BFigV2SkfMlksZGl47FM9AV1oipBTzWPtsnf4fOBERN4DJhMtde++fvc+M1AHhyvRvR2p+cgR5hjzLShSopNy3BsQLJ6ffjLFF+2QCK//bzFhDjtyzDesFSaHzMVPPAej8tvef/DqRy9LVPOGiIaHih1fgb/XE6zw0Ld2YX/HeDO2ElgMGHdcDzSj362bxQa/Ti+/3pqUwaBKnbXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OA0jnPZaHUE29xRbScgcql2KGVy78wNSp1k08XWblws=;
 b=ESMQh1IG82APAIFUPVEY3G3wxpCxvdIq8gjDN/DRMGvnMnSRp8ucV1/a8RWTfgbjPMEMn6YMkhg6D3+6naqFSe5/KdjYPLPmliibc/KWX8Z3Ch/QQzX4XR64x3gZwmIx4SwKluJXT+yRyiZlChfbJ1snihfyegY1pnZnu9fJvmw=
Received: from CH2PR04CA0030.namprd04.prod.outlook.com (2603:10b6:610:52::40)
 by DS7PR12MB6144.namprd12.prod.outlook.com (2603:10b6:8:98::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.27; Tue, 12 Nov 2024 00:23:09 +0000
Received: from CH1PEPF0000AD82.namprd04.prod.outlook.com
 (2603:10b6:610:52:cafe::a1) by CH2PR04CA0030.outlook.office365.com
 (2603:10b6:610:52::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.27 via Frontend
 Transport; Tue, 12 Nov 2024 00:23:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD82.mail.protection.outlook.com (10.167.244.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Tue, 12 Nov 2024 00:23:08 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 11 Nov
 2024 18:23:08 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 11 Nov
 2024 18:23:08 -0600
Received: from [172.19.74.143] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 11 Nov 2024 18:23:07 -0600
Message-ID: <903bc5a6-fc4e-41ac-92d5-20b23f8879b4@amd.com>
Date: Mon, 11 Nov 2024 16:23:07 -0800
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 0/3] Add new driver for AMD Versal PCIe Card
To: Xu Yilun <yilun.xu@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-fpga@vger.kernel.org>,
	<mdf@kernel.org>, <hao.wu@intel.com>, <yilun.xu@intel.com>,
	<lizhi.hou@amd.com>
References: <20241007215556.3023089-1-yidong.zhang@amd.com>
 <ZxH96/aRhMvS2Dgx@yilunxu-OptiPlex-7050>
From: Yidong Zhang <yidong.zhang@amd.com>
In-Reply-To: <ZxH96/aRhMvS2Dgx@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB05.amd.com: yidong.zhang@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD82:EE_|DS7PR12MB6144:EE_
X-MS-Office365-Filtering-Correlation-Id: 1af7cf76-7c3e-40d3-bb6f-08dd02b02f74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dzIxSWp1cVJsQ2g3blN0RGZXMFNma2IzRG1NMUZBOFM5TzRUMWEvWEtkcUQ1?=
 =?utf-8?B?SWp2d2p3ekFqc3ZoRll6QjRBM212S1Y2RGp3KzcxSmZRZGhOQXFaS2syUWVj?=
 =?utf-8?B?c1pJMGV0TW1tK3A4YlBBY3JkT0l5VGZiemdaamhhYW96bjJCRUx0ekU3c2xD?=
 =?utf-8?B?MmZKK1JwbXlxMWhXSVp6NE1UbWpDbTU3alNrdEN5NlZya1RySWpxakZhT3Ja?=
 =?utf-8?B?bVZUaDNISll5bUp6MlBuK1FXWDBCQjV2cHBOYVpoTFVXa3R5Y1gyOXR5QmpE?=
 =?utf-8?B?azhYV1BPOEhxYTNKaUZSMmRCcWF6aFBKMFNmdmhQUy81by9hSTRzb1RnQndw?=
 =?utf-8?B?ZlRWZEFJWWU0MFRuWjBpV1I4ekQ0Szd6T0srcjV1R0dBMEJMbktYU1l3VGRv?=
 =?utf-8?B?emU0ODcxNGlHb3ZxZG1oSlphZHd3bW5pYVVBUklPSG9NaUlHY05GWEprZkwy?=
 =?utf-8?B?Rkh6K1paNmUzNGx1Q0t4aFdnbXA3QWh5dEx3SExMQ2N1SXNWOFFBTE5tdnQw?=
 =?utf-8?B?U1pocTI4SUk1NTloRlJ6VERIYUExUGNwZmtPMXNMWFNnRHlrd2NNU2ZYSTE2?=
 =?utf-8?B?bXR0N2pYVnVuL1N1MEZ6MkUvZjhCSGR3SDJNR0tuUTIrbDd0MFRndmhscHpN?=
 =?utf-8?B?REJuZHd6Q2ZqYUdzdk1SMVVYM0gxc0t2Y2Q4Mk11R2lSNzVkSElubkJCaitZ?=
 =?utf-8?B?K3NKcTlLUElKYkpkRUhBbHRPTWtpM3p2V2pwUGlKTzlMZUhnRC9xTjlQUFYv?=
 =?utf-8?B?OWg3RGY0S21wK3FmQUtBTDgycHhJUXlrN1NWR24xT1p2VDdqRWZCOWRGNURu?=
 =?utf-8?B?S3lrUUdneU9QYVVvUHBaRi9IU3dmZVpvemdzdkNNSzA1MjdkdEZkUFViYTNP?=
 =?utf-8?B?UWE5bVZzeEtBVWpJRDh6c3RGYjl1SWNSbU5tbVpuaWE3UEdTNEtGS1FQc1Vw?=
 =?utf-8?B?RE8yYm9sbUtScktKdWNlVlVLZEJYUlZGZG5PcmU4djlpbjZVWVhBM1hHYlNB?=
 =?utf-8?B?aktOOE80SWVyWFNJYm1ROFdwd2pxM2F1ZHVScUZscC9zZHRZNjF3eU5XZmNK?=
 =?utf-8?B?VmNFYlI5L2dmV0ZrU3RUMDFzY3VDR1UxTk9pT0pzdUFOc1lqYkdrVTFNOEEx?=
 =?utf-8?B?Um9BU3g2S0RFWFk1Vm1aZGFMMmpaS0lER1A5YkVtYWhmTjdZVWZXY3BjbHRk?=
 =?utf-8?B?dmZkQ2x0Ull0RVVLTkswMnMyZ05aZHRwcmo2MktJNFVNUHdtYUxHdDdrenV2?=
 =?utf-8?B?cW9iSDdPa1VkTTdncG9RSVMwUlA3R1NuZkh0b2p2Ykt4Sk91Y2dvOU1nUEls?=
 =?utf-8?B?T3F4UzhyNm5qQXltWm04RjJmY2tnZWZCdzhDbWRCMEtFTlFLNEIxc0JPb2E5?=
 =?utf-8?B?R01KTVFDQTNibXkwTjhHS1ZwUFVOUlFMdUpFTHlvVnJQRTR5d1BidDgrYTA2?=
 =?utf-8?B?MndnZURjQnU5Y3BpdktQVGpQbXhKeUNQZytCVlhNZWhNN3M1U3o3b2hWR0l0?=
 =?utf-8?B?anFreUdUL0NyUWRISTlZUmlNT2ZwZzhnYjVsSGZvQkRsNjg3RFFLSVdja2tk?=
 =?utf-8?B?UDlBcURoWm5PRFBDMkxXdzQ1OEdCWTYyZHBGeUNzQ1ZtTElvZDJhbWpPSDFw?=
 =?utf-8?B?NDBUT3pnd1NQS2ZZUUVLNHM1WGs3MERsbThPLzg0NmNYamttOWhzdWtjclc4?=
 =?utf-8?B?dUV4NXY4UktKTHdWU0dzeHFiTVZtdkFLQlBNQzZWTWZTYXh6TXVYWDVRODdW?=
 =?utf-8?B?N1J5ODRMMFlUWUhVbjhtQTRZTHdQVTcvMnRhcEgxV0NoQlFJMHljZHdMaGE3?=
 =?utf-8?B?d2pvYkdWQXJrYk1kVjZwY0c5WTNuSmlZTXRzNHpybGRwODUrcmlUTmJpZVZu?=
 =?utf-8?B?Z2E5WTZLY3ZFM1R2ZW1ud0poaWQ2ZjJLQTcreHl3NzBhTUE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 00:23:08.8907
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1af7cf76-7c3e-40d3-bb6f-08dd02b02f74
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD82.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6144



On 10/17/24 23:19, Xu Yilun wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> On Mon, Oct 07, 2024 at 02:55:53PM -0700, David Zhang wrote:
>> From: Yidong Zhang <yidong.zhang@amd.com>
>>
>> This patchset introduces a new Linux Kernel Driver, amd-vmgmt for AMD Alevo
>> Versal based PCIe Card. The driver is based on Linux fpga driver framework.
> 
> Your patchset is not correctly threaded. Please use proper --cover-letter > argument.

Hi Yilun,

I will fix this in next patch.

Thanks,
David

> 
> Thanks,
> Yilun

