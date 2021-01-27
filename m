Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A598030561B
	for <lists+linux-fpga@lfdr.de>; Wed, 27 Jan 2021 09:49:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbhA0ItI (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 27 Jan 2021 03:49:08 -0500
Received: from mail-eopbgr680068.outbound.protection.outlook.com ([40.107.68.68]:20855
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231348AbhA0IrG (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 27 Jan 2021 03:47:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nfxwo4uWkj1EBlaWqm0jG6OaK2If/B8c0ExW1E5loCMzjregDtY0VynLyCmLElsG8vq/f7nVOho3r03be1PgmIbaxOzaITAYaq+buqG2gVNsHoh7fuRJ7JIqhAGRpywI7ShwGXxa9q9C5QTvvNB0uAXWcGKA+00L4nnfH/pkr9VSbmZ+c7AQt8oIw4NvJJFBWN38BQFTGbP+6ct6v1XTh3P9xfxGp0PM/nBxkfHy8eJULL3TrNN27Rw9XKTyO2ZJ58ePRdOhWMbGlRgkiADMVngHikaA4FmSsLp3lUpMkDlD7j0ZMI5RZMtihI7tuM8qvt9IHMtj8Ef5hksa7F7/HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V2SDpuglLN+KsWXmD2R900j9lAm3ER2m7XavpulM4NA=;
 b=V7vePzKjSSMvzW8t6K9ZnAGI5MN+VGOD1VyF92nH/BoUx5+0DDAiqfu7k/5p1LWo+fmYDRrzBoU4wgc1eNzNyvo5Y5z3ZHo6wZONFQq8oa+pQ/u8Na/n8vtVg+JV3KpwpcgyGNl58qgiRgjOqgwRsD2eFq18xXmsnZbDWoPKr9Qfew15D24Q2ZsnW27lJGqxx7ymlukisHiqxQuTcN9gxozMfooyiiLT8pkjZ+AiMJEuoCsh/U0aZjVceaew2nFAe9AJvFfzbkp5wxK21vmMo6ArmOk/L30gApD3EBoeikYwF3gObtuspsJku/hY+/iPqOeiCJ5WTfW051OXj7JjyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V2SDpuglLN+KsWXmD2R900j9lAm3ER2m7XavpulM4NA=;
 b=AKk3q1tsnAxdkPUzi+ncDJAGPOcNxWl+KRPrGIEOdv2wMK0fIHO6Bfe/YCNL186ypjMCa8kxKfH4pkDSEF2Etcz/CtnnQRQQmkQmdPPifkG+X2ufBFmn/gDe38JIPOJrmlEoWrJcdpyTxpTheU4H9PK9UWh/t2oytticSbt5f/Q=
Received: from MWHPR02MB2623.namprd02.prod.outlook.com (2603:10b6:300:44::9)
 by MW2PR02MB3882.namprd02.prod.outlook.com (2603:10b6:907:8::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16; Wed, 27 Jan
 2021 08:46:15 +0000
Received: from MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::c4a8:8d45:c13b:9942]) by MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::c4a8:8d45:c13b:9942%3]) with mapi id 15.20.3784.019; Wed, 27 Jan 2021
 08:46:15 +0000
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
Subject: RE: [PATCH 2/2] fpga: Add support for Xilinx DFX AXI Shutdown manager
Thread-Topic: [PATCH 2/2] fpga: Add support for Xilinx DFX AXI Shutdown
 manager
Thread-Index: AQHW6t9xKUyYsQdkFk2NaePj2u7pYKopkSiAgATukeCABKWmAIAIFNLg
Date:   Wed, 27 Jan 2021 08:46:15 +0000
Message-ID: <MWHPR02MB26230510C77BF1FBBB571898C2BB9@MWHPR02MB2623.namprd02.prod.outlook.com>
References: <20210115013431.27667-1-nava.manne@xilinx.com>
 <20210115013431.27667-2-nava.manne@xilinx.com> <YAJWT4IDPmHneam1@epycbox.lan>
 <MWHPR02MB262353F2D236B6AD787FD5EFC2A30@MWHPR02MB2623.namprd02.prod.outlook.com>
 <YApfYL5swV46IsQG@archbook>
