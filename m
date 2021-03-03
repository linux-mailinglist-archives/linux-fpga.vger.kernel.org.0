Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78F2932BDC0
	for <lists+linux-fpga@lfdr.de>; Wed,  3 Mar 2021 23:29:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232441AbhCCQam (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 3 Mar 2021 11:30:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1582446AbhCCKV5 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 3 Mar 2021 05:21:57 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on20607.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eae::607])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E11BAC08ED32;
        Wed,  3 Mar 2021 02:12:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XtxqF5z6yKkF0HKpUsgISdDJ2xMxHAHQrA668Q9A8IfmHgNTYmyDhDodEFtOAoM3DV3aWxWO5EJ/h0Wd4qeO2Yp58o/XClQwCLmbsP+NioV5Me+HObAG30oYFDUM9tt7rgzA8YSKvK8GfP7L8QGWSyMwnsIjriPm/j1YflV2DZ0DvQ043XYXm3/jmGd/+/vKR+Bvmk6fpNVm78Kyx4cqepn8eDEbWKLMntZz0htrRm7oLB0f7T+KIOSio4JjUYPr3sTe9eIr+xwvL4n99GtaMkrQHagt2DH8aThK7jo+JRBhEnG2W8cz5C2tiBoTjsj5nkFpGCTxk+v2XtqkNaV5RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d2iK/eV4/IwLAK0heNPDna3V1bxth6bVwDm1IM0jfnU=;
 b=MDRBHJ83XaEAEM/ibL0mac++FAYqdRcnySo/LYUwcPMzeVrKyTX3DRA6FYnAfb1L88hMEsWA/qyxxiznlfqOBf0q4XWZCX71upr/XmvfYQ3vqLuXI6fOxIuEhppBTxgflKOJAG2cvBYy4a6L6P5wfCN/HlhFomRWGtXr9dV1FocZ6jRj33Xy+mZd+0oov1OV34exDP5x5w3BexzhaJj0E3u5RYFQSAyzEgHetdOxnfHCmE4pnAQbEkuerigwDAivoOp50wwWhNmmrAdOi6FQ4eZMe4ygi5CgQsaifRO1YZf/dfjW2gJYMU/1GyHcsMt3xmom/f3sy041ZiiQzM/dgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d2iK/eV4/IwLAK0heNPDna3V1bxth6bVwDm1IM0jfnU=;
 b=NX4T+yy05oJva+oFDGX9RTnUe5RGZux9tFD1ylbvHjWuuEm3caqriNKRXXGFpn+QqRWxG/l2qAlz0Mub4y9YduNJK2eyq6xO9posEGBDcH7c7j5dMnnSzfvh4g1i5iQbU88IhIYPNxDN3WfmRmzyqBiLJL8vlwzPMC0QCH0IZ7A=
