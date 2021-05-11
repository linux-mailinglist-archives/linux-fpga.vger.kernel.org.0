Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4C7D37A79E
	for <lists+linux-fpga@lfdr.de>; Tue, 11 May 2021 15:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbhEKNcm (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 11 May 2021 09:32:42 -0400
Received: from mail-dm6nam11on2049.outbound.protection.outlook.com ([40.107.223.49]:15297
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231305AbhEKNcl (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 11 May 2021 09:32:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FHAhW1KBZdIK0hooVCDyRsy5TkwWFzuAzotMPEoh1rfteNGz3iF12v71tnPJ+LcNUeh57k2hpdjy2sg6Iksz0bUVbmEdO0rCF/zpUk7d89OMBxGrpZVXc9NWDBNk0egvDYcH0alWpN9b+sUHNOimE1aOSjDBDlWjJihdmMp72SaxoCISuPu2FD0o9+n6Hxz1t5AcKvZ9bjPPIEUautXwnyjMyLCK0IuGWM7gBposVsgc2rkHR/rGe6CVcM8T0E5twU/wl+SZT7T5ea1VSmVGS1Z4uzTkHtvkShd9SI7r1FonB1hJ/iDdF2bSRJiQJI8ezkndqQFYUe9Yf622oUaPNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ldwy0zp4YAN3jNCTbgRjLSIZyU3Z+jV24NiuF0DrsKQ=;
 b=J1G+JVmFCjihUcy4597v8ucemqZo0DM229espC5eM4D8wPB8dG4BrERvAdSpdqXCIRy2X8/YkSMEnmdqvFFmUYq8g8EXenHwR7aavFKBAkH51prEd8ic7EX321C4i+u3K31Q8HKuVzftbDIdu6Ob7vtkGEp+UVUl51Tyy2nRKJ4NJvdgP1+OgOumzRBFlvp6XQYfc6rfxhSe3l0iYGBALqEo8oas/FtA7YffahQWyCBPTKU7LGgi5CiD8Zvk5l1zrzH6Wg5+5b110w/4UA/OLya6Sowc/5UTlUTCn9VBIza5N7rK7Uzg4KDvyHaXf3VDRlLAAIEib52fNkV6v5GoXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ldwy0zp4YAN3jNCTbgRjLSIZyU3Z+jV24NiuF0DrsKQ=;
 b=jDUoI8Dro5BYQla9jt6sTWVo5EkFWeJlm9UCKxuJwAwgpUrEzIE5qKe4xe2gy6r6cVcyx41JeGHaNdgl3IRTzsVkAXzGyza7g3yOZK3bnS3E852WXnNS3URXLAidAvKrzbBpu+NaW+Ds+q6uy1MMnPxxV8daIONbF04cE/Etqu8=
Received: from MWHPR02MB2623.namprd02.prod.outlook.com (10.168.206.9) by
 MWHPR02MB2622.namprd02.prod.outlook.com (10.168.207.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.26; Tue, 11 May 2021 13:31:30 +0000
Received: from MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::97d:165e:73af:bef8]) by MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::97d:165e:73af:bef8%11]) with mapi id 15.20.4108.031; Tue, 11 May 2021
 13:31:30 +0000
From:   Nava kishore Manne <navam@xilinx.com>
To:     Moritz Fischer <mdf@kernel.org>
CC:     "trix@redhat.com" <trix@redhat.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Michal Simek <michals@xilinx.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        git <git@xilinx.com>,
        "chinnikishore369@gmail.com" <chinnikishore369@gmail.com>
Subject: RE: [PATCH 1/2] fpga: mgr: Adds secure BitStream loading support
Thread-Topic: [PATCH 1/2] fpga: mgr: Adds secure BitStream loading support
Thread-Index: AQHW7UWZwDiwSbkqzUWMwmmZwUyntqozISAAgAgZmKCANxU1wIBrXauAgAFH0bA=
Date:   Tue, 11 May 2021 13:31:30 +0000
Message-ID: <MWHPR02MB2623E6E6759FA574129901E7C2539@MWHPR02MB2623.namprd02.prod.outlook.com>
References: <20210118025058.10051-1-nava.manne@xilinx.com>
 <YApf1jlEghbnDFo/@archbook>
 <MWHPR02MB2623B63A5359BB35B89BF086C2BB9@MWHPR02MB2623.namprd02.prod.outlook.com>
 <BN6PR02MB2612733F9D85ED6A36BBF801C2989@BN6PR02MB2612.namprd02.prod.outlook.com>
 <YJlw5fk0ORhioDb4@epycbox.lan>
