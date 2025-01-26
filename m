Return-Path: <linux-fpga+bounces-1014-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE3AFA1CE41
	for <lists+linux-fpga@lfdr.de>; Sun, 26 Jan 2025 20:56:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2B1F1887C27
	for <lists+linux-fpga@lfdr.de>; Sun, 26 Jan 2025 19:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9E01632C8;
	Sun, 26 Jan 2025 19:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Un6iMaKX"
X-Original-To: linux-fpga@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B14156C74;
	Sun, 26 Jan 2025 19:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737921384; cv=fail; b=hr1XSHDF2QGJ/mGWTz+kCV8VxrVBDW5ZJH5IF1FHrjOOD4MnZKyCPQfKCH0MmzPhxHGxQqcPBXxg0alvRaEDl+lax38M9m7w3KCoMpl51pgFS0wjjc0vrPZRcCIiiHGuU+Gt5WMWRl1A9lHEEL81CAfEdIyTgQ7atDf2NQdwHzw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737921384; c=relaxed/simple;
	bh=VadaC94BUEbSr95vI1QQSk/wq9rJbjlX/JJnkLzQU04=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ej/uKUWz/KRPRnvOe3pf9TQOzVTpVnEHOUVy96GyKs0aaASy1yL+IDp+o55RHpWdx7BCikSmQtLYEpULq6y6rvaBDetkfML5iuNiVdl87rMYNVmARNQO5lYED+oJiCeMaPTChF18tequ8T/AdtjNtcqdq8m1JLwyv02FWhYU2mc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Un6iMaKX; arc=fail smtp.client-ip=40.107.243.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R2Ho6+cik9iIfR+SwbYlGbRYAUMJYi6f1aNTtYxS/zd4UY5y7KgCbIbU2x0aLa/uzQ7UMDJi4+kbVQ/fsBvxQGkS9vR++MIf1v5x0GzZDq4bQ8QyqYndbl7z36S4JeHSCes/utYDzb5m7PvyZ0TzwUH03+XjaL7+aCltMtkxkP2koD/lMw/c5LajlUjgphSqB2oT3sdlaUMeST+xGbTOizhZuft4MXIuWSQt4ouExwR2eD46C5Ss6oGPFTTARbNMmaPcDQmGbphvikX4hH34mTRnfjwo/YY0qlP8SDhxZoyo8n9XLqL3yKGdNq4A8Lj4Rv8h57RDVmJXa28Pokk9Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nHDzO2qqhbg4Ae5qTZGM09dVs1GoaLOfs6pJ9uDVtJQ=;
 b=ARxUeGzDwKcibkt/aRnYh6g81F92WEucJLf5zhck/YBBiujYZIxfGZjD+3Ltm1Tt9lR8U1WGclu36wjXiZyGqB0fLH1+PB84S1xuoi+Qg/IX4i7vxHtwIkw0ZE3iw5FMsg6/ip9r2gxme99NkzdUutwkyvA7CjtaVMtUr5hkDy6YIQNlh/95t4q9oRvuCdc9rzGMG/R1XJEYZFGmh1ZDBHI09PzlBEHEg7/AvETD6/vk7PzH3/xu5KMRKmvwGbgdJ/8SAJH84+DFj22PNd+Bv3lGuPmbpooNVdng8kWWmpC+zDMhkZ9pVsjYaTz0E8HAg+5RKk5GqPC1bOzXnUHiSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=wanadoo.fr smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nHDzO2qqhbg4Ae5qTZGM09dVs1GoaLOfs6pJ9uDVtJQ=;
 b=Un6iMaKXcL+Y1TNwIdOE52FLD3tn+aIBCgOl8ud3hEkDrYWuOpw3T0wcSAf+jdGTeAZCjYURD52POnxQRNZm/AI368Pvy/CUIyoibH2aLjEIzAYZL6YOY98iCM/soiVFbwRCJ9vPK5YynWVZAze4Q44k8NgqJCNxZh40//jlY1E=
