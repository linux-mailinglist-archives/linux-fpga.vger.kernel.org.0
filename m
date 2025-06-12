Return-Path: <linux-fpga+bounces-1238-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 460E7AD6B9E
	for <lists+linux-fpga@lfdr.de>; Thu, 12 Jun 2025 11:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 663F718980DA
	for <lists+linux-fpga@lfdr.de>; Thu, 12 Jun 2025 09:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA3D221FD0;
	Thu, 12 Jun 2025 09:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PmIPIlO5"
X-Original-To: linux-fpga@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2048.outbound.protection.outlook.com [40.107.100.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20873221F3E;
	Thu, 12 Jun 2025 09:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749719128; cv=fail; b=MvpyLMT64eqWIoe8aXOHAg5Qp2nZLny59XHwQP5nF2SaXY0/ERefq/+T/SxpV02j6cxONshKEqChOAUtR/wTv6+slzxLq1wPWFNBOIq8iPO+mXn6iFSmuSrZeS8Vlh8N4UPiKHZ9El8nWsgZdaVUwBQbpG61g5/V/dUYVIiQSnA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749719128; c=relaxed/simple;
	bh=w1Ob7igJX09TISSlBVVHyVNCYXamDR166hTS7y0hbKk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=myI0xoF7VDNf1X9s/fiaQsC6Ah8XBFSTTyz8GwA/Au6YxJ1McEb4TP0eq7l52wsKtQnh4gMfv98ZZlE5/vIGZw13VCRQFgOlGmKDz5ansLmz5pzt/HbMR+W0YhlmcpNoXgLoZDhzJP6PSjVRgCZi1WSvbuFAUF6gIf6ZTFpcE7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PmIPIlO5; arc=fail smtp.client-ip=40.107.100.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e8eAY4sNX6Tp7oT6hu6u6Ls03u2oXFqbm7hQUqKjr41H6WIVjpl0O9MDBLsl05hyXAK5W1HIKlLfoAIbd5XKG3o66gMQbJ4tJY7uQqmBXlfEp/ebnSm7FpT5ubh3KBb18ajAJd7AM1Xb6/N0PnLMnQYtzR8R/Lm4weLE+D+HRzsdcKEj3fSB4zm8fh6v4DIjG+xnYfFf0QAsDT6itNHsoX/7PsQUwucPq2qXqWWTpmym767qFea1Gj2UPF+IB4o1BTz/tuSzsC28DiTpOdRqYKNy5EBl4pVCsofPNgSDtaXJT5xeOHIRtl8mEH8D30KT6jJt59QmsIYBQwW/ytusxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hGZ+8AhIL8j4OcHvPzdDIH5wL0zn4viAVmwtSRvJHMY=;
 b=rrx8fs8AwvQ+P21HmCMN8huS915eiwWHaHyIlpR9Tkx/uvoPgerHUhd6qiyI18x4UTC1GF2w5cDTBdGnuThd9RpED4iqwUUUS3/VrLWMFcejK3+UkRUvaIQjkZofir6H3rKC8mq+5BshIG1QfNvFJr2jask3nooNpCnKX2jN6oxY32iQNEDgGE3FZPNCtcUGoL/Jd8pfmERn5tDwOtzGaQeU8izIUk404L5KMrc4vPbYJFzbw/2SFCQUxqfP8yPxZrp2qw0kO3RR8ywds6pLvzhBb4DQ2KzT0D4sBHHM+KtIrgVzvDLlFgYAzxIjdjGn+bo2e8KnVwq8AtHzSoB39w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hGZ+8AhIL8j4OcHvPzdDIH5wL0zn4viAVmwtSRvJHMY=;
 b=PmIPIlO5mRgPrleacQdy4gLUSTzFevEgp5/JlY9VLuh6QMtkBe743Ylp8Hp7zSTE14DiZxIHccqFAxH71SKYh7WCqU2P8AbuKQ0s2F3Ne3epj8vcQDUH9cTI8LA2EGOMZdb4Huzui9LwC6CJJQLSV//BPkdue122hXlwA8Me/6Q=
Received: from DS7PR12MB6070.namprd12.prod.outlook.com (2603:10b6:8:9e::14) by
 DS7PR12MB6310.namprd12.prod.outlook.com (2603:10b6:8:95::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8792.34; Thu, 12 Jun 2025 09:05:21 +0000
Received: from DS7PR12MB6070.namprd12.prod.outlook.com
 ([fe80::b847:e013:8f93:f6e4]) by DS7PR12MB6070.namprd12.prod.outlook.com
 ([fe80::b847:e013:8f93:f6e4%7]) with mapi id 15.20.8835.018; Thu, 12 Jun 2025
 09:05:21 +0000
From: "Manne, Nava kishore" <nava.kishore.manne@amd.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
CC: "mdf@kernel.org" <mdf@kernel.org>, "hao.wu@intel.com" <hao.wu@intel.com>,
	"yilun.xu@intel.com" <yilun.xu@intel.com>, "trix@redhat.com"
	<trix@redhat.com>, "robh@kernel.org" <robh@kernel.org>,
	"saravanak@google.com" <saravanak@google.com>, "linux-fpga@vger.kernel.org"
	<linux-fpga@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "git (AMD-Xilinx)" <git@amd.com>
Subject: RE: [RFC v3 1/1] fpga-region: Introduce ConfigFS interface for
 runtime FPGA configuration
Thread-Topic: [RFC v3 1/1] fpga-region: Introduce ConfigFS interface for
 runtime FPGA configuration
Thread-Index: AQHbyHAvjfKTIyDsoE6M6pJ/SBy77bPue0MAgBDjfuA=
Date: Thu, 12 Jun 2025 09:05:21 +0000
Message-ID:
 <DS7PR12MB607015CAB2781E16A4EC110ECD74A@DS7PR12MB6070.namprd12.prod.outlook.com>
References: <20250519033950.2669858-1-nava.kishore.manne@amd.com>
 <20250519033950.2669858-2-nava.kishore.manne@amd.com>
 <aDxrUD9YjnFkWy3M@yilunxu-OptiPlex-7050>
In-Reply-To: <aDxrUD9YjnFkWy3M@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-06-12T08:55:58.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6070:EE_|DS7PR12MB6310:EE_
x-ms-office365-filtering-correlation-id: fb2ba0e8-d709-4d2c-b9ee-08dda99042a9
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?OLiWnEhn5DO7kECGveG1zsTQJwL1E3HK+YS/wqwoM7kt+1XAK6K+R335bFRf?=
 =?us-ascii?Q?XAGZ2Rbh6E9uQ6FrKej25WJhVyRS0rcrW8UIAZVUkvcfyYwGsqvl/2o1Juk5?=
 =?us-ascii?Q?8phzomyqfexnb4Qe46SXZQ59FKYeLATobROzRj5vt6jtS+0Esv0Cr0OwsdLr?=
 =?us-ascii?Q?FWGckLf25SyzhiHbeDD2fU4Sefc+8skgtVmMSkq07VXKT7FW+BX5hpPcs7o2?=
 =?us-ascii?Q?TXwuUhpKoYrEvon0wKPUFMMyNxBIfxbFN+Djh3CgH8/18oZaFO0saA8vqtF3?=
 =?us-ascii?Q?6pqKmaHqkLkT0Er4FePEjQZo/9bJO1cgxubkQ3W1vKa0K02U3x0oViqm/VQZ?=
 =?us-ascii?Q?3E42MAkjGA6j91J9Z2SgjCm/5eNbt+I85bDG0tNeDOiqkgz3g78n/wCRp5XS?=
 =?us-ascii?Q?dvgrlEgwdZVd3qPGY74eRL1LbP8of5XxaHJlgKqVd7pua2ZW7097+0yEqXHH?=
 =?us-ascii?Q?EyaFTOlKabSu+wncNmp159UZVEl38K7mYwc8uutITqcYPS5dt8ZmyWn+i1ee?=
 =?us-ascii?Q?x3UyZKdKLBmKsWIN1r9elDzd1EC0SzoFEPHI22hayPwcS8Z0Vfiu8ulsE7Aa?=
 =?us-ascii?Q?Dg5x3vbAPiYTGUi70YKHgtxS4wIgk2LVEbQhkAv9hi7hgt0RlGh76Czj9GNj?=
 =?us-ascii?Q?t6lnpanKBeNBWfMB1dfHVSHUQroSW1pcL9WCIF+i4ohimEH4xHiDNqsibBOW?=
 =?us-ascii?Q?SptJbgULvLsDUs1hWr/mh/x8n5Q5x1yKSWZSaoc8tdNKOsGVS1sA7F6Bx3jY?=
 =?us-ascii?Q?maZrRSaUvNnMEdiJl8ZmzmBmUUpnW/1mGfuf3TNnQcLnlpuvDVK+6JvBPW4v?=
 =?us-ascii?Q?J5Fgtxi/S8Xg4aMCs4kxlniuodPXicwtR2x9+7HdUD5VnegWwJ4SIKca9B5h?=
 =?us-ascii?Q?6c8m5pVptx15S6L9xPibaLZboizNMDELO7lxIKPa+MCMHW21YstD+3mG70SR?=
 =?us-ascii?Q?nTQfDQ90bojntlTjZXpXKyOY+YmyBOuEUZGx4P6ICGq5asAvSJEEXk98oW1J?=
 =?us-ascii?Q?FNIJK5L2y1yvSgeXNArdYh6QccaVOxrAqHblmD0/DG4ifoDHWag1my4P6m/P?=
 =?us-ascii?Q?/FYLrRoJIzAuLX6UFkquIszmKyavoJ+dKGzVzt4qP/P06hAZBdDrgsE6rfbO?=
 =?us-ascii?Q?6jTR7fZ84KD5qiYIgxJMlD6GpogVrzbgCYspZC1Fq7ME3K6qrlRPENZhbTAI?=
 =?us-ascii?Q?XGed6q1OIeVZ9taNjbrVdrelyRqG6FGWJi+JLFrdgr7+X36dXUvcvEkmI4ty?=
 =?us-ascii?Q?k3yVcheEVCGpZPHhSHk0tK8Zuj6qCQNuK1HL7SZb4/h3ZFGHE88n8agHdev6?=
 =?us-ascii?Q?A51HQqaOVnJsJAzu3FojBY4KO/isAfIuufH2JHN4QPHcNa8bvIwYfjM6lsJ3?=
 =?us-ascii?Q?ohSLwSN2XV4fr26RX5wZPBiKStcNQFumOlh0FhSE/dTeesjAV32+gh4+I2w1?=
 =?us-ascii?Q?BQkc68tYlTFWNFDIfgsR0nsP+TpZup+YpvvPIB+OAXYwFh6cFgg/Y/RQEH85?=
 =?us-ascii?Q?Jm3ZVVvLM7br2Go=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?W1wVRB3bkVMQmO9pPnCvlOFzGpbCDi/JWUx6DVlm/i0GLarzW1ylj0I4Iu/Z?=
 =?us-ascii?Q?P4Ap2gAfsutJQMX08ILIkcaT2wvFa3xTMhtyfPE8t9rapFTH68B+/ojCWcGY?=
 =?us-ascii?Q?5Urzf9cWzb9Y6JL0rpFrPTSNLrJZKTBqh/Z53XfPHoULg2vbzcPoCvpFNEnL?=
 =?us-ascii?Q?OIpApq9nwUKy0ql0U78gC4JnIPCrrRab80u82f1LFEp43zIeQ1b/I3cgTLen?=
 =?us-ascii?Q?cPBvqLxwQmp4Qn76qdn00L/BUHF7LIEJMcMQSu0OfhUjyVWAsu+zpCfCZBdh?=
 =?us-ascii?Q?lYdvIe1CpGWJsR8nLY+YA8IwgQSq2oRb77wU6x9U/X9Ts3l87U1+QydZQVdj?=
 =?us-ascii?Q?qMDvUWIf4RgEPnDNZxpjLYlPWeLBFev3W7pBJ+C/VGMAQly4XdH7gJsLA2qV?=
 =?us-ascii?Q?uVjojzGHixyZ/ybak6jyIuIj40Atpru6H9v9APAVlxTDWc2O0xM8M58Hm11l?=
 =?us-ascii?Q?0DDMW0A1UGC5TE6AdzuDPu/apkGMvcDbnsmXEtWuHCF6n01zShCayYa184dK?=
 =?us-ascii?Q?nuZlCuqhMPpjMIkM0fRYXcazLQcerlrWNNSOcQzm+pXKVW5K1/qTkEoJERQB?=
 =?us-ascii?Q?UuTFvhjMLsFtb9BtYMuopRXJ6MfsPPgxNEi6TeOv6DQCuBR4Gk37HyrqGl4a?=
 =?us-ascii?Q?BmNPi96+wLRHM/sKG9ss0Dnv0O3aHki8je3SKv2Erodfl8EU74MXe2DBhlh5?=
 =?us-ascii?Q?DSC5XlhU4+thVtkrL+XMkIDyvEVWR3rblfKrd5YBvjzghgMXSfEFMYYRSBSi?=
 =?us-ascii?Q?zoq4QyMsAZFHLp9VzPsyKLXgiRRhEXp13c3h+UFYFG5rSvWQjxsoM4vPeJHS?=
 =?us-ascii?Q?UiDdXhzR9b8Gge2C2gm8YRKTsHcKowY0oZ0jpxg7pnN0OjWLxCQZ0ezetSHn?=
 =?us-ascii?Q?GKMhI3d7scjByYwOEHD6x6sSxwS8lYQfNv52CjskzWdEgmvddg9AXCZxu5jP?=
 =?us-ascii?Q?/tan84D0rEo0F/IxNfgc5HvLllKawgRwHJkdRcdnlIGKVVPdvd8BZMlg8OtU?=
 =?us-ascii?Q?X1aJEOt2fRWbfok90D9/MetWR2stz7pfxd5sF8cx4ruHDAIvPBacgO/emddg?=
 =?us-ascii?Q?9xV2eAJFqeUJmBp+AKxamdC1nMi/as8D+QuUzprQWVjdQsVYtUY1SEQj9fK/?=
 =?us-ascii?Q?gweAE6ntsEDZBk/x+VOVnSBkQuoTBzpgGwVAidv+Dwi5ljV4zaHj48dt2A/n?=
 =?us-ascii?Q?0N+AdPAqjPAZoUlSQUkJCQmSeNg2WWtXrhJQd0xdXgheiLLIXRkaunXLVH2M?=
 =?us-ascii?Q?loxib3GOSXT8j2k8KLWfDY6SZ6eXpnhLGvkR3V6f2aI0lNemBKpbZGU/f2dQ?=
 =?us-ascii?Q?Mar2dBiHNGQdBfqwRRjaxqcEUi00URmb2Apkx7FAubCCKHiPP0tTAjbmEo6p?=
 =?us-ascii?Q?vGU3m6OyR8tnscpgcnIIz/MPDPD1yrUyEtdKsEWoKQlIjLMCNTE3AxF6NPfG?=
 =?us-ascii?Q?6gDu3ZvbDwfp3q5ymr9cgsvCFatFqff6gIAGSwIHgmM9NT00BXutfR8xTKJk?=
 =?us-ascii?Q?JyJBd8VkUFmD5It5yGUFz483IbfQACyrxHrDf2cg/LwPcer8hMmwvZlMIv8u?=
 =?us-ascii?Q?Wq0UEWUjmS006iYkH0g=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb2ba0e8-d709-4d2c-b9ee-08dda99042a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2025 09:05:21.4999
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8PpnyPtFUonvv5A/mfhDCrXmcGOhkispyUAwoJLSzci6YZ4iquXkyxeaEcCHEhZW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6310

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Yilun,

        Thanks for quick response.
Please find my response inline.

> -----Original Message-----
> From: Xu Yilun <yilun.xu@linux.intel.com>
> Sent: Sunday, June 1, 2025 8:32 PM
> To: Manne, Nava kishore <nava.kishore.manne@amd.com>
> Cc: mdf@kernel.org; hao.wu@intel.com; yilun.xu@intel.com; trix@redhat.com=
;
> robh@kernel.org; saravanak@google.com; linux-fpga@vger.kernel.org; linux-
> kernel@vger.kernel.org; devicetree@vger.kernel.org; git (AMD-Xilinx)
> <git@amd.com>
> Subject: Re: [RFC v3 1/1] fpga-region: Introduce ConfigFS interface for r=
untime
> FPGA configuration
>
> On Mon, May 19, 2025 at 09:09:37AM +0530, Nava kishore Manne wrote:
> > Introduces an ConfigFS interface within the fpga-region subsystem,
> > providing a generic and standardized mechanism for configuring (or)
> > reprogramming FPGAs during runtime. The newly added interface supports
> > both OF (Open Firmware) and non-OF devices, leveraging vendor-specific
> > callbacks (e.g., pre_config, post_config, removal, and status) to
> > accommodate a wide range of device specific configurations.
> >
> > The ConfigFS interface ensures compatibility with both OF and non-OF
> > devices, allowing for seamless FPGA reprogramming across diverse
> > platforms.
> >
> > Vendor-specific callbacks are integrated into the interface, enabling
> > custom FPGA pre_config, post_config, removal, and status reporting
> > mechanisms, ensuring flexibility for vendor implementations.
> >
> > This solution enhances FPGA runtime management, supporting various
> > device types and vendors, while ensuring compatibility with the
> > current FPGA configuration flow.
> >
> > Signed-off-by: Nava kishore Manne <nava.kishore.manne@amd.com>
> > ---
> > Changes for v3:
> >  - As discussed with Yilun, the implementation continues to use a
> > callback-based  approach to seamlessly support both OF (Open Firmware)
> > and non-OF devices via  vendor-specific hooks. Additionally, the
> > earlier IOCTL-based interface has been  replaced with a more suitable
> > ConfigFS-based mechanism to enable runtime FPGA  configuration.
> >
> > Changes for v2:
> >  - As discussed with Yilun, the implementation has been modified to
> > utilize a  callback approach, enabling seamless handling of both OF and=
 non-OF
> devices.
> >
> >  - As suggested by Yilun in the POC code, we have moved away from
> > using  void *args  as a parameter for ICOTL inputs to obtain the
> > required user inputs. Instead, we are  utilizing the
> > fpga_region_config_info structure to gather user inputs. Currently,
> > this structure is implemented to support only OF devices, but we intend=
 to extend
> it by incorporating new members to accommodate non-OF devices in the futu=
re.
> >
> >  drivers/fpga/fpga-region.c       | 196 +++++++++++++
> >  drivers/fpga/of-fpga-region.c    | 474 +++++++++++++++++--------------
> >  include/linux/fpga/fpga-region.h |  34 +++
> >  3 files changed, 493 insertions(+), 211 deletions(-)
> >
> > diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
> > index 753cd142503e..d583fc22955b 100644
> > --- a/drivers/fpga/fpga-region.c
> > +++ b/drivers/fpga/fpga-region.c
> > @@ -5,6 +5,7 @@
> >   *  Copyright (C) 2013-2016 Altera Corporation
> >   *  Copyright (C) 2017 Intel Corporation
> >   */
> > +#include <linux/configfs.h>
> >  #include <linux/fpga/fpga-bridge.h>
> >  #include <linux/fpga/fpga-mgr.h>
> >  #include <linux/fpga/fpga-region.h>
> > @@ -180,6 +181,158 @@ static struct attribute *fpga_region_attrs[] =3D =
{
> > };  ATTRIBUTE_GROUPS(fpga_region);
> >
> > +static struct fpga_region *item_to_fpga_region(struct config_item
> > +*item) {
> > +   return container_of(to_configfs_subsystem(to_config_group(item)),
> > +                       struct fpga_region, subsys);
> > +}
> > +
> > +/**
> > + * fpga_region_image_store - Set firmware image name for FPGA region
> > + * This function sets the firmware image name for an FPGA region throu=
gh
> configfs.
> > + * @item: Configfs item representing the FPGA region
> > + * @buf: Input buffer containing the firmware image name
> > + * @count: Size of the input buffer
> > + *
> > + * Return: Number of bytes written on success, or negative errno on fa=
ilure.
> > + */
> > +static ssize_t fpga_region_image_store(struct config_item *item,
> > +const char *buf, size_t count) {
> > +   struct fpga_region *region =3D item_to_fpga_region(item);
> > +   struct device *dev =3D &region->dev;
> > +   struct fpga_image_info *info;
> > +   char firmware_name[NAME_MAX];
> > +   char *s;
> > +
> > +   if (region->info) {
> > +           dev_err(dev, "Region already has already configured.\n");
> > +           return -EINVAL;
> > +   }
> > +
> > +   info =3D fpga_image_info_alloc(dev);
> > +   if (!info)
> > +           return -ENOMEM;
> > +
> > +   /* copy to path buffer (and make sure it's always zero terminated *=
/
> > +   count =3D snprintf(firmware_name, sizeof(firmware_name) - 1, "%s", =
buf);
> > +   firmware_name[sizeof(firmware_name) - 1] =3D '\0';
> > +
> > +   /* strip trailing newlines */
> > +   s =3D firmware_name + strlen(firmware_name);
> > +   while (s > firmware_name && *--s =3D=3D '\n')
> > +           *s =3D '\0';
> > +
> > +   region->firmware_name =3D devm_kstrdup(dev, firmware_name,
> GFP_KERNEL);
> > +   if (!region->firmware_name)
> > +           return -ENOMEM;
> > +
> > +   region->info =3D info;
> > +
> > +   return count;
> > +}
> > +
> > +/**
> > + * fpga_region_config_store - Trigger FPGA configuration via configfs
> > + * @item: Configfs item representing the FPGA region
> > + * @buf: Input buffer containing the configuration command (expects
> > +"1" to program, "0" to remove)
> > + * @count: Size of the input buffer
> > + *
> > + * If the input is "1", this function performs:
> > + *   1. region_pre_config() (if defined)
>
> Please define explicit workflow, and explicit expectation for each callba=
ck, or this
> framework makes no sense. From your of-fpga-region implementation, seems
> pre_config() means "parse image", post_config() means "populate devices".
>
> > + *   2. Bitstream programming via fpga_region_program_fpga() (unless e=
xternal
> config flag is set)
> > + *   3. region_post_config() (if defined)
> > + *
> > + * If the input is "0", it triggers region_remove() (if defined).
> > + *
> > + * Return: Number of bytes processed on success, or negative errno on =
failure.
>
> Please put the uAPI description in Documentation/ABI/testing. Then we cou=
ld know
> the file path layout from userspace POV.
>
> > + */
> > +static ssize_t fpga_region_config_store(struct config_item *item,
> > +                                   const char *buf, size_t count)
> > +{
> > +   struct fpga_region *region =3D item_to_fpga_region(item);
> > +   int config_value, ret =3D 0;
> > +
> > +   /* Parse input: must be "0" or "1" */
> > +   if (kstrtoint(buf, 10, &config_value) || (config_value !=3D 0 && co=
nfig_value !=3D
> 1))
> > +           return -EINVAL;
> > +
> > +   /* Ensure fpga_image_info is available */
> > +   if (!region->info)
> > +           return -EINVAL;
> > +
> > +   if (config_value =3D=3D 1) {
> > +           /* Pre-config */
> > +           if (region->region_ops->region_pre_config) {
> > +                   ret =3D region->region_ops->region_pre_config(regio=
n);
> > +                   if (ret)
> > +                           return ret;
> > +           }
> > +
> > +           /* Program bitstream if not external */
> > +           if (!(region->info->flags & FPGA_MGR_EXTERNAL_CONFIG)) {
> > +                   ret =3D fpga_region_program_fpga(region);
> > +                   if (ret)
> > +                           return ret;
> > +           }
> > +
> > +           /* Post-config */
> > +           if (region->region_ops->region_post_config) {
> > +                   ret =3D region->region_ops->region_post_config(regi=
on);
> > +                   if (ret)
> > +                           return ret;
> > +           }
> > +
> > +   } else {
> > +           /* Remove configuration */
> > +           if (region->region_ops->region_remove) {
> > +                   ret =3D region->region_ops->region_remove(region);
> > +                   if (ret)
> > +                           return ret;
> > +           }
> > +   }
> > +
> > +   return count;
> > +}
> > +
> > +/* Define Attributes */
> > +CONFIGFS_ATTR_WO(fpga_region_, image);
> CONFIGFS_ATTR_WO(fpga_region_,
> > +config);
> > +
> > +/* Attribute List */
> > +static struct configfs_attribute *fpga_region_config_attrs[] =3D {
> > +   &fpga_region_attr_image,
> > +   &fpga_region_attr_config,
> > +   NULL,
> > +};
> > +
> > +/* ConfigFS Item Type */
> > +static const struct config_item_type fpga_region_item_type =3D {
> > +   .ct_attrs =3D fpga_region_config_attrs,
> > +   .ct_owner =3D THIS_MODULE,
> > +};
>
> I think this is still the sysfs methodology. My understanding from config=
fs.rst is, use
> userspace interfaces to control the lifecycle of a kernel object.
>
> Now for existing kernel reprogramming flow, the image object for fpga_reg=
ion is the
> struct fpga_image_info. We need to associate the struct with a config_ite=
m: alloc the
> struct fpga_image_info instance by mkdir, expose necessary fields
> (enable_timeout_us, disable_timeout_us, firmware_name, and the most impor=
tant for
> of-fpga-region - overlay blob ...) for user to fill/query via configfs at=
tributes. And finally
> use a writeable attribute (e.g. load) to trigger fpga_region_program_fpga=
().
>

Thanks for the inputs. We've now implemented a ConfigFS-based reprogramming
interface for fpga_region that aligns with the intended lifecycle-driven mo=
del
described in configfs.rst.

New Interface Usage Instructions:
# 1. Mount configfs (if not already mounted)
mkdir -p /configfs
mount -t configfs configfs /configfs

# 2. Create a region directory (e.g., region0)
mkdir /configfs/fpga_regions/region0

# 3. Copy your bitstream or overlay files to firmware path
cp pl.dtbo /lib/firmware/

# 4. Set the firmware name (e.g., overlay .dtbo)
echo pl.dtbo > /configfs/fpga_regions/region0/image

# 5. Trigger Programming/reprogramming
echo 1 > /configfs/fpga_regions/region0/config

# 6. Unload/Reset the Programmable Logic
echo 0 > /configfs/fpga_regions/region0/config

Summary of Changes:
->Lifecycle Management:
    ->On mkdir /configfs/fpga_regions/regionX, we allocate and associate
       a struct fpga_image_info to the corresponding fpga_region.
    ->On rmdir, we clean up the associated image info via the new
       fpga_regions_drop_item() callback.
->Device Lookup:
    ->class_find_device_by_name() is now used in fpga_regions_make_item()
       to map a region name (e.g., region0) directly to a registered
       fpga_region device.

Please share your thoughts on this approach.

Regards,
Navakishore.