In-Reply-To: <YApfYL5swV46IsQG@archbook>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.50.128]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 36c2cbb2-b8e7-480b-fdb2-08d8c2a001c1
x-ms-traffictypediagnostic: MW2PR02MB3882:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR02MB3882551FF382AA4BB4F113EAC2BB9@MW2PR02MB3882.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RUDvDbV813lXoV6o2azYXMGnKqPBhpWWAn6LUulg5JHQMBdOOwy3MzkKze42/nXwdkZB30oKVTIwNVYB/3gUUm7BrEwTwkeClNjNIAMdKanEfEflKdsZZN1rO//ldeQAZRKsRiPz9vSjAi3e4IHYU0F3cIXwugkdSYwfcr10InHGYaePgyfFyidIV7sl9lkq+v8zwaM6cLxOD6rKk2/wDCzDT+vHc/zXqtLM5ZjPkO6MPdJQq2LBWKDHD+fji2JImiJvyaLow/bDHKyTfGndNU7iYLPCdQXTkB11zUsUVPVVxbuP2BSiY7ZAGXNHA/qh61qyqW+VbEZuEs141JCHICwsPweoAZuczCboPUdA4aFKInkdiD9qyZlUvMzFjfBM1qYNkpDrHjKrp84WSzO4KAGiyjvpZo0SxPda/II8nr9T7P91XkTYSAXZG0LQRswi+94IgzRN77uDsrpx9pcX5OEwemhO2UQUwsBJe8YzR5tX3PBpkTeUKin4g02ZrhuWT23vl5II5gPUHQGbVvkPT0zgKujqd0BLmAr1rvoIeEfmracURANNFVbolW2214m8KsYwjrrDIP9BvdU6cTlk35XJBi8mtGdaVDaI0VJguSo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR02MB2623.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(366004)(136003)(39860400002)(376002)(186003)(316002)(8936002)(55016002)(83380400001)(478600001)(71200400001)(4326008)(6916009)(33656002)(8676002)(966005)(9686003)(26005)(66946007)(66446008)(7696005)(64756008)(6506007)(66476007)(76116006)(54906003)(66556008)(5660300002)(2906002)(52536014)(86362001)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?DzKZW8+IAxSi8PnAL4YIUDA15RZKRAX8HXJL3ZUmwEiTGiRcr1nLi0m27dcm?=
 =?us-ascii?Q?GDVolSR1r4nsp5krl+U+cM1qDvae5rt8hPty3yViQALfIBxgRLpTHMi4nY3d?=
 =?us-ascii?Q?0QFNi42cDAjFnB3ZNaEjktC4rNSv6qpOHx1ZohXA8W2ydajZxCVk3oEDgWue?=
 =?us-ascii?Q?bc8Mf/pr3XIzgPVL+E1+3ZGTltmzCWCfMsHXn8eC7JOqJYtaB2luTIsjKTq3?=
 =?us-ascii?Q?0Uwn3f31WKqW09fxVwlj++qn9oxGgtnRCu/Q5Dlv4Kr7oqWJTP0N3lYs0Fm3?=
 =?us-ascii?Q?gFm7dEfDg1fcwT+16KGoL6Lfw3tfANKeoMW4L7W/DcLiMzimpHWli5O9Wevg?=
 =?us-ascii?Q?8He3T7KzcsimQ07hOjor0WaBw/ZEjk8KeOByaKlQL+f9zoWAjdN//zf9/J7R?=
 =?us-ascii?Q?kevK5G3Ic6CUIQY53vJ+TeRig9AI9kciVQ+WCzrAKzuX0SK0Fq+w7f4Z/KXN?=
 =?us-ascii?Q?kyvzfHM7dCeYwp2DM+SEtTK40qagqMxjetHknw/rU6Eyj5LQazZhgr6hHHwY?=
 =?us-ascii?Q?IqAQTQJpNbVa4gDfT0c5d7l7+ZE+ilTMtZkCE93b7Cduo0g2QyMIoImqHTCC?=
 =?us-ascii?Q?GMC9euuNQcYGHEwGvXy44ef7eY/MtkiP75+M3Tsg5ioKPJubzPk/USHFaq29?=
 =?us-ascii?Q?JmQDj9pAcWPL6dO5oLj9Ua54YJ0QOOxlW2NIuTOxhWD0RmO3aoWYOgsggiBB?=
 =?us-ascii?Q?jpbuVOnMKjXPy89IMkbPfP4XtWAH/ZTwYxIRsYNe5GVp0hP02EGNgic5po5U?=
 =?us-ascii?Q?tx9e+QWxocjC324ZDlwWSZUFLxB+vCjJuniQ+yW4Lv0Qae5VKPALWoerid36?=
 =?us-ascii?Q?Y2hZ8+P1Vjv2ogbU2IGNpERPe1XMKp8dvzSKZycKQu35F1l3rRsLe0QiAMls?=
 =?us-ascii?Q?S7rQU8MdSDtnBJ90OkBqi/UGqUUyopHGHkOTEDsA6THbvkFOie6GxJnOc7ai?=
 =?us-ascii?Q?aycd9oEbun/0PIqTdcAv/uH67yoLaBAlMKb6bAq3cErkQDzAbucVlIZZ3MRT?=
 =?us-ascii?Q?EGerkA+9a9nqJweon+iI4l434E+RTbuByYZYhRNC3b9Rt3PUJ8mbHcfsbn3A?=
 =?us-ascii?Q?pfEGFaX4?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR02MB2623.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36c2cbb2-b8e7-480b-fdb2-08d8c2a001c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2021 08:46:15.2162
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vHvJRc7D3n3LyCNtCRWUUOFWmptPVIf8KS7m9lLJMNtdNcHapQP6NLK+QrWWikeZUNb+FkrbvV0/DdrDnTr1Kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR02MB3882
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Moritz,

	Please find my response inline.