In-Reply-To: <YJlw5fk0ORhioDb4@epycbox.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.50.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1a0a1a55-31c9-4e5a-f9a0-08d914811614
x-ms-traffictypediagnostic: MWHPR02MB2622:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR02MB262241318613C64D37CA9394C2539@MWHPR02MB2622.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:843;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pl19DEDx41a+Vz8I4PKcxcv04jZtRkyhOgJ+skN5ENjdEeuKMJZ0AZNx4OnvSn7JUK60RHBvMXvzlSBy5pWhsYu1XsP2w6vKBakFJWo5om6AfSWov/Sd2i5NF/PFfKttOHwiBPZGrClcOxAyOy4yzmJ8A54fwDwSpyruyhgochXL85d7x6R1S9hrABjYOJlHzUpjrf2fHOCjWf/odu+KEhauBsteQjFo+pJLoVdGi5w+byeJOGhm0dHw9isP3QHsI/+n2GiXV0tRNqEnCKIAU+NgKbG8PCGJjYHtXENFpZkbdyEChDj7fwLTnJrYC6VEXcde/2zbXYrQcdqFSqNTUMOtNZ63BjJ52WGfXRIKEvcDjcBa0HhKYvjJSeYkLQzxmcTf9ltlPOhmJRhSV9XNnDqjz9QLK3Ho2KQLUP+TlDUPaLd4dNDC2VfwiT7d6R/rT+SvYMQkTP2cZj1iTa1p/ZYhuyClgLfEjSpm8zsjFBG1ro5MvMWme2MbPZtJNkzJy6r3Fqww4jRiKC9RLBAtX3EKBX7JoFmepeME5CDFVxSU9KumFLt5CPuYSHv6q7X2rv/iNw/PeDuivhdX61DDWe22NdYNc9SeSByuZdQYHJg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR02MB2623.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(39860400002)(366004)(376002)(346002)(76116006)(26005)(6506007)(66476007)(66446008)(55016002)(53546011)(2906002)(66946007)(38100700002)(478600001)(316002)(6916009)(8936002)(64756008)(122000001)(33656002)(86362001)(66556008)(52536014)(7696005)(9686003)(8676002)(186003)(83380400001)(4326008)(5660300002)(54906003)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?l0QYJwhi44qtwqPUCwfQLlMQMPpNyiVvcucVIOxsEXT17qalpNW2EMyMLF5n?=
 =?us-ascii?Q?qKp+yb21JLlJDlSFk1YCEYIdhgOU9mXPw4VH9LhnnEt1y5FHFuyeT4U9plI9?=
 =?us-ascii?Q?b9agJ0jhBv56HF2ZYO1hWVTrLE611yZcCMnbUb+UOyOAAvaviFQZKvjcTUi5?=
 =?us-ascii?Q?rE4sVGa+KjwZ5tbyPKTXwXnA9uaBoR6QROwJ7Pk44krUOLrHZ4XhVFk9KOL/?=
 =?us-ascii?Q?iWf998bFWaQ55RzvkZ5I9oHjx1lmAuKDlB5M57KdY1BOcR/v9PYNDByYEJn/?=
 =?us-ascii?Q?LaevtbEg6IYuRnaB+a5Wklb+JO/kBZIi2Ov43VRufcKltZNJGZsf8Tkdh11t?=
 =?us-ascii?Q?PR2Mth2Jhcp4PPUiREHlxNNbZsuMxnBXIys0b9qPIqnjOtJgeM1P/XcCT83W?=
 =?us-ascii?Q?YZ3Y8t1eVxVhCdubCdPKjNh0nJQALNXZAb4FR6tuXAj1Uvu2REqScPa/4YTL?=
 =?us-ascii?Q?NTwkFVUjEgZoNjd98c21gsul+RljhcbnREvRAl15s0S39j4WV31qaZeh9q41?=
 =?us-ascii?Q?NKYTGbcOIFwfRAaRsEqtN7a4Ds61hcOlnQL7kqyEFYn3SnDigW4e05f8d1ZK?=
 =?us-ascii?Q?rqzMBSHhQk/Jb88MNaP3gkxiltbkSp6FdT0ZdezDKLN7YVIElghSvEagl/Nr?=
 =?us-ascii?Q?kaHgmhQTTvMIVWJyHwh5JwB5yadSU7C1F16enXCrB8pkfqOahMW292GMbnfR?=
 =?us-ascii?Q?HMOGrzHVGY9srwNm6XLnx1ZNCpKbNHE2gvFDQNLb0xe8admWkud+ESH4okwh?=
 =?us-ascii?Q?2VWRpGrWkmCP+Msz4et27gxD+7te7ElnjbB/vFjKmcMKFmfySLeEUDsGrDeD?=
 =?us-ascii?Q?F+HbAEYIUnK/L0gc2lU8ILZnoEcgoN6zWnckJ/490+chKf4k2dR/av5HHA2X?=
 =?us-ascii?Q?VRlwnIsrO2J1/Wy3SuozSzbSQcvlsYRXPahFp1U91RXUsFGU26hgihca0tfa?=
 =?us-ascii?Q?yLsVRLryAeCtGbSWYVV/02FClIErlUPV6issqI78r1k66AZoMJH7VvIE2ACK?=
 =?us-ascii?Q?yq0HbEcZTBp16VsMbx3tHdBKq/3lbj4o9nT4jmp9FicGX4QNc1NcDmohtDGl?=
 =?us-ascii?Q?NRPuNDYcqg7/qpJV3FGbAI6OboZ1WbNDjzgA5Bbn9x8q0HogQBOQeUVbP2Ek?=
 =?us-ascii?Q?e2nYRxN1XVR1JCnuKNuL/I8PhoPETMzEV7Zw8WCPkHPN4pMynzm1UWYR8ToZ?=
 =?us-ascii?Q?wIgzTN3ItCZ6BwWhfJvBz0D7q6mI6s7p5v3Rzc8ULSUEcATMKciC1T2CsB2g?=
 =?us-ascii?Q?cx1v45TreRk2b/TIwv3Lv1fcDwVLXVBA84P6oyy+YjI3v0N/0R7CgimDvY9L?=
 =?us-ascii?Q?ENJYRIE8uAsQkGD4uTsSQmgG?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR02MB2623.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a0a1a55-31c9-4e5a-f9a0-08d914811614
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2021 13:31:30.1056
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D/s6SB/c4HxO0f9Fsi1Auioo0WDuWVKAlIEH1xxm85OGk/LruEjVINGPr1lP3aJtAFOCfIgoGp59uF2mDWWbPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2622
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Moritz,

