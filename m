Return-Path: <linux-fpga+bounces-988-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46ED39FA91B
	for <lists+linux-fpga@lfdr.de>; Mon, 23 Dec 2024 02:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C36177A1D51
	for <lists+linux-fpga@lfdr.de>; Mon, 23 Dec 2024 01:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6662EAFA;
	Mon, 23 Dec 2024 01:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Sgp7gCl2"
X-Original-To: linux-fpga@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F376B1FB4;
	Mon, 23 Dec 2024 01:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734918824; cv=fail; b=MCUipGPgcar9OuCmW01M5oT4vCLORilmzh/rDESTRBAmvWZP9K/PAiiRKNmYWixSUEAz/QCt7dDHdnhtpJ9XOviyD+vaF5GBSat0U040+y+YsQiypx+911sxD8de7OAIak49686Bh6/pev9nXnKrpySDadeOjCEvLtVLQ0m2hvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734918824; c=relaxed/simple;
	bh=Lzu6TVopqNNbvF7YRpFaseUc60bxG7PDmlfQHLtzhbg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OR4v17t8b4NnNRqLP/phRk26aeOkkMu9ec05dFtmzVY2kFAl9xvDwU6aYY+7Z24zwZUJs2fmcxQVoOCcbFUfnFLW20J3XeM3UHO2CBfs5Kzh1GVQHCnPoR2+ZGUNKgXPodC7luaO3BAbPmuLNq1CN+WiELdsxQ4Ef3vLh4OtMcc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Sgp7gCl2; arc=fail smtp.client-ip=40.107.93.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GNOFJ/Cv1oeTmtg84aO1sMzMsNBGDz5xGAGYgSJ3PO+QruN/HAoP4uSKWTP6tUT6LwtGiOm2OPWJpO9ojmH8k2Vk+259uN34/cm+HFtDXCAB/G3slIPUjE8wKjPN4e9lyHjRZR+OevW5Gx3e/QFLetAzx/qqXx68l7vSr8VoqxENfoWWhnbSO4r9z2VYGFauoZ2RFgHX6Bx+Sj0bQGo41wEHmxa4vngUP2qEp+hEyU4TLPHh9Ju/51kjythT5JqS1iuWWDyzx0z/7+zmvvgCV6ykGCqgzhgZmeKSl5ol2xFjMPLcSfbRPwQZNhmWsDAY7a3WjJVpftaVjSIn+DvJEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J+Vl2ErhfcDzBRriW/B+LEuC4JghHg7NkK/eVbExcJI=;
 b=v0N9sEhnsBmCVCtV7tIao9Sz+SAtCdqu1ywAxjn3ITKVLzOcfHfP5kwX8SzLxfITmve7yFh98QKr13XSM90yC+hPl6tdijLxbtPH09PK2eLRTNEQiNewF0ZaCHYbAG6BfUBnRzjJCqHzZoeMXqd1Vq68YBXttxgdFALhudH6+TW6RjDXkCHUE2AHZggmfI23PTTQIkQsE8o61UicIHai0qVPfwJMmNuOzqACjh/QMtrf+kDdrelC2HrguuWGKwslKZAtylwJb1Z3xEtH8dJaBIGSou5a6+E27ORNHP7OyA5e4kSBbUy/9nEeMkCOKW0dglCxs1UvvMyUMTN//QxQfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J+Vl2ErhfcDzBRriW/B+LEuC4JghHg7NkK/eVbExcJI=;
 b=Sgp7gCl2lRKoS29wfz2yEK+6UuqLuGxW7RnKpGJwLzrGynN+fIlQqsOjM0XQhCtuHQnXXgn1PWHhkVQRvYbdq4II98zAHmgk/dOmRatBi9MD5UKCEjSAwC8tsDezAyQViettVi/qtS3wZ8X8SD/JgzEu6/xKgeqTf8No86lWmH8=