Received: from BN6PR02MB2612.namprd02.prod.outlook.com (2603:10b6:404:5b::16)
 by BN6PR02MB2226.namprd02.prod.outlook.com (2603:10b6:404:30::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Wed, 3 Mar
 2021 10:11:52 +0000
Received: from BN6PR02MB2612.namprd02.prod.outlook.com
 ([fe80::5dbf:34aa:eb24:4d01]) by BN6PR02MB2612.namprd02.prod.outlook.com
 ([fe80::5dbf:34aa:eb24:4d01%2]) with mapi id 15.20.3890.028; Wed, 3 Mar 2021
 10:11:51 +0000
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
Thread-Index: AQHW7UWZwDiwSbkqzUWMwmmZwUyntqozISAAgAgZmKCANxU1wA==
Date:   Wed, 3 Mar 2021 10:11:51 +0000
Message-ID: <BN6PR02MB2612733F9D85ED6A36BBF801C2989@BN6PR02MB2612.namprd02.prod.outlook.com>
References: <20210118025058.10051-1-nava.manne@xilinx.com>
 <YApf1jlEghbnDFo/@archbook>
 <MWHPR02MB2623B63A5359BB35B89BF086C2BB9@MWHPR02MB2623.namprd02.prod.outlook.com>
In-Reply-To: <MWHPR02MB2623B63A5359BB35B89BF086C2BB9@MWHPR02MB2623.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [223.238.27.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 27777e3a-1ea5-42f6-350c-08d8de2cc3ec
x-ms-traffictypediagnostic: BN6PR02MB2226:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR02MB22269AA6EDB191009AF87B2EC2989@BN6PR02MB2226.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:612;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vlsLKPssKXFN3hRQdtGBga9eiZX6hQfGalFfLp9aLqLaWALij480B1BCN5+Kq1/zJM2Hv/KPL9GPvbG0VBMW43G9gzGc0QpWfAWDmf1JEIMLZ1AQ0TeQpDyTgUcc3/mdY5nWTUICTsrTmu+XzG4d1BvD3WZ+phdhzUHpqhZTDctKwFzN8JvKMKR/QQDCt0t6VVZBEQE1bySnSF0+LKAjFjwiFDqV0UOUKSOprkgnJbA5k4mLDppiVdWfoDrcOszHHFQAmE5cIYHzcM4C2bfAx8AY0n5hFTMh1rgTStbQs6IpQoY3ZrnTMTW05ij3CdrKOcU/URjIG5XL7uDfd+Jrf1BQgUn103IfrdBI6yXbpyyAXh+OtyAIuMkpb34yF/wdClR18P9Zb6e5lEeNC81UJS8m+b5n0FHK601KCVFJnZfUdt2ZnYuui8/PaVFUlISn8vlt1bhR+jo7hBw7Bwr/SIf6rpra2woR6SbT236ExQqJGi+z0qXG9NSNwuT9019VY8ty9iSy8+dGAY73qsLQ5w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR02MB2612.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(39850400004)(136003)(346002)(376002)(55016002)(5660300002)(2906002)(6506007)(8936002)(83380400001)(186003)(52536014)(9686003)(76116006)(6916009)(33656002)(26005)(4326008)(66446008)(64756008)(7696005)(71200400001)(53546011)(54906003)(8676002)(316002)(66556008)(86362001)(478600001)(66946007)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?rDefh0bSTgNzQ0aaJh/ViIaJM392L0ac0DP755TWWdnrjDNKHxq9YYygB4ha?=
 =?us-ascii?Q?Ypb0W32TXAQESGR4aHj2TlMh4FMqOCi8GZMz5uKYgZ07yoHese7oNgadzSlL?=
 =?us-ascii?Q?P9AxXre43lQYUk/gyweNPOPsUm/NQEK6gwTojxfT/NBJgzcCiIP2RytGXMZT?=
 =?us-ascii?Q?vmT0FxQHNN9mx44XS6uXjjBd1st3uZn375r2BgbuICcOn/TXTb/bDohLJ7wd?=
 =?us-ascii?Q?AvyjZD+wEleELQdvjJ02qBl9Bk7h8tUhuSpWI4M+OlHnObov8If9bZUUgxt4?=
 =?us-ascii?Q?lBpHY1gcgtK8eAR9ZZf11oVsQvMhd4vW137p9R0zjLONXa2DHTXQOUZbBqVh?=
 =?us-ascii?Q?RGWLrQSzTzMGN3ccb/TKLVaPcHNe1Y/Nj2Qujmm3xKSc6yAn2Mw2hdABeacZ?=
 =?us-ascii?Q?7d5By4qI3lDETzF/BT2KKciU/x8g+B4PzW69D6bm8sEqfg0amDPLBYMUcmgI?=
 =?us-ascii?Q?4Y8Sg1daYuuOsPn8ualaDwO1Mx2e/ZtjKhFk+XjrvIiRzkFxSk8yp5Now0dc?=
 =?us-ascii?Q?TLamvlmiINd/hIylHh3zbaCfXLwjNp7j2vfO+vX8/iKBHrNvojraYVhrvwEQ?=
 =?us-ascii?Q?ADKsJlwAz+7Tn4qSGVCiJuzsZ9JQqLGJTsVfSAX8vqPqXq1dfuqkveTLOFQH?=
 =?us-ascii?Q?reSh8EurkwZuyX+QhoayGf6EsjmQoYnHGeJw+JXtL2xyaSCqVoNLVDXxtbTc?=
 =?us-ascii?Q?D5NaNgbkuR67JITfduq6H0tiNJ2Zowt9IpWk1W20DDTJ2j4HY0sVkfWhgolJ?=
 =?us-ascii?Q?5klloFAtRPS9Gf0d7YvG73EH4RmdLmXhVW/5erKMBjejArwJ2V3D1R0HEuPH?=
 =?us-ascii?Q?VlBaIhwCVoFIQOHkVZB4Ez3es4THRjzvFfV9E3t9OfNywYf/cpytNL9LDz+/?=
 =?us-ascii?Q?8yk3MDwV+7mohe3+1kSGGqzc3Kg50UAiOuk0PtxJDVNXC4impQ3dm2rIlVZQ?=
 =?us-ascii?Q?NvPRUd6/3Kj2bpLvpcouEjXQjnJq+lg0Su1WQzZX22IZ5XmwMd00JcDVpSBv?=
 =?us-ascii?Q?oPvzEq8KjCsCFwReqS5Bu5dkyIWgW6D8xiKuZdTo7qMBUJBkDMMcXrGVAwPc?=
 =?us-ascii?Q?GudQwv56i4Yb2aWDAOPtCb9tFZtf/ryWfE+f8+M3JRB4aUVfk9eKG7sguqZ2?=
 =?us-ascii?Q?2dyCZcOB1wa1VLMm0F0yYXaYSMvCu4b4rMGeeqAqCOQwcoJfj/VVbnNU7PA6?=
 =?us-ascii?Q?DI/lwDzWDVZl9JdhyCa4lNQy8gryf0g1YypgXGwmRBS/ek5MMRufKclQBeWA?=
 =?us-ascii?Q?IDfaDwRuM2fdUfCyNzIyVRnPbwLtNBpN+lkHLSZHteJdxPLxt7xJ+tF972Ja?=
 =?us-ascii?Q?6yokTQVO+2t922TaesACZXjl?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR02MB2612.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27777e3a-1ea5-42f6-350c-08d8de2cc3ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2021 10:11:51.9010
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dRS6KXGYTdc1t/W4mGTdkaIUY4c1pUA+0RdGnr3kOV1JXUsGg4C1s1oYt2kfkxpfgMSHvcI9gyI8qcq4VzLcdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB2226
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Ping!

> -----Original Message-----
> From: Nava kishore Manne
> Sent: Wednesday, January 27, 2021 2:43 PM
> To: Moritz Fischer <mdf@kernel.org>
> Cc: trix@redhat.com; robh+dt@kernel.org; Michal Simek
> <michals@xilinx.com>; linux-fpga@vger.kernel.org;
> devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org; git <git@xilinx.com>; chinnikishore369@gmail.com
> Subject: RE: [PATCH 1/2] fpga: mgr: Adds secure BitStream loading support
>=20
> Hi Moritz,
>=20
> 	Thanks for the review.
> Please find my response inline.
>=20
> > -----Original Message-----
> > From: Moritz Fischer <mdf@kernel.org>
> > Sent: Friday, January 22, 2021 10:47 AM
> > To: Nava kishore Manne <navam@xilinx.com>
> > Cc: mdf@kernel.org; trix@redhat.com; robh+dt@kernel.org; Michal Simek
> > <michals@xilinx.com>; linux-fpga@vger.kernel.org;
> > devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > linux- kernel@vger.kernel.org; git <git@xilinx.com>;
> > chinnikishore369@gmail.com
> > Subject: Re: [PATCH 1/2] fpga: mgr: Adds secure BitStream loading
> > support
> >
> > On Mon, Jan 18, 2021 at 08:20:57AM +0530, Nava kishore Manne wrote:
> > > This commit adds secure flags to the framework to support secure
> > > BitStream Loading.
> > >
> > > Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> > > ---
> > >  drivers/fpga/of-fpga-region.c | 10 ++++++++++
> > > include/linux/fpga/fpga-mgr.h | 12 ++++++++++++
> > >  2 files changed, 22 insertions(+)
> > >
> > > diff --git a/drivers/fpga/of-fpga-region.c
> > > b/drivers/fpga/of-fpga-region.c index e405309baadc..3a5eb4808888
> > > 100644
> > > --- a/drivers/fpga/of-fpga-region.c
> > > +++ b/drivers/fpga/of-fpga-region.c
> > > @@ -228,6 +228,16 @@ static struct fpga_image_info
> > *of_fpga_region_parse_ov(
> > >  	if (of_property_read_bool(overlay, "encrypted-fpga-config"))
> > >  		info->flags |=3D FPGA_MGR_ENCRYPTED_BITSTREAM;
> > >
> > > +	if (of_property_read_bool(overlay, "userkey-encrypted-fpga-
> > config"))
> > > +		info->flags |=3D
> > FPGA_MGR_USERKEY_ENCRYPTED_BITSTREAM;
> >
> > Can this just be encrypted-fpga-config/FPGA_MGR_ENCRYPTED?
>=20
> In Encryption we have two kinds of use case one is Encrypted Bitstream
> loading with Device-key and Other one is Encrypted Bitstream loading with
> User-key. To differentiate both the use cases this Changes are needed.
>=20
> Regards,
> Navakishore.