> -----Original Message-----
> From: Moritz Fischer <mdf@kernel.org>
> Sent: Friday, January 22, 2021 10:45 AM
> To: Nava kishore Manne <navam@xilinx.com>
> Cc: Moritz Fischer <mdf@kernel.org>; trix@redhat.com;
> robh+dt@kernel.org; Michal Simek <michals@xilinx.com>; linux-
> fpga@vger.kernel.org; devicetree@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org; git
> <git@xilinx.com>; chinnikishore369@gmail.com
> Subject: Re: [PATCH 2/2] fpga: Add support for Xilinx DFX AXI Shutdown
> manager
>=20
> On Tue, Jan 19, 2021 at 06:34:54AM +0000, Nava kishore Manne wrote:
> > Hi Moritz,
> >
> > 	Thanks for the review.
> > Please find my response inline.
> >
> > > -----Original Message-----
> > > From: Moritz Fischer <mdf@kernel.org>
> > > Sent: Saturday, January 16, 2021 8:28 AM
> > > To: Nava kishore Manne <navam@xilinx.com>
> > > Cc: mdf@kernel.org; trix@redhat.com; robh+dt@kernel.org; Michal
> > > Simek <michals@xilinx.com>; linux-fpga@vger.kernel.org;
> > > devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > > linux- kernel@vger.kernel.org; git <git@xilinx.com>;
> > > chinnikishore369@gmail.com
> > > Subject: Re: [PATCH 2/2] fpga: Add support for Xilinx DFX AXI
> > > Shutdown manager
> > >
> > > Hi,
> > >
> > > On Fri, Jan 15, 2021 at 07:04:31AM +0530, Nava kishore Manne wrote:
> > > > This patch adds support for Xilinx Dynamic Function eXchange(DFX)
> > > > AXI shutdown manager IP. It can be used to safely handling the AXI
> > > > traffic on a Reconfigurable Partition when it is undergoing
> > > > dynamic reconfiguration and there by preventing system deadlock
> > > > that may occur if AXI transactions are interrupted during
> reconfiguration.
> > > >
> > > > PR-Decoupler and AXI shutdown manager are completely different IPs.
> > > > But both the IP registers are compatible and also both belong to
> > > > the same sub-system (fpga-bridge).So using same driver for both IP'=
s.
> > >
> > > I'm a bit confused, the whole goal here is to give the thing a differ=
ent
> name?
> >
> >
> > Both the PR Decoupler and AXI Shutdown IP manager IP's are follows same
> register spec.
> > Most of the code is common so we thought of reusing  same driver for AX=
I
> shutdown manager as well.
>=20
> What are the differences, though other than it shows a different name?

The PR-Decoupler And Axi Shut down manager are different IP's=20

PR-Decoupler IP can be used to make the interface between a Reconfigurable =
Partition
and the static logic safe while Partial Reconfiguration is occurring. When =
active,
user-selected signals crossing between the Reconfigurable Partition and the=
 static logic
are driven to user configurable values. When inactive, signals are passed u=
naltered.

Coming to the Axi Shutdown manager IP it's safely handles AXI4MM and AXI4-L=
ite interfaces
on a Reconfigurable Partition when it is undergoing dynamic reconfiguration=
 (DFX),
preventing system deadlock that can occur if AXI transactions are interrupt=
ed by DFX.

For more details please refer the below links:
https://www.xilinx.com/support/documentation/ip_documentation/pr_decoupler/=
v1_0/pg227-pr-decoupler.pdf=20
https://www.xilinx.com/support/documentation/ip_documentation/dfx_axi_shutd=
own_manager/v1_0/pg377-dfx-axi-shutdown-manager.pdf =20

Both the IP functionality's are different but the IP's registers spec is sa=
me and also they fall under
the same bridge drivers category and most of the code is common except the =
naming conventions.
So we thought of using the same driver for both the IP's with different nam=
ing conventions.

Regards,
Navakishore.