Please find my response inline.

> -----Original Message-----
> From: Moritz Fischer <mdf@kernel.org>
> Sent: Monday, May 10, 2021 11:14 PM
> To: Nava kishore Manne <navam@xilinx.com>
> Cc: Moritz Fischer <mdf@kernel.org>; trix@redhat.com;
> robh+dt@kernel.org; Michal Simek <michals@xilinx.com>; linux-
> fpga@vger.kernel.org; devicetree@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org; git
> <git@xilinx.com>; chinnikishore369@gmail.com
> Subject: Re: [PATCH 1/2] fpga: mgr: Adds secure BitStream loading support
>=20
> On Wed, Mar 03, 2021 at 10:11:51AM +0000, Nava kishore Manne wrote:
> > Ping!
> >
> > > -----Original Message-----
> > > From: Nava kishore Manne
> > > Sent: Wednesday, January 27, 2021 2:43 PM
> > > To: Moritz Fischer <mdf@kernel.org>
> > > Cc: trix@redhat.com; robh+dt@kernel.org; Michal Simek
> > > <michals@xilinx.com>; linux-fpga@vger.kernel.org;
> > > devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > > linux- kernel@vger.kernel.org; git <git@xilinx.com>;
> > > chinnikishore369@gmail.com
> > > Subject: RE: [PATCH 1/2] fpga: mgr: Adds secure BitStream loading
> > > support
> > >
> > > Hi Moritz,
> > >
> > > 	Thanks for the review.
> > > Please find my response inline.
> > >
> > > > -----Original Message-----
> > > > From: Moritz Fischer <mdf@kernel.org>
> > > > Sent: Friday, January 22, 2021 10:47 AM
> > > > To: Nava kishore Manne <navam@xilinx.com>
> > > > Cc: mdf@kernel.org; trix@redhat.com; robh+dt@kernel.org; Michal
> > > > Simek <michals@xilinx.com>; linux-fpga@vger.kernel.org;
> > > > devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > > > linux- kernel@vger.kernel.org; git <git@xilinx.com>;
> > > > chinnikishore369@gmail.com
> > > > Subject: Re: [PATCH 1/2] fpga: mgr: Adds secure BitStream loading
> > > > support
> > > >
> > > > On Mon, Jan 18, 2021 at 08:20:57AM +0530, Nava kishore Manne
> wrote:
> > > > > This commit adds secure flags to the framework to support secure
> > > > > BitStream Loading.
> > > > >
> > > > > Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> > > > > ---
> > > > >  drivers/fpga/of-fpga-region.c | 10 ++++++++++
> > > > > include/linux/fpga/fpga-mgr.h | 12 ++++++++++++
> > > > >  2 files changed, 22 insertions(+)
> > > > >
> > > > > diff --git a/drivers/fpga/of-fpga-region.c
> > > > > b/drivers/fpga/of-fpga-region.c index e405309baadc..3a5eb4808888
> > > > > 100644
> > > > > --- a/drivers/fpga/of-fpga-region.c
> > > > > +++ b/drivers/fpga/of-fpga-region.c
> > > > > @@ -228,6 +228,16 @@ static struct fpga_image_info
> > > > *of_fpga_region_parse_ov(
> > > > >  	if (of_property_read_bool(overlay, "encrypted-fpga-config"))
> > > > >  		info->flags |=3D FPGA_MGR_ENCRYPTED_BITSTREAM;
> > > > >
> > > > > +	if (of_property_read_bool(overlay, "userkey-encrypted-fpga-
> > > > config"))
> > > > > +		info->flags |=3D
> > > > FPGA_MGR_USERKEY_ENCRYPTED_BITSTREAM;
> > > >
> > > > Can this just be encrypted-fpga-config/FPGA_MGR_ENCRYPTED?
> > >
> > > In Encryption we have two kinds of use case one is Encrypted
> > > Bitstream loading with Device-key and Other one is Encrypted
> > > Bitstream loading with User-key. To differentiate both the use cases =
this
> Changes are needed.
> > >
> > > Regards,
> > > Navakishore.
>=20
> Is this region specific, or could this be a sysfs attribute?
>=20

These changes are region specific.

Regards,
Navakishore.

