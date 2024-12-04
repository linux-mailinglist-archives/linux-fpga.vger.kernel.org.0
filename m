Return-Path: <linux-fpga+bounces-975-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D09C79E339A
	for <lists+linux-fpga@lfdr.de>; Wed,  4 Dec 2024 07:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B141B24BDB
	for <lists+linux-fpga@lfdr.de>; Wed,  4 Dec 2024 06:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F85187849;
	Wed,  4 Dec 2024 06:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pOPK0QDP"
X-Original-To: linux-fpga@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2086.outbound.protection.outlook.com [40.107.100.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5062AEE7;
	Wed,  4 Dec 2024 06:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733294427; cv=fail; b=jXksfYy/Z9P0SWPZFhsg0FGEphsPhbgvPPR562/YCnTkZrfUVmEMM8iTpT0qRW0OBbIKnwXWYA/onE3nwRzebB5p0JZWITEihYI/+LqCff07SFMmowIU4vkRsfu1LDOp6ZpQEGhwYol923IlfG7NnCAJFgIuOuxwaS6TaptF7Q4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733294427; c=relaxed/simple;
	bh=n9aFGPq4zxS2j0gsdFo7os43ipOUCP+/WGrLBC2tLj0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bUrhQiNgdiMlJv4qtwdIc97Od+XF0aX/erPjOClx9UIpHX628npfHqFPXdN2hHv8LHAaEkW+2P4WX25OZH8mLSnunH562jSsNF0oGdd8O5hOW/i2q0D8DcpPOywwMDQEExMlMCafFJhURH9N7NwdEFpmC4KWq1JrqXHYrmXFbh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pOPK0QDP; arc=fail smtp.client-ip=40.107.100.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XAovXJOtCriWLPe9y3ctU/z8e9jQwSYgn3zUee/E0pvnl1ticxIGTURWi8iuYb4EvtXZMYEpFSoseeb1WPAmebSL/O3XYbx4y7RoslmJbFK+ddVi6GYZpEFhlA8pCm+sscPx469rrxrwBni3vlfiJ8Qs7uB21LdAJk7fJfTDm+HG021c4Ir7LWYqhaq3WoUXPEgkO1fPkG86gaMKO5el2AkKDpUWGftKNNv/cpz3jeXJCTqZl2DgqOC4vB3Tr166T/MQuzuUQ7bdzdNpRtxKro3xzUFUVp55d+zjEH8+EewnyZr8mV6GaaPMiR99XvN7E9a/XUNYMrIe9y4fP58GpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NRf4FJhePudtyglms7YEZhcCiBhaMbRIMDbyqpgwP0g=;
 b=cl5o7IVSVhN+S0HeLXa4etXz7S9G8e8v2gty5ytXhTaYHF9Vwgin1Y2mRoTp1e/whXdbEUXcAzfkYpklbo2PzF4QyJ/GwxLsnlS+Dt3h3HQxWj1H4hIPt0M54lKu+jkBURLgSAjzYb8KLeE51RMV6komyABo/BRkTCjPikjX3WwM+LJeDqnZHDOyiV5oKcRWWOzJaqKiEXWWUtu4+cXIEo4QSCOfjr0n7JtpbStPeUAW6OlY4p1GJr3Fus0G1yl5eY31FycBgV/U8hIOXc4gFvrY+XrgIldF4RA0SbfcURLtc5hnMmrGlFICVOyTlmgpamyRYjviL18dRHzWVWSz0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NRf4FJhePudtyglms7YEZhcCiBhaMbRIMDbyqpgwP0g=;
 b=pOPK0QDPcKvY3lRuFCw7fAv7apPmAe4sbVbOQR6/e0xYjY/TQpgq4clF0/LHnq1HVimj+CoRMPWOT77z1+KYoIx3SBVh+D1J3awGQXE6sNSprxx12wGXT33KPsQGOcP4qvwMXDe7TPXqPZm7RpyywMl6gPwWhiL23FtgE7lw7ug=
Received: from DS7PR12MB6070.namprd12.prod.outlook.com (2603:10b6:8:9e::14) by
 PH7PR12MB7188.namprd12.prod.outlook.com (2603:10b6:510:204::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.15; Wed, 4 Dec
 2024 06:40:20 +0000
Received: from DS7PR12MB6070.namprd12.prod.outlook.com
 ([fe80::b847:e013:8f93:f6e4]) by DS7PR12MB6070.namprd12.prod.outlook.com
 ([fe80::b847:e013:8f93:f6e4%6]) with mapi id 15.20.8207.017; Wed, 4 Dec 2024
 06:40:18 +0000
From: "Manne, Nava kishore" <nava.kishore.manne@amd.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
CC: "git (AMD-Xilinx)" <git@amd.com>, "mdf@kernel.org" <mdf@kernel.org>,
	"hao.wu@intel.com" <hao.wu@intel.com>, "yilun.xu@intel.com"
	<yilun.xu@intel.com>, "trix@redhat.com" <trix@redhat.com>, "robh@kernel.org"
	<robh@kernel.org>, "saravanak@google.com" <saravanak@google.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [RFC v2 1/1] fpga-region: Add generic IOCTL interface for runtime
 FPGA programming
Thread-Topic: [RFC v2 1/1] fpga-region: Add generic IOCTL interface for
 runtime FPGA programming
Thread-Index: AQHbKeN81itnx65szk2mzvzQ12GeBbK+H1CAgAN+t4CACOtuAIALTWAA
Date: Wed, 4 Dec 2024 06:40:18 +0000
Message-ID:
 <DS7PR12MB6070F3DD9119CD7955EF8AFCCD372@DS7PR12MB6070.namprd12.prod.outlook.com>
References: <20241029091734.3288005-1-nava.kishore.manne@amd.com>
 <20241029091734.3288005-2-nava.kishore.manne@amd.com>
 <ZzwQrYeWVF6cRtgA@yilunxu-OptiPlex-7050>
 <DS7PR12MB6070AAA0C413DBF26F685207CD222@DS7PR12MB6070.namprd12.prod.outlook.com>
 <Z0Z6socXrmHQ26C0@yilunxu-OptiPlex-7050>
In-Reply-To: <Z0Z6socXrmHQ26C0@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6070:EE_|PH7PR12MB7188:EE_
x-ms-office365-filtering-correlation-id: 7a84d99a-4900-44e9-77e6-08dd142e8504
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?fN3YN8mab5E66cfkYoQEr6B/B+3dtEvcVoCwyWA3SlK9sxsgt49CTc4oNraG?=
 =?us-ascii?Q?uh4eWjk/Kl51oi4pEqryWeH50vF9JR1i4Nu5EA3Wq+B/WB7N5/CtjA2/H+cH?=
 =?us-ascii?Q?dK56Wxx8wOhobycH/BinnWdTLnCzbwSliPuBZqx1apsVExuHbpEdimaiEVlp?=
 =?us-ascii?Q?TRO9nnl4lxPUho+NIX4Tjr8g8vZRhLnBYZhcoT2SQTm6AHLIhtEXQz16j8v6?=
 =?us-ascii?Q?Na1MgR/e1aBiNSYMRWA0hAGP7aYNgQHEBVExjrJQoxbAVNW6wkUc5Bb/I+IQ?=
 =?us-ascii?Q?oiUDnGq/paNv5ZdXqt0BVOxhcFo6dR2qdFt6ynpyp2b0QHbi3IxKKin2B5lj?=
 =?us-ascii?Q?Q/Omp+ovyTs+LkUpfn+JlbN+FadhEludjrrV0pdeP/Ij21QHBI0vieBn4ifI?=
 =?us-ascii?Q?MV7QWsejIE+0goQw9El99klCfTAeXvEAYPAxh8xkshzO7jDIjRhqPe6gcvDr?=
 =?us-ascii?Q?gTehI8Z4VapjIRytSJ4fxJTlCt2fabKn8gX8umVgCoq9uau+f9+9nMIgfluk?=
 =?us-ascii?Q?HoGZyUwAzUNS3s3qRUlZZKG3WQQEnldUD+vaoYrM5R+JGESoHSCGzt/6wvVq?=
 =?us-ascii?Q?r/3jA93zjCakve/vUxS50T6ZB2A8X/rNBwqnamxrXzHXMVyBbOoRsXO0xgBT?=
 =?us-ascii?Q?zmSFXIrSRwXNkMnqtL5WaSkc1uMEpd191wowbeKB/nNqqqN64n+mLrcDyL40?=
 =?us-ascii?Q?A88DU/2AWfyW1rGXF7vX1t/4fKRJLmIrZpMXVutC0GYQTq9ijh9m7vT7O5R1?=
 =?us-ascii?Q?Q7I1qAkds445scHnT0zZCCuNCUcM+o4Asi1rlozttyNzYFwj31LREV7I/kI2?=
 =?us-ascii?Q?59lAsVSWpzP4ghIccWKbURWWgKqk3CHJkFSuouV01ItKg1KuT6pbA5cIMh0F?=
 =?us-ascii?Q?KZ1qZRlNYoIHoyFehwbKh5SeOa9Prz/05+rYIsNo8L5H8MYu93ylFxRw6AdQ?=
 =?us-ascii?Q?3gJyDLCM4Ux4/Dv+Xbzwgkg2Jcwl+ptVZ13jM+QiyIRR5FCO6YosiqrqKLBL?=
 =?us-ascii?Q?94pD36pm0/rtk0Ubkisfv4iw9HqGJPcCWgbxuNNoohT04NnXxQeai60V8J+M?=
 =?us-ascii?Q?enID4JWEW8Y5ZpgCEXsSPxtq9wWy0AmW5Mse2QfKJ6H/Ta1Sc9gVmnv34FFS?=
 =?us-ascii?Q?HGBYQe3GHuXA8zRfrRntWPyvBdl8dKm5saZzrXStFijyOXj1AyTDXrsDTGkz?=
 =?us-ascii?Q?g9tOlTf+SIDbOY/yjA/1s/GxdhBa3xgT5ZleDH1soKRio3M2whwwkQwhnS53?=
 =?us-ascii?Q?crBXXPJ4SQG7r2Mg0bA8UjQygW5Nr93ZyHKeUWI6BbaZ59VZEW6Hg+1PROii?=
 =?us-ascii?Q?/eBulNkGKgngBwkCAqteDGpaoOLBjNDCupw/5Towtv73ONEZVdsTZ+rL+FR3?=
 =?us-ascii?Q?8wQhsSKDyyyTljXKcWfGeYDAS3kOfFTVSyW/t6FN0U/79vSccA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?v1/n682koty8lHq8XTr040A64y0Sy93sM6rmljD1qH05B0uNrUzojPxeeFaz?=
 =?us-ascii?Q?sKs/Rws0I7mybPSba/5q+SDgDB2EvPTt3y915SrgSPk+LIfqnEzBOe+0R/TZ?=
 =?us-ascii?Q?YSQ5CjPZxi087J/fMTvhWzrJugSUB5/VBxuLYMo5fMSVEpznuPcxyfrX5KYn?=
 =?us-ascii?Q?RZ/sNKOXg2UQlzR6eKw5dw/DAzObcS0NOvVoLfoV4YxykBGLv+h23wVD3OgX?=
 =?us-ascii?Q?YwgZPB0mBx1nj+lcjTY+dbr4549fJ1bHR8Uf6ipil32KQPk3QlUBvhctI46F?=
 =?us-ascii?Q?Yag50Mv7+yNmtehQq90jjm64DP9NsK1blzfhaXRINLdblBLtJ7uDU4jSRS6c?=
 =?us-ascii?Q?LdHJbOq/wohY4z3f0AF5Yy45+dJrdDU9x62nFQ7PWAwmY3OXWCPB1WPSFQsG?=
 =?us-ascii?Q?UFXPUckiyxcibnkx3rqSgEhoLb6isFSXai9nKre0Hx+aioIFMxq70LC5h10G?=
 =?us-ascii?Q?zZ8hIH/+9JoHELUhKnUL1M7aHB4DbqyRi5wMXWMmmvjffs+wZFvzo+wy6qny?=
 =?us-ascii?Q?Gk/6tbcng/Pi5Hb70sv19IfdXSh+qsEdGlwx/JMIWS+u9ligwHEVY6iQc5Si?=
 =?us-ascii?Q?a5yEH3zeBat5dDA+kKEoWkpWB2ZzfrJziL219f0Ulz5Z2X7OL6qGWsUnbKyK?=
 =?us-ascii?Q?GbM/QUAJloIRFxN+Sv8TDFodB98IuZUCt+Un/583fB1TS0a/a2qyM40Rz8Bw?=
 =?us-ascii?Q?ZBorcB1yE3/JhVOKZ2d/32DkQ7xZ9zGZ642jSQBnA8dP+UFDVQfUPKnz7CbK?=
 =?us-ascii?Q?bwNHqyekLZu/e3ttH3iEtmn36r4ul3ejdiqHCjEPWSs+M6RAQ+asMbz5tHAZ?=
 =?us-ascii?Q?elZl2nR7YEGmifTDHi8gmGiJSmhrcH/SL4YRiVooSf35VIsCCPDl0J/9GWHr?=
 =?us-ascii?Q?5JUniWnI9aljppqBaQq3THbDyF1sG/YiLzBLTq0kt1/8AjAMSEgm5jFuueAh?=
 =?us-ascii?Q?paYvEbubj4jdbFoG88kbSRHsPl8lFJEVdNLbqX2Ly9ZG5ZVskEc2Ji+50KZH?=
 =?us-ascii?Q?Cfta54T1G/Cy+ye8MaTI7EKwIpaepCYEDqYsiZu43sxn89AOfW5fOYSgZbaC?=
 =?us-ascii?Q?EfBwdUdfu7l0Q9qespdqwr4K5yY2+ogZcJ0ssUBFnUs/jpRAxazzwRsDh+oC?=
 =?us-ascii?Q?fpxNSBXzrpsFXc9a/UWIvwuPD39p4dZ7VQI5tu6URKM0VK49fOZG420AbxNS?=
 =?us-ascii?Q?yQQov3RwV/0sE0k58dWFfYx1S5+r/OeE8WFBa++La197sSOmOYMRc/prXI9U?=
 =?us-ascii?Q?j/KaxX4yyUf3UCpEseUk82UqbAhpVJKQepk/APPbGMKHjrjlxSVAKugvHzdH?=
 =?us-ascii?Q?+80m5RQJ6WyOWfgi7u+aiDEMpzNBmCCxYDyS7WU9uT2HWr3AvNEZLZ2HWHut?=
 =?us-ascii?Q?gxLAU+Z7fPSDRmWA42m61FXL1ie3IPH24ZKWvG5uE814RvYeJGq9D6++3LLx?=
 =?us-ascii?Q?fA7j1EHzHJ8d7H4ANEO79sWPSu7qCLv5EpqZW0vpcdpliLOYJOkVy7mejjpX?=
 =?us-ascii?Q?SRWsQPHC2xRWNhEzDYXh3G2iOJi5f0L8FVrNCxOT/+KY+2RIISq8iE1DWEk4?=
 =?us-ascii?Q?1S+cAOXy0gmrGeivQeM=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a84d99a-4900-44e9-77e6-08dd142e8504
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2024 06:40:18.8977
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cIZxPGY0X5B8xFdgr03ZRgG9sGw0OEySr1rb0WMw51irR/nJwXBZ9R22euWP66s8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7188

Hi Yilun,

> -----Original Message-----
> From: Xu Yilun <yilun.xu@linux.intel.com>
> Sent: Wednesday, November 27, 2024 7:20 AM
> To: Manne, Nava kishore <nava.kishore.manne@amd.com>
> Cc: git (AMD-Xilinx) <git@amd.com>; mdf@kernel.org; hao.wu@intel.com;
> yilun.xu@intel.com; trix@redhat.com; robh@kernel.org; saravanak@google.co=
m;
> linux-kernel@vger.kernel.org; linux-fpga@vger.kernel.org;
> devicetree@vger.kernel.org
> Subject: Re: [RFC v2 1/1] fpga-region: Add generic IOCTL interface for ru=
ntime
> FPGA programming
>=20
> > > > + * struct fpga_region_ops - ops for low level FPGA region ops for
> > > > +device
> > > > + * enumeration/removal
> > > > + * @region_status: returns the FPGA region status
> > > > + * @region_config_enumeration: Configure and enumerate the FPGA re=
gion.
> > > > + * @region_remove: Remove all devices within the FPGA region
> > > > + * (which are added as part of the enumeration).
> > > > + */
> > > > +struct fpga_region_ops {
> > > > +	int (*region_status)(struct fpga_region *region);
> > > > +	int (*region_config_enumeration)(struct fpga_region *region,
> > > > +					 struct fpga_region_config_info *config_info);
> > >
> > > My current concern is still about this combined API, it just
> > > offloads all work to low level, but we have some common flows.
> > > That's why we introduce a common FPGA reprograming API.
> > >
> > > I didn't see issue about the vendor specific pre configuration. They
> > > are generally needed to initialize the struct fpga_image_info, which
> > > is a common structure for fpga_region_program_fpga().
> > >
> > > For port IDs(AFU) inputs for DFL, I think it could also be changed
> > > (Don't have to be implemented in this patchset). Previously DFL
> > > provides an uAPI for the whole device, so it needs a port_id input
> > > to position which fpga_region within the device for programming. But
> > > now, we are introducing a per fpga_region programming interface, IIUC=
 port_id
> should not be needed anymore.
> > >
> > > The combined API is truly simple for leveraging the existing
> > > of-fpga-region overlay apply mechanism. But IMHO that flow doesn't
> > > fit our new uAPI well. That flow is to adapt the generic configfs
> > > overlay interface, which comes to a dead end as you mentioned.
> > >
> > > My gut feeling for the generic programing flow should be:
> > >
> > >  1. Program the image to HW.
> > >  2. Enumerate the programmed image (apply the DT overlay)
> > >
> > > Why we have to:
> > >
> > >  1. Start enumeration.
> > >  2. On pre enumeration, programe the image.
> > >  3. Real enumeration.
> > >
> >
> > I agree with the approach of leveraging vendor-specific callbacks to
> > handle the distinct phases of the FPGA programming process.
> > Here's the proposed flow.
> >
> > Pre-Configuration:
> > A vendor-specific callback extracts the required pre-configuration
> > details and initializes struct fpga_image_info. This ensures that all
> > vendor-specific
>=20
> Since we need to construct the fpga_image_info, initialize multiple field=
 as needed,
> I'm wondering if configfs could be a solution for the uAPI?
>=20

A configfs uAPI isn't necessary, we can manage this using the proposed IOCT=
L flow.=20
The POC code looks as follows.

static long fpga_region_device_ioctl(struct file *file, unsigned int cmd, u=
nsigned long arg)
{
	struct fpga_region *region =3D  (struct fpga_region *)(file->private_data)=
;
	struct fpga_region_config_info config_info;
	void __user *argp =3D (void __user *)arg;
	struct device *dev =3D &region->dev;
	struct fpga_image_info *info;
	int err;

	switch (cmd) {
	case FPGA_REGION_IOCTL_LOAD:
		if (copy_from_user(&config_info, argp, sizeof(struct fpga_region_config_i=
nfo)))
		return -EFAULT;

		info =3D fpga_image_info_alloc(dev);
		if (!info)
			return ERR_PTR(-ENOMEM);

		/* A vendor-specific callback extracts the required pre-configuration
		 * details and initializes struct fpga_image_info. This ensures that all
		 * vendor-specific requirements are handled before proceeding to
		 * the programming phase.
		 */
		err =3D region->region_ops->region_preconfig(region, &config_info, info);
		if (err)
			return err;

		/* The common API fpga_region_program_fpga() is used to program
		 * the image to hardware.
		 */
		region->info =3D info;
		err =3D fpga_region_program_fpga(region);
		if (err) {
			fpga_image_info_free(info);
			region->info =3D NULL;
		}

		/* A vendor-specific callback is used for real enumeration, enabling
		 * hardware specific customization.
		 */
		err =3D region->region_ops->region_enumeration(region, &config_info);

		break;

	case FPGA_REGION_IOCTL_REMOVE:
		if (copy_from_user(&config_info, argp, sizeof(struct fpga_region_config_i=
nfo)))
			return -EFAULT;

		err =3D region->region_ops->region_remove(region, &config_info);
		if (err)
			return err;

		fpga_image_info_free(region->info);

		break;

	case FPGA_REGION_IOCTL_STATUS:
		unsigned int status;

		status =3D region->region_ops->region_status(region);

		if (copy_to_user((void __user *)arg, &status, sizeof(status)))
			err =3D -EFAULT;

		break;

	default:
		err =3D -ENOTTY;
	}

	return err;
}

Regards,
Navakishore.

