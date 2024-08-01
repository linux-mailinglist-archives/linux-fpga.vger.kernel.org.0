Return-Path: <linux-fpga+bounces-588-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF05494423B
	for <lists+linux-fpga@lfdr.de>; Thu,  1 Aug 2024 06:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 309191F2354C
	for <lists+linux-fpga@lfdr.de>; Thu,  1 Aug 2024 04:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D5D13D897;
	Thu,  1 Aug 2024 04:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1V/Nn8Dd"
X-Original-To: linux-fpga@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2061.outbound.protection.outlook.com [40.107.95.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930DDEC2;
	Thu,  1 Aug 2024 04:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722486349; cv=fail; b=B0YaE3j5rIlm3qrckxS4nPKH7vRjAxGJUCAI8yVVAGme/gN+5fnCiIXrTSIRRyB1sYN6XB1Dy6S3nh5T2V9SlsfxNE6VCQerWJ5HNyYJsI5w97iaTY+/OXJ0qYjHMmF/vHstsH1FyBQdeLAGCyviccmVg7eZY0ZKVBHV1P0dxbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722486349; c=relaxed/simple;
	bh=m7KzoZEf3X8gO1O8F5QXe5+9HU1dvonxY1XpjIXLU6w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CHyGCIW9snVqYHUTS45fC/FRJscSwSdGsI9hIJ3SIZ2qyDuLnM2b72OYD4RrY9FyIu+C3gd5BZZ4LemzIySd7ByXrzQDYqzL9eNSSoHLIeFHqSC1bm1CbuRIJB2U1u7v0Hz8PYk5UD4/wmhMd/c6WEILLfRRCGk03vlFjzCtlNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1V/Nn8Dd; arc=fail smtp.client-ip=40.107.95.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SVz+Rot1BRuUqsUzXITvoaXYCeoyYtmAx0EoODwnciIwh2Hx4+iqniqrsT96zUz+oc3malPE7FcckzMSxkmiQpWGSPs/Vhm+lrtGb7z4j3QT/tLchkdGSEndo1rPgw/XPX/ddvTpifl8oSMKZC6s9A72/vF9q8yE210Y8n5ZvsUXgeDSM7T7+j2bahXo3jRInqX1NoMvy1ocqWKLBkQx5CjmdG0qm0263eLE2UqLL0lleAZCGp9R/Poyf4HJZvvlgcJVUBmSmjcjSyFPxp2ZWW6PS+uFW+C1Y33iwYN7ls1FEN8TJbKfrWX+f6KMnktuMbcXZk0zPz/12yphHvh38Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dNVWxpIQH8U5rT2+Pjmu3GE74pwdeyFzXAGL53S3QuQ=;
 b=pr15euHgSwr9LiVi9I0FOcWZy9gNeNogxg9hRTPrOFbGnFtNPWI9L7Pp5OfAThnNgzVqrutaqtLrTPPRVhqaepo6w6MRXqmZEvm1zQRemMFuIo81OFgN6dcj599rw+nTcPu2bhqAIfAhWkoA684yMKxf0AogzIPPMsHWJOI4kw+Ls6pdOiyDIBIsSLhjQvydegc+9bOx/pCx+SByZdI0wzYGn5499BjJoIoK09RWorjeau0ekafv6YrT63Z/m7JEulTiZp494kVFzEtN9WIK40gpISxGtoPKWUUb5N4lyyZvuySLZDGp5Ys56j+kOcwMcxNO1/yonwRdYSJ7/ibdkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dNVWxpIQH8U5rT2+Pjmu3GE74pwdeyFzXAGL53S3QuQ=;
 b=1V/Nn8DdfGTFOIfJ0bsUMQf5bsTHZQIcAJR9Pr253+GBXxI/qtGfeeAJdKwH+U0OJzOh5qZzFLwm2hIzQgY0TevmyaGPIymOF2OaJlwJQXTXrk475d0ZLtgePTIkRynCN+F45P3FL1+PWyWxtfl6YkW9IPxrh4kccuvN9VteWNk=
Received: from DS7PR12MB6070.namprd12.prod.outlook.com (2603:10b6:8:9e::14) by
 CH3PR12MB9024.namprd12.prod.outlook.com (2603:10b6:610:176::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.22; Thu, 1 Aug 2024 04:25:42 +0000
Received: from DS7PR12MB6070.namprd12.prod.outlook.com
 ([fe80::b847:e013:8f93:f6e4]) by DS7PR12MB6070.namprd12.prod.outlook.com
 ([fe80::b847:e013:8f93:f6e4%3]) with mapi id 15.20.7807.026; Thu, 1 Aug 2024
 04:25:42 +0000
From: "Manne, Nava kishore" <nava.kishore.manne@amd.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
CC: "git (AMD-Xilinx)" <git@amd.com>, "mdf@kernel.org" <mdf@kernel.org>,
	"hao.wu@intel.com" <hao.wu@intel.com>, "yilun.xu@intel.com"
	<yilun.xu@intel.com>, "trix@redhat.com" <trix@redhat.com>, "robh@kernel.org"
	<robh@kernel.org>, "saravanak@google.com" <saravanak@google.com>,
	"linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [RFC 1/1] of-fpga-region: Add sysfs interface support for FPGA
 configuration
Thread-Topic: [RFC 1/1] of-fpga-region: Add sysfs interface support for FPGA
 configuration
Thread-Index: AQHa3yZuwBfgoAWoa0yxdButTACHTLIN4ZUAgAPvPVA=
Date: Thu, 1 Aug 2024 04:25:42 +0000
Message-ID:
 <DS7PR12MB6070C9991ED88DFFADA7EC3CCDB22@DS7PR12MB6070.namprd12.prod.outlook.com>
References: <20240726063819.2274324-1-nava.kishore.manne@amd.com>
 <20240726063819.2274324-2-nava.kishore.manne@amd.com>
 <Zqe7yoAMIJ+Qv8YC@yilunxu-OptiPlex-7050>
In-Reply-To: <Zqe7yoAMIJ+Qv8YC@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6070:EE_|CH3PR12MB9024:EE_
x-ms-office365-filtering-correlation-id: 960857ff-2192-486b-1cdc-08dcb1e2017f
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?779vGZ/2EMsECylhJAtGWttKpRl0vX1ZCf65mHQhy1yAfPYXap5vW5ANDZtn?=
 =?us-ascii?Q?AQwR9aNB+IZ+3V3R94Qfgp0lh/16d6FwRvuKIa+39Mhe/HZy9W9+t4E8+Vp8?=
 =?us-ascii?Q?uQnZHALpE4DxTPy6r+Eh70cCoutpaC7nBjarNrhshFJqhdbEWy5++4NqGKOu?=
 =?us-ascii?Q?fAPCqpQ6Lw49h+jUrxE6QHfDwJU9GTla8xKCO35+ShJol+GhuynM8wod7gzP?=
 =?us-ascii?Q?oG9vHyzouO8KbLfF8nPi8mCf31Oxa0eBz2R0dItpSiQrule6D4+1+c71KFzG?=
 =?us-ascii?Q?bezONtci21F4IIW41WQpCu/POl36I9KOrVtDtO36VGNRuilNeWFlkf+ewHSS?=
 =?us-ascii?Q?LoMvyYSyHupQf63vhQKPsRZNNmoTJKbC/XEUfAzdRMGLPNqMACfXonDuWYf5?=
 =?us-ascii?Q?Gfv9TBajDOZR4SY5e9vAuS278pOvaUD/r83tYlmBOjmSDmSb5ssVy3DQ+SUL?=
 =?us-ascii?Q?cDofTavFrpkV1rCXATLMEQRKeDFrX0M+/qMuY0OZsoHjwxSF/a2+T46mDAkR?=
 =?us-ascii?Q?b3BAYD+CMqEkum00ijQfI0CKeLHRQN+odLeU18SY2wSGpFZ3mBsCu3ag+a15?=
 =?us-ascii?Q?0leNhf0CbLR57Jb+3jsx3g4hoFK2qm0DViSpk8JHx476nZ/tmmivFfWuaeYG?=
 =?us-ascii?Q?gHLKPko6fhWu8CFXU0r9en5zCSbjFwZ5tbkOpw9AuaisgMFw/zvhwC76nnoB?=
 =?us-ascii?Q?MNyu65j2mP0xKfTG0iFilVnU6WEUyY8vHEoR54xTPx1NkwDH484LtfgTbfgm?=
 =?us-ascii?Q?ONAIvWULHUoKBWXH/KgBwu7xuxqaMy0HPwPBHL4bsZcq2aTw2nbeVW8pJVZu?=
 =?us-ascii?Q?Daw817TOdZOlvddTH4gBjCEmYJ3G+2TFugGHRPO6+rumng6YQuVl09T62weQ?=
 =?us-ascii?Q?m0tk19IlfXFkehOmpNAaCSp6QsVLYc3c7N2mGn6S4SXkYnh5v9RaMcJC/8zf?=
 =?us-ascii?Q?jM5O4XJ+oSMgl+mdz3xwcTYwe1dbrf2AaSm7sARw6tjYwoJUBpTbU7N+k1uM?=
 =?us-ascii?Q?Kar9+A0mFcjQvH7SM4XB2YZnNFfXIble6gop/JfZEVJFwtqvJ97vJ1X41Y/l?=
 =?us-ascii?Q?YU2AflBemJyDpcVqiwUtWplJ4j/SsNAgGGe65kLp78d3e7ks3ym6RY/IZMmY?=
 =?us-ascii?Q?0VahshMb20bWp40s9nO2TcmGdLJSIjeatm2Oeli9Ji+fn5nzxWXoHVw4ZYjs?=
 =?us-ascii?Q?QTBbxbg6phKhL1HxxsRZplivnDmklk8lOiMguTmZZuUOR3hCSFmeTXd3he/z?=
 =?us-ascii?Q?s5ctE8uDOUixPus8+SuJZMVpox2pAP+2H6U/R9rmzbFxqYxZwURiQnjoLCdX?=
 =?us-ascii?Q?2cxBC9IVqprllrKi6tjODrADpRo34Qp4QfVnGoeGp7D0rPRNC+jyWKrRqXwr?=
 =?us-ascii?Q?L0FqPZsUKlXjnnbZ7guVw0W3ncBGfr33p5X5TCHYNEYkOPIhLQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ea6j/vKyCj9j1VIWZoGWybp6Wv/4CbfO6MurdWeKWeSSkFlmVrAptoXH0sFV?=
 =?us-ascii?Q?xIMZ1NGnPg/NSZEOGcwIRQlt4morEhHHdBg+jtbGWe0/Tw93Wj0Ndk0EfPKy?=
 =?us-ascii?Q?xffM25O5+iA5eiVud9BI0zKuFIElELaXfLSOT8uhL0MdRxAlU64mLWtXm7/X?=
 =?us-ascii?Q?eUajdtFFbG7G/0Rx95MCTzTuHdqtK2/zTg1zKFihDtsRVwKIkH0DfC+flJzF?=
 =?us-ascii?Q?RhhCkc0IGXaAv4xH/rTLrkV3grRfAfgcACmlemE8OwKKvXb8+ZIDjnMnUUJU?=
 =?us-ascii?Q?69Z7kDHu48tOcPvzWUGcwon7CxSHQh9zAHTMhnzgZYxKziUNqzO8gqr+AZn7?=
 =?us-ascii?Q?NC5LDM5MxHznP8NEP8mRsRATTAWqwKh7Ee2wwRGxIMwS3XNu0CU1zJlNT0Io?=
 =?us-ascii?Q?xfMumZiV4i55ZcA2CNPORjv6+UxCuhmtYI4T8rUOYDi5aOYTmZXSxcUUQ5nv?=
 =?us-ascii?Q?u5/rIhDfuEGm6iA5i7N1THvN6KRSlKEFME0qaNRs0hQ8Wt5N2S+nizcIiVf3?=
 =?us-ascii?Q?kYHVkpv4dnQt6p1WTwClVzwVbZWqr6cE3cBZU3rgI/z7dG+tGQPi2iJZqr5H?=
 =?us-ascii?Q?xfgRmF3MOzshwvzXIBJMycyJS0p3wCe6cL+iPEEh3maHvL+Ytvh9Fmh4lrRT?=
 =?us-ascii?Q?OurZmRypsMlzCzqWOFL0o9x3Cd+2hWq3BPaghkHP5YRFPTmOTuMsSA+NefmP?=
 =?us-ascii?Q?ps6rTs5nAZCCNTfUmYWumORc7CfkpLt+lj+0qe+QXPzMr/EUqgtINN0kjHZB?=
 =?us-ascii?Q?qkhl1mS0rhsJbev2kYcgRXBe9AajAT143P/LDIOpXpLXNEZNN1unvAEAUpBw?=
 =?us-ascii?Q?490Vv901ENYnnmUT5yNprFo3OsFkTnz6uj2zOxBSlGEarOsxAuYsby7YKxrB?=
 =?us-ascii?Q?JIwtrbVKInYi4jGzfJUl+TywT2c7O68td1khabBsE5Pvqt0d0SDIp3F09HQv?=
 =?us-ascii?Q?ZD0tqgnhzwD5rm8PvILr9w56VqbOYyAwjWgPdU+dWWphWuWnqJ2PGQu62ZI/?=
 =?us-ascii?Q?ao7ERko6ufeFA/YgAvUrKscdNxxrKNyPXGPUiptNINMtz4q7C11X+rPtavJg?=
 =?us-ascii?Q?kdiNVX9ANkiS7gfm/myeVAQwbO7/7Z6wJu9DdTALyTtYmBdqFpj2TYD4877x?=
 =?us-ascii?Q?A02NJ7Zu3bUkpGCdsZMLNdZf48CpXY7d6N9RI4wuynQvOyTo8BmIuqX+IvPl?=
 =?us-ascii?Q?1If/MmdJp5/iFZV742QMsyKZ6sjn7hytIrTENJH1YXy/crhO1E8nIYtVmGG9?=
 =?us-ascii?Q?8kkXaPjbKj7rU6P5tf0Rqvfyg4cuThFGA9NhbCxDnsRBVo2bY4srVdTuYU/1?=
 =?us-ascii?Q?GPHj4W+gWi1yOQTUpx4xRLU6AbiWXof5glXtix0izV4GVP3RtIsr5ZTZdavl?=
 =?us-ascii?Q?7HEjZB1oSBPzrJuVVIMeI1DHy+KAPjScjyCd71etcGqIiIojaO/qAwsk/voh?=
 =?us-ascii?Q?bXcE3c13ljjgbLyEaZiNOk9wI4BRS08VEjmgCaJG4idLGFMJa+TBtoUkYbWj?=
 =?us-ascii?Q?WZwxEeK45iXau4eGXcLFRDGByV5cyePiQ8VJjEt3xrALkh8xomLxI19lCbWg?=
 =?us-ascii?Q?2WMwBNVlfS0H5T/Tvao=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 960857ff-2192-486b-1cdc-08dcb1e2017f
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2024 04:25:42.5311
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bRzL+ojWkiLPkJfNHDXlFXWfjVAGt4xzltcBYnn1hx0AJlUmOljZxMxdgxZBW2Ao
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9024

Hi Yilun,

> -----Original Message-----
> From: Xu Yilun <yilun.xu@linux.intel.com>
> Sent: Monday, July 29, 2024 9:27 PM
> To: Manne, Nava kishore <nava.kishore.manne@amd.com>
> Cc: git (AMD-Xilinx) <git@amd.com>; mdf@kernel.org; hao.wu@intel.com;
> yilun.xu@intel.com; trix@redhat.com; robh@kernel.org;
> saravanak@google.com; linux-fpga@vger.kernel.org; linux-
> kernel@vger.kernel.org; devicetree@vger.kernel.org
> Subject: Re: [RFC 1/1] of-fpga-region: Add sysfs interface support for FP=
GA
> configuration
>=20
> On Fri, Jul 26, 2024 at 12:08:19PM +0530, Nava kishore Manne wrote:
> > Adds sysfs interface as part of the of-fpga-region. This newly added
> > sysfs interface uses Device Tree Overlay (DTO) files to
> > configure/reprogram an FPGA while an operating system is running.This
> > solution will not change the existing sequence When a DT overlay that
> > targets an FPGA Region is applied.
> > 	- Disable appropriate FPGA bridges.
> > 	- Program the FPGA using the FPGA manager.
> > 	- Enable the FPGA bridges.
> > 	- The Device Tree overlay is accepted into the live tree.
> > 	- Child devices are populated.
> >
> > When the overlay is removed, the child nodes will be removed, and the
> > FPGA Region will disable the bridges.
> >
> > Usage:
> > To configure/reprogram an FPGA region:
> > echo "fpga.dtbo" > /sys/class/fpga_region/<region>/device/load
>=20
> IIRC, last time we are considering some generic interface for both OF & n=
on-
> OF FPGA region, but this is still OF specific.
>=20
At AMD, we exclusively use OF for FPGA configuration/reconfiguration, utili=
zing overlay files as outlined in the fpga-region.txt documentation.
However, some devices, like dfl.c those relying solely on the FPGA region, =
do not use OF.=20
For these non-OF devices, should we expect them to follow the fpga-region.t=
xt guidelines for FPGA configuration/reconfiguration?
If so, it may be advantageous to develop a common interface for both OF and=
 non-OF.
If not, it might be more appropriate to establish distinct interfaces to ca=
ter to their specific requirements.

Regards,
Navakishore.