Received: from CH5P222CA0019.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::20)
 by CY5PR12MB6156.namprd12.prod.outlook.com (2603:10b6:930:24::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Sun, 26 Jan
 2025 19:56:19 +0000
Received: from CH2PEPF0000013D.namprd02.prod.outlook.com
 (2603:10b6:610:1ee:cafe::ad) by CH5P222CA0019.outlook.office365.com
 (2603:10b6:610:1ee::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.22 via Frontend Transport; Sun,
 26 Jan 2025 19:56:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF0000013D.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Sun, 26 Jan 2025 19:56:18 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 26 Jan
 2025 13:56:18 -0600
Received: from [172.19.74.139] (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Sun, 26 Jan 2025 13:56:17 -0600
Message-ID: <b0a07e5a-fa0b-40fb-9d85-5f316f94a226@amd.com>
Date: Sun, 26 Jan 2025 11:56:17 -0800
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/4] drivers/fpga/amd: Add new driver amd versal-pci
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	<linux-kernel@vger.kernel.org>, <linux-fpga@vger.kernel.org>,
	<mdf@kernel.org>, <hao.wu@intel.com>, <yilun.xu@intel.com>
CC: <lizhi.hou@amd.com>, DMG Karthik <Karthik.DMG@amd.com>, Nishad Saraf
	<nishads@amd.com>, Prapul Krishnamurthy <prapulk@amd.com>, Hayden Laccabue
	<hayden.laccabue@amd.com>
References: <20241210183734.30803-1-yidong.zhang@amd.com>
 <20241210183734.30803-2-yidong.zhang@amd.com>
 <d156bc11-3d8e-44a0-b311-b4b931c54a7c@wanadoo.fr>
Content-Language: en-US
From: Yidong Zhang <yidong.zhang@amd.com>
In-Reply-To: <d156bc11-3d8e-44a0-b311-b4b931c54a7c@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB03.amd.com: yidong.zhang@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013D:EE_|CY5PR12MB6156:EE_
X-MS-Office365-Filtering-Correlation-Id: fd684ed3-34b1-40e4-3d25-08dd3e43802e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VHBKcXd4SnFIOXpDVTdPNjVBRnQvRWkvRDFDbzBFMUNTcnpZWXU0TitzVUJK?=
 =?utf-8?B?Q1dNM0xteDJNVzBqYUlmTGdUNmcra0hFRjVNbXZIQUdwZXE5R2hpZy9zMXN2?=
 =?utf-8?B?RlVXaU00M0ZIRk0vKzYycDhCUDNROGFLTEttQVZWVDRrTzJHdEQ1bERKSGYx?=
 =?utf-8?B?SWgzRE9hdS8zeHVrWXhkeGVTRWFCR0V0alFGOVlBTlJjRzdKWkhGYmorKzZP?=
 =?utf-8?B?UnlhbEhud1ZWbzhob0Jka1hZYi9SOUtDWEY5WHcxUW1IZGlpcmlJRTFkd1d0?=
 =?utf-8?B?QkNTSDJVUXZRaHpka25sNllvMGdrbnhkTVlGZkJEdVl2UlJVVENIdXdibHZO?=
 =?utf-8?B?R3FaVzJBelZrNk9SLzZMWG5XMytoWlIvc2NaNjRlZ1diZEdJSzRqekl3M1Z1?=
 =?utf-8?B?ZzdsU3FyQnNFT1RGYytKeHZ3VGJuRyt2Wnc0dDFFQS9sd3lWY3hZc0hEZ1Vi?=
 =?utf-8?B?K3BRMHkxcDA1R2hMZ0o2b3ZhR1JBVXZKc3M1clZxQUZ1N280Q0JFRG9aQTJV?=
 =?utf-8?B?Mjk0blNiODRPT2ZrcklWYWlwbGVYaVFhcDRaVmk4N1oyOVNYT1lkdGlNV0tJ?=
 =?utf-8?B?aGRxak9uR3p2M0RHYWVBbHZLa2p0M0dtSnZuY0RjN3FpQ1ptNktHb3psUlY0?=
 =?utf-8?B?eE9GQng0ekdVb0VLRXF1Z1p2QjJMQkUzbGVWcEwyb0lDU0MvSW83TWdML1BI?=
 =?utf-8?B?cW9QQ0xyRWNMcWhLaWFmMzV5K3hrS3BTTHFOZWdxdGFmRlJleGFrcXlXdndN?=
 =?utf-8?B?Z3l6NnprVll6anNmbUtwYXhpVVhpU1RFZm1TYjRCSEo3T1ozTGFxWnlRNnkw?=
 =?utf-8?B?OE1XNTJNV21GSitMaGRkeXZ5SUlNZFdCUlUxNVVpcHNqUTZJb1BCMFhkaU0x?=
 =?utf-8?B?blI2ZytkTDRBbkU0NjVVbHpvaGpRMFJSTUl1WHVFeUVzOGQzMWZ3YVBsZUhm?=
 =?utf-8?B?ZGtXSHhzWVNGSlBTR0lPM1RZUGhDTjRtSnpDaDVpM01MK1MzbnlzSmw3S0tt?=
 =?utf-8?B?TnQ1SFFuVXdtVi9QOFdTQUtHaVV5V3RGUEd1UjVGME9mRFM5enFIZkhaVXRI?=
 =?utf-8?B?bVRmZVdDNUN1V2FFWW1Vd2M5VDhEcmw1YzBoMnZCY1dscDhjVHFlWWFpbkJQ?=
 =?utf-8?B?NUw0dnlxRFpSYjFRS2lyUVhoeHduWGlaV25QaENnMlQ4Ykgrb3BXOXZIKzRm?=
 =?utf-8?B?T1B3ZUpaZGdsUEFjOWpRQnBxaUpnd1pkQ0RyQlRMbDN4K1ArTENtcFdWTnVH?=
 =?utf-8?B?VnlUc2oxSDFaNms0aWsyMktYUDNvOXQ2TDM3a0JWOWN5VmI2dSsvTzZacWk0?=
 =?utf-8?B?VUVnSkFad1kyRiswMEdHUE9YeVBpYWUwOU8vUXlzZzN6RUwzQ3FrNWdBeFJs?=
 =?utf-8?B?OXM1aWlxWGpyMGRlbjF4RFJPeGpxQmZaY2hIOGJocDhGOVV4aGdzK3hrM3hX?=
 =?utf-8?B?RG1OYjBlUUVCOEFKRmFua2ZHSnYrOUM4amxvQ05xTU51K2psd0xwdzB6Y0NU?=
 =?utf-8?B?dENuam13TFFmT1diOWxwN01nQVdCMUhQY2o4T2JDVHQ0U0RpQ29JMjIwS25m?=
 =?utf-8?B?MzBXTXp2N2JNcVNIaFZDR0hUdGtFSHRQcGJvMUxuV2VleHo5eDRHOW5hTko5?=
 =?utf-8?B?MkdyTjc5Slo5UFJWSDBiZkNkcWxFVWVzUGVLQXdsOTdoWmtQVFBxcVY1TUdZ?=
 =?utf-8?B?VjBHdVRJa3pwZS9oN2RjckFPNkY4ZjRzNFk2SENvNllRSEk0UngwN1E0dWdT?=
 =?utf-8?B?ODlDd1ZsZkZ0QlNrNG4rV0pPZ1JSRDF0SS9SV3VWVkV5bWdEK01kd2Z2K3pS?=
 =?utf-8?B?YjhaeHowTkRlMEZyWHkrY2sraFNTSzdEcnR1ZXk5eHFuTlJpSnJRMFJNTGsz?=
 =?utf-8?B?SWlWMHR3SWFjbzluNGcvUlpmZERGbXhqblk4WTEzYjZSWmFybkx6UVdsOFdy?=
 =?utf-8?B?c3dGRWJUK2FEbnVXUXp3ZG5JOHJJT2x5NU5VL3o4cjJnTlpjQ0xZVmR3dU9U?=
 =?utf-8?Q?wfgsW+KO1a01sm3OU1SrIB5NHuJYHU=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2025 19:56:18.9942
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd684ed3-34b1-40e4-3d25-08dd3e43802e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6156



On 1/26/25 02:12, Christophe JAILLET wrote:
> Caution: This message originated from an External Source. Use proper 
> caution when opening attachments, clicking links, or responding.
> 
> 
> Le 10/12/2024 à 19:37, Yidong Zhang a écrit :
>> AMD Versal based PCIe card, including V70, is designed for AI inference
>> efficiency and is tuned for video analytics and natural language 
>> processing
>> applications.
> 
> ...
> 
>> +static void versal_pci_uuid_parse(struct versal_pci_device *vdev, 
>> uuid_t *uuid)
>> +{
>> +     char str[UUID_STRING_LEN];
>> +     u8 i, j;
>> +
>> +     /* parse uuid into a valid uuid string format */
>> +     for (i  = 0, j = 0; i < strlen(vdev->fw_id) && i < sizeof(str); 
>> i++) {
> 
> Unneeded extra space in "i  = 0"

Great catch! I will fix this.

> 
> I think that the compiler already does it on its own, but the strlen
> could be computed before the for loop.

I will change the code.

> 
>> +             str[j++] = vdev->fw_id[i];
>> +             if (j == 8 || j == 13 || j == 18 || j == 23)
>> +                     str[j++] = '-';
>> +     }
>> +
>> +     uuid_parse(str, uuid);
>> +     vdev_info(vdev, "Interface uuid %pU", uuid);
>> +}
>> +
>> +static struct fpga_device *versal_pci_fpga_init(struct 
>> versal_pci_device *vdev)
>> +{
>> +     struct device *dev = &vdev->pdev->dev;
>> +     struct fpga_manager_info info = { 0 };
> 
> Is the { 0 } needed?
> Isn't the assigment below enough?

Right. I will remove the unnecessary { 0 }.

> 
>> +     struct fpga_device *fdev;
>> +     int ret;
>> +
>> +     fdev = devm_kzalloc(dev, sizeof(*fdev), GFP_KERNEL);
>> +     if (!fdev)
>> +             return ERR_PTR(-ENOMEM);
>> +
>> +     fdev->vdev = vdev;
>> +
>> +     info = (struct fpga_manager_info) {
>> +             .name = "AMD Versal FPGA Manager",
>> +             .mops = &versal_pci_fpga_ops,
>> +             .priv = fdev,
>> +     };
>> +
>> +     fdev->mgr = fpga_mgr_register_full(dev, &info);
>> +     if (IS_ERR(fdev->mgr)) {
>> +             ret = PTR_ERR(fdev->mgr);
>> +             vdev_err(vdev, "Failed to register FPGA manager, err 
>> %d", ret);
>> +             return ERR_PTR(ret);
>> +     }
>> +
>> +     /* Place holder for rm_queue_get_fw_id(vdev->rdev) */
>> +     versal_pci_uuid_parse(vdev, &vdev->intf_uuid);
>> +
>> +     return fdev;
>> +}
> 
> ...
> 
>> +static struct firmware_device *versal_pci_fw_upload_init(struct 
>> versal_pci_device *vdev)
>> +{
>> +     struct device *dev = &vdev->pdev->dev;
>> +     struct firmware_device *fwdev;
>> +     u32 devid;
>> +
>> +     fwdev = devm_kzalloc(dev, sizeof(*fwdev), GFP_KERNEL);
>> +     if (!fwdev)
>> +             return ERR_PTR(-ENOMEM);
>> +
>> +     devid = versal_pci_devid(vdev);
>> +     fwdev->name = kasprintf(GFP_KERNEL, "%s%x", DRV_NAME, devid);
> 
> Why is fwdev managed, and not fwdev->name?
> It looks ok as-is, but using devm_kasprintf() would save a few lines of
> code.

I will change the code. Great suggestion.

> 
>> +     if (!fwdev->name)
>> +             return ERR_PTR(-ENOMEM);
>> +
>> +     fwdev->fw = firmware_upload_register(THIS_MODULE, dev, fwdev->name,
>> +                                          &versal_pci_fw_ops, fwdev);
>> +     if (IS_ERR(fwdev->fw)) {
>> +             kfree(fwdev->name);
>> +             return ERR_CAST(fwdev->fw);
>> +     }
>> +
>> +     fwdev->vdev = vdev;
>> +
>> +     return fwdev;
>> +}
> 
> ...
> 
>> +static int versal_pci_probe(struct pci_dev *pdev, const struct 
>> pci_device_id *pdev_id)
>> +{
>> +     struct versal_pci_device *vdev;
>> +     int ret;
>> +
>> +     vdev = devm_kzalloc(&pdev->dev, sizeof(*vdev), GFP_KERNEL);
>> +     if (!vdev)
>> +             return -ENOMEM;
>> +
>> +     pci_set_drvdata(pdev, vdev);
>> +     vdev->pdev = pdev;
>> +
>> +     ret = pcim_enable_device(pdev);
>> +     if (ret) {
>> +             vdev_err(vdev, "Failed to enable device %d", ret);
>> +             return ret;
>> +     }
>> +
>> +     vdev->io_regs = pcim_iomap_region(vdev->pdev, MGMT_BAR, DRV_NAME);
>> +     if (IS_ERR(vdev->io_regs)) {
>> +             vdev_err(vdev, "Failed to map RM shared memory BAR%d", 
>> MGMT_BAR);
>> +             return PTR_ERR(vdev->io_regs);
>> +     }
>> +
>> +     ret = versal_pci_device_setup(vdev);
>> +     if (ret) {
>> +             vdev_err(vdev, "Failed to setup Versal device %d", ret);
>> +             return ret;
>> +     }
>> +
>> +     vdev_dbg(vdev, "Successfully probed %s driver!", DRV_NAME);
> 
> Usually, such debug messages are not needed.
> No strong opinion about it.

I will remove this. The dbg only enable in the debug kernel, but this 
line isn't necessary. I will fix it.

> 
>> +     return 0;
>> +}
> 
> ...
> 
> CJ