Received: from PH7PR03CA0007.namprd03.prod.outlook.com (2603:10b6:510:339::9)
 by IA0PR12MB8253.namprd12.prod.outlook.com (2603:10b6:208:402::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.19; Mon, 23 Dec
 2024 01:53:35 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:510:339:cafe::1a) by PH7PR03CA0007.outlook.office365.com
 (2603:10b6:510:339::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8272.18 via Frontend Transport; Mon,
 23 Dec 2024 01:53:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8293.12 via Frontend Transport; Mon, 23 Dec 2024 01:53:32 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 22 Dec
 2024 19:53:31 -0600
Received: from [172.19.74.139] (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Sun, 22 Dec 2024 19:53:31 -0600
Message-ID: <f9abc70d-2d07-4506-a227-af297eb77058@amd.com>
Date: Sun, 22 Dec 2024 17:53:30 -0800
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 1/3] drivers/fpga/amd: Add new driver for AMD Versal
 PCIe card
To: Xu Yilun <yilun.xu@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-fpga@vger.kernel.org>,
	<mdf@kernel.org>, <hao.wu@intel.com>, <yilun.xu@intel.com>,
	<lizhi.hou@amd.com>, DMG Karthik <Karthik.DMG@amd.com>, Nishad Saraf
	<nishads@amd.com>, Prapul Krishnamurthy <prapulk@amd.com>
References: <20241007220128.3023169-1-yidong.zhang@amd.com>
 <ZxH9Xjd0eU/7IDGC@yilunxu-OptiPlex-7050>
 <56421e2e-062c-407b-b731-0c1d585a1277@amd.com>
 <Zzw5MOb6dUD6BLYh@yilunxu-OptiPlex-7050>
Content-Language: en-US
From: Yidong Zhang <yidong.zhang@amd.com>
In-Reply-To: <Zzw5MOb6dUD6BLYh@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB03.amd.com: yidong.zhang@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|IA0PR12MB8253:EE_
X-MS-Office365-Filtering-Correlation-Id: c3caf6e6-7a03-4c3b-1df1-08dd22f49b4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MU9ManRLM0J1OXZTckZNQWRwdWluM1BLQU9MY2JUVTczUnI0czl3QmgzMGxV?=
 =?utf-8?B?aGZ5NVptV1lxcStRVDFmeUQ4NGdkRUZ1aVcxZmpzcDhuYWp0TVJwS0RJL1dU?=
 =?utf-8?B?N25yU3JQMVRPZUZEQ0FZbzArcmZ5ZVZXMzExeHVuZVFVaVYzUlhUNUlEU09r?=
 =?utf-8?B?UHM0WDhrOC90MDNkN3NJWXdESWFjZ3puOFhoREVQbStrR3NRS25pVFBTZExN?=
 =?utf-8?B?eVlQbEdjTTM3L2hSV3psR3BmT1Uwa0ZMcXl6OVhiQ05PQ214dTM2TGJYZUsv?=
 =?utf-8?B?Q0dUYnZlVXhVUDU2TlNsT0ZRSWQ4dk11WjlWRmRadndaVnpibk9BZFhPNHla?=
 =?utf-8?B?ZFg1bTlpMEhPSGxFdnRLVnYrWGJzSG5DTXhPdEV6ck9KKzN2MEphRkR3eWh1?=
 =?utf-8?B?VGFDNUNQVkpCR0s0M1dlbEhvUm5OaWpMdDZtVFpqMWwxbW1BWlBaWW1WNXBY?=
 =?utf-8?B?eHNaT2RTcXhYVFpuRGJSSUZMUDVGQlVSYk96WmpIUlVIcnRPVFFZR1k4a1N0?=
 =?utf-8?B?blJCdHBLMVJOMGEvR2JMQmpGQTZoK2lZTFo4OVJxVGJkbk9WZ2dmeDd1MXhB?=
 =?utf-8?B?UkpTMWpXNGdRdnVXdFJBR3ZTY0IyWG83dU1UVnk0UW5EemtYM1d5Q3huZ3BZ?=
 =?utf-8?B?bzNnK003dXRwZTZuRVFTVVNsR0N3MkptMVl1NUV2YjFJM2h4ekgyWWRacFFJ?=
 =?utf-8?B?V2Y0SVJWYkppaTZSZUtLQUwvamIwRnNCa3N0bEdHdmp4Ty9GejRSU0RicFhD?=
 =?utf-8?B?MlFqUnViV2lObzdLVkZmV0NGL3NnVk1nV2J2MWRKNjlZQlNKLzR0YnJzMC9u?=
 =?utf-8?B?K0FJZllaYjJPd2duRm5sOG5Xd01JVCtnTUx1bmpWakpRQy9SRTFLN29mbUp1?=
 =?utf-8?B?N2s2eHFOaEx0T3dGY3Z0VEZpNGMwak5CY0lWSjhITzFXSGpyTk15Wnc2c1Nq?=
 =?utf-8?B?Ukw2aTlDd2NtZUVWeUxUUldPNTRacTNQTGZsbkFsWFh3MW00aGR4Rm1ydXdv?=
 =?utf-8?B?alhVQjlaVU9TT3pydXhYVjYxakhWejJNR3BpaHdzVHhhS2pUdi9RTktYbWpl?=
 =?utf-8?B?aW82VzVQbUQxbmhsdmVaaGkyK3VXWDFGMzNBRnZlcTVSMGgwaVQ4Wlg1bWFh?=
 =?utf-8?B?aEpFanE2TVljdStMR3pKbUVBK0dUQjFKbFp2WkxmVzhWNjNaVE0va3doSUNv?=
 =?utf-8?B?WnpOaHllU2xyekdSN25vMWRtVTZSN3JVdDFkSjlxTEZDNWJhTGlLbU5PNDlF?=
 =?utf-8?B?MTY0RkRVR1FzQlRsNjJEeDk4K2lvY1dhdGlObVRmUnUvc1padkZ1NndNdXBP?=
 =?utf-8?B?VVNvUU1LeVJsNkZhUy9Bak83eFRrTCtlVW9oMTBoZmZDekFHSlNQd2NKU2RJ?=
 =?utf-8?B?cDM0Y3ZjK28vN1E0Z09yYWtWT2dieFZGSE5WcmtiendKT2dtQnpETDZ3aFZF?=
 =?utf-8?B?bEpCR3BLRmVXR0p2K1FxRkE0MSsrQWVjUXVMM3lRSUpPMmhvMmVtWncxWlh6?=
 =?utf-8?B?Q09vTUJzNWhtYzVYV0ZWSDVBbXBReDB2d1JXNExSdnVtM3BXd3grcXZsLysr?=
 =?utf-8?B?c3VSQUpWcGpYZGNEeG91SG56Q05JQThyWVF0ZTBGTkxlc3R0cWFzUGNoNTE5?=
 =?utf-8?B?TUZaUzdmNmVsaHhiWWdCMFhVcVlzdno3RkRxeUp6cEhtZFFUUXRCaEU5N29a?=
 =?utf-8?B?SDY5OC9pQlpLRUtuUE1tU3NLY2srUVlSbXR1MDdJOVp5M3VqRmFyaVJDMmlU?=
 =?utf-8?B?eTFJcFhRbUFGaDFad1owbUIxZkkzQ0M0VGRQalRkMnJKOGVaSGNnT2kwTElW?=
 =?utf-8?B?WFRFRlcyQ2U2V1lMN3dDNHlHanBKZVd4SUlqWnBkem83UDNUWG5KY1ZseWJq?=
 =?utf-8?B?SVhwVW5PamIzVHZpVDlYbmduSkU3RFpwdis4djdXdkxiNEZmZGpzZXJ1eVpq?=
 =?utf-8?B?MzYzZDJQVm1vTmVoTHdKUWM2Wk1OcEFOVDU4TjhrQVgvSDZUQ25JVzc4d2hq?=
 =?utf-8?Q?wfSIPTwWXcjSsk54xyocjZOljIpc3c=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2024 01:53:32.7581
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3caf6e6-7a03-4c3b-1df1-08dd22f49b4c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8253



On 11/18/24 23:07, Xu Yilun wrote:
> 
>>>> +obj-$(CONFIG_AMD_VERSAL_MGMT)                        += amd-vmgmt.o
>>> IMHO the naming vmgmt is hard to understand, any better idea?
>> The "v" stand for Versal. We would change to amd-vpci for Versal based pcie
> "v" + "pci" is quite a misleading term, maybe just versal-pci?

Hi Yilun,

I sent the V2 patch and refactored the driver as versal-pci now.
One more thing that I kept in V2 was the firmware_upload. I forgot to
mention that I'd love to switch to the newly proposed interface once
it is ready. I saw the proposal was now as config_fs and it was not 
merged yet.

Happy Holidays.

Thanks,
David

