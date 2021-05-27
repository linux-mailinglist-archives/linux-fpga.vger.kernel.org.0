Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE2D392C11
	for <lists+linux-fpga@lfdr.de>; Thu, 27 May 2021 12:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236236AbhE0KpI (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 27 May 2021 06:45:08 -0400
Received: from mail-bn8nam11on2062.outbound.protection.outlook.com ([40.107.236.62]:39920
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236157AbhE0KpH (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 27 May 2021 06:45:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=evw8jmOxdfoLdHkU7OhISpr9AotBQ6jwde9sGqpQuKQ6fLEIlWJprYPE8SFwm8PvpPlVFilnZWHgoHGM8KsnzCLoAFFwPCs0JT8O6kw83sSVzJbjzn0azGNt5inoIFCN6S1KC6epDEL9wWwZQSBh+XVHVS+SEfJ1Q6Gvkmx7z6FooYuckaHx9DajkOIWepnYlsUwMJ6ZPBB6SSe47w0KT5PZLoi7oISPwqhMCMLOGHCCrXnEpDdsrmpLE7FFi/zZoOi2zTbIkcauJj2nQK6tF8Qciinbnu0nz9FjE6K4tLxDH3jEvly56hpp6HIRemwaU4QfIvqfO+0Nc3h/XZGjWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0vPLvgddIWKvOcMSqzCaFibILYPissoMyobekvahsAA=;
 b=FGzi0vntHCTa/sMRUsrjCXXF1xSZAPZd9vCS17368Xr/7YK+cXn9nDlfV5rVo9fYA8MEoBrj3xMAzQrBU1cW1LV2WiK9kVPGt/EL2mNiUajnXodfoZHStID/Ks0sGeuaDjRiuWPFTL6JnVROF9mErfM3nNhjp79E/TbvIYi46EfCozEiAAPAauhNN1tuDoF2QhYLPUeARMK5Ky5uhxzYlT66LAP54J3uSD+YdJ1j9Z8uGgKoxtPY/Hv/qbXKynJOZ/RojKJbodgoKGMJuBiQAJk11/Xlfy40COr1DKfqdWEQU5F5vVMJOX3b8VoqvaWyUhmN0wQahr6YqKKOHwTG9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0vPLvgddIWKvOcMSqzCaFibILYPissoMyobekvahsAA=;
 b=BjCprBh0xNs0fhhFSPUxNEE7FERkA6pg7doaUKc7lTKz2dY6W78i8bZXCcSEEKRnrxL2PzbWeFVG5i742JmOtDBGDCM9t9ZIBdbFKXpqsWBVxtq3GOic67O2fTZ854dF8dVgbdwiMIC9BcRDNgJ72CDxgKY7mP3tu/wGE+XlWd0=
Received: from MW4PR02MB7332.namprd02.prod.outlook.com (2603:10b6:303:79::18)
 by MWHPR0201MB3482.namprd02.prod.outlook.com (2603:10b6:301:76::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Thu, 27 May
 2021 10:43:30 +0000
Received: from MW4PR02MB7332.namprd02.prod.outlook.com
 ([fe80::a5e1:28aa:7a36:e6c2]) by MW4PR02MB7332.namprd02.prod.outlook.com
 ([fe80::a5e1:28aa:7a36:e6c2%6]) with mapi id 15.20.4173.021; Thu, 27 May 2021
 10:43:30 +0000
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
Thread-Index: AQHW7UWZwDiwSbkqzUWMwmmZwUyntqozISAAgAgZmKCANxU1wIBrXauAgAFH0bCAGPoWwA==
Date:   Thu, 27 May 2021 10:43:30 +0000
Message-ID: <MW4PR02MB733201057C43C9EEC54EF255C2239@MW4PR02MB7332.namprd02.prod.outlook.com>
References: <20210118025058.10051-1-nava.manne@xilinx.com>
 <YApf1jlEghbnDFo/@archbook>
 <MWHPR02MB2623B63A5359BB35B89BF086C2BB9@MWHPR02MB2623.namprd02.prod.outlook.com>
 <BN6PR02MB2612733F9D85ED6A36BBF801C2989@BN6PR02MB2612.namprd02.prod.outlook.com>
 <YJlw5fk0ORhioDb4@epycbox.lan>
 <MWHPR02MB2623E6E6759FA574129901E7C2539@MWHPR02MB2623.namprd02.prod.outlook.com>
In-Reply-To: <MWHPR02MB2623E6E6759FA574129901E7C2539@MWHPR02MB2623.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.50.128]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0f029725-8a6c-49b2-62a3-08d920fc44e8
x-ms-traffictypediagnostic: MWHPR0201MB3482:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR0201MB34824F1A9FD710436CD17179C2239@MWHPR0201MB3482.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:843;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kNktENTnfr9SRN1v2vuhEdfXRVziZeGXSmvBHmCT6Wg0NsNbZHQmzEooOQgh4owX0sMWkYl2g4n3+oMpjT5bEePfZ8MgaL3Pij0VqhDdGhJ65YgmejIzz02t/DiDcR+gbHbcx1uEbNv9ZprcW9lBBlI+ak6O5pBDKoPzv5VibUodgBxFvtZTFHxINSYPZ1mcj29SvoCeXS6BwIfc1+hT0+bsnMdC875BiKK4OV33S5sjcXibmoKnKwoj3/N1dC1Z/Xa2pHFZlU7cAIN+5IFWSSIgWGOwqH4kBOtl2ytAPXobOkMddObNy3Bc7e6xrEDYy9vtQI+rS2pv0iWJ/cc7dm9OfI8gbp2z8+SVH4eEWY2ZR3B+HVUvsH8fn7csy+ZC9UZ/9vTyenyeVC8XqhWARiGAEDZ489l9a1/3EgLduQlTfbpqt1ZoOnUex5vmTjdHZOVxb1djn/wbtZ2kgU/tcA8l6rKLGs5DFMHa3FIj7+Pd93Xqb6Nro72aY1+e/caWwqxmdOoHdY7bZfqsI6bjFS1q/CO69Xhi0SGhAuwkoygqbwEIzYluXFoKWWafBevAn3K7G7OnjxyE6xkRmUxClWxOHUeiHmjROgC7nAk7Avo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR02MB7332.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(39860400002)(366004)(346002)(376002)(316002)(33656002)(66556008)(122000001)(66476007)(8676002)(38100700002)(8936002)(66946007)(66446008)(83380400001)(6916009)(64756008)(86362001)(71200400001)(2906002)(55016002)(6506007)(53546011)(26005)(478600001)(76116006)(4326008)(7696005)(9686003)(54906003)(52536014)(186003)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3l8dwNNOewDhAxdnNtz5vJaDJIiwL5hZbIQfm08ICalXIsCC5Jz2zqakvjOh?=
 =?us-ascii?Q?grMQmnlVlmM0NtPJC/R4fefE2j6QVbAe6AMGSdi2K1rNFeTU8SDFqODBVwQm?=
 =?us-ascii?Q?yqrWN5XwT+H30Womh4JhdAcPe9WerzeXGu/7W3F2OivH+w2CdXcLfmHqA0za?=
 =?us-ascii?Q?FzWe1+UR8yymRJGc+9uFayXxwu+3hrfQ0Ux3ipQwbdGFZWC68YXlPFQ97v5B?=
 =?us-ascii?Q?PL7tDboiS2difoft2nes3kob9EKYFvRHVpEzkENYdQNe4yt/tIt1y91TfUcd?=
 =?us-ascii?Q?6h7YI2VwGvP6UTjv4Bx+8kmqR/R71YAekJ1dOshRPCbwkI3kMxwr8mB4HgbP?=
 =?us-ascii?Q?5hN7n0S9x1Ymz5J0iFtHCeWoH+EuFqZ9XdxJ3bnHKn/qk6jB/ZomGZqphIoJ?=
 =?us-ascii?Q?uXNxHaYxxT0D07EPzAfnIjkbSqYILt6B0m4dT4qVlTg9XhRKSO9qGSrwB71b?=
 =?us-ascii?Q?58WMOvKp33t6wCYETPv3iMNze3BrlyF4YX2/JREQxplUEzTycxYEEBiiHhgC?=
 =?us-ascii?Q?q9Lw4PXv63h94GVb5IE4/qkDsJivaKtKGe02rEenPIYtSf38khsQM5oSEAs5?=
 =?us-ascii?Q?NnOZv4PQuuqFAuuMYGOAuZNRUhnkI7U4rEZZnI22FVpHZuhmVjLcoPvqXBRC?=
 =?us-ascii?Q?UvfWq3j955bUNiipCvLsl3Boemipix1mCwJa94Gx693Y6aU8KBHODHUQ6l9s?=
 =?us-ascii?Q?6ah8VB7i8GaWuPUI2C7UTl2P6NRiIPJIkEN3EPL8wFdo2PoWM8HsHj4qYcbD?=
 =?us-ascii?Q?v+xjFyFUGnWYPvG2TNDzPNBKV2sMrVfBYZttv1Zm4GStAbMIfZG79eV2mCDF?=
 =?us-ascii?Q?iBX0iMKtgPLg30xABNlU4v0qWCoQLiopRxd3S7yfsoO76hfnXO/TRhNV9FAQ?=
 =?us-ascii?Q?WS/vmnCHOCrLAZxfZiU0J4jATHDhWFrX/0BvpTjrzMX5LmgXrQLmYARgfh1t?=
 =?us-ascii?Q?BBZJouQn1AiR0fZQrFxgmc/xEajs2lxJRC5ddLK7?=
x-ms-exchange-antispam-messagedata-1: q3RHf5lpcsxrlVOzlJCMnLH9YOqVlshsXnxhx2bobU+G41cj3oUvAeWj9IlQLPhXrle4OJjFtrpoapcUnVxNeHW1HgTFIe8YoHDEvsLl1Cm7IffaY4jHvMPaPS4fbl/JdK3R8uurotmBmDAmYdt3UmIClaPj0gTXtE3gbKmv7mNAz1R70rA/iTeLtxYFicyAi5hwuctXm6GlVPOW1Bw7PSHY9E2Q5Jc6lo0tPgRrjMqegHsIFoIPVOPrG1uBoYpn8Af9MSirfd4RvOJ7PhvsAqQjVnKarZS3vPgzqy3/NTQzx3diOhVImNDln2yB1yKxv430/w1HzwYB+XokG0JWf2UP
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR02MB7332.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f029725-8a6c-49b2-62a3-08d920fc44e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2021 10:43:30.8926
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 511DWmTWM2FYStbi5W2xcgv65yNjGAH74B9iti9NBiO9IvefFWJJipJulIy3xwmaBMAHqEB9O3R0zfO+BzHrPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3482
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Ping!

> -----Original Message-----
> From: Nava kishore Manne <navam@xilinx.com>
> Sent: Tuesday, May 11, 2021 7:02 PM
> To: Moritz Fischer <mdf@kernel.org>
> Cc: trix@redhat.com; robh+dt@kernel.org; Michal Simek
> <michals@xilinx.com>; linux-fpga@vger.kernel.org;
> devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org; git <git@xilinx.com>; chinnikishore369@gmail.com
> Subject: RE: [PATCH 1/2] fpga: mgr: Adds secure BitStream loading support
>=20
> Hi Moritz,
>=20
> Please find my response inline.
>=20
> > -----Original Message-----
> > From: Moritz Fischer <mdf@kernel.org>
> > Sent: Monday, May 10, 2021 11:14 PM
> > To: Nava kishore Manne <navam@xilinx.com>
> > Cc: Moritz Fischer <mdf@kernel.org>; trix@redhat.com;
> > robh+dt@kernel.org; Michal Simek <michals@xilinx.com>; linux-
> > fpga@vger.kernel.org; devicetree@vger.kernel.org; linux-arm-
> > kernel@lists.infradead.org; linux-kernel@vger.kernel.org; git
> > <git@xilinx.com>; chinnikishore369@gmail.com
> > Subject: Re: [PATCH 1/2] fpga: mgr: Adds secure BitStream loading
> > support
> >
> > On Wed, Mar 03, 2021 at 10:11:51AM +0000, Nava kishore Manne wrote:
> > > Ping!
> > >
> > > > -----Original Message-----
> > > > From: Nava kishore Manne
> > > > Sent: Wednesday, January 27, 2021 2:43 PM
> > > > To: Moritz Fischer <mdf@kernel.org>
> > > > Cc: trix@redhat.com; robh+dt@kernel.org; Michal Simek
> > > > <michals@xilinx.com>; linux-fpga@vger.kernel.org;
> > > > devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > > > linux- kernel@vger.kernel.org; git <git@xilinx.com>;
> > > > chinnikishore369@gmail.com
> > > > Subject: RE: [PATCH 1/2] fpga: mgr: Adds secure BitStream loading
> > > > support
> > > >
> > > > Hi Moritz,
> > > >
> > > > 	Thanks for the review.
> > > > Please find my response inline.
> > > >
> > > > > -----Original Message-----
> > > > > From: Moritz Fischer <mdf@kernel.org>
> > > > > Sent: Friday, January 22, 2021 10:47 AM
> > > > > To: Nava kishore Manne <navam@xilinx.com>
> > > > > Cc: mdf@kernel.org; trix@redhat.com; robh+dt@kernel.org; Michal
> > > > > Simek <michals@xilinx.com>; linux-fpga@vger.kernel.org;
> > > > > devicetree@vger.kernel.org;
> > > > > linux-arm-kernel@lists.infradead.org;
> > > > > linux- kernel@vger.kernel.org; git <git@xilinx.com>;
> > > > > chinnikishore369@gmail.com
> > > > > Subject: Re: [PATCH 1/2] fpga: mgr: Adds secure BitStream
> > > > > loading support
> > > > >
> > > > > On Mon, Jan 18, 2021 at 08:20:57AM +0530, Nava kishore Manne
> > wrote:
> > > > > > This commit adds secure flags to the framework to support
> > > > > > secure BitStream Loading.
> > > > > >
> > > > > > Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> > > > > > ---
> > > > > >  drivers/fpga/of-fpga-region.c | 10 ++++++++++
> > > > > > include/linux/fpga/fpga-mgr.h | 12 ++++++++++++
> > > > > >  2 files changed, 22 insertions(+)
> > > > > >
> > > > > > diff --git a/drivers/fpga/of-fpga-region.c
> > > > > > b/drivers/fpga/of-fpga-region.c index
> > > > > > e405309baadc..3a5eb4808888
> > > > > > 100644
> > > > > > --- a/drivers/fpga/of-fpga-region.c
> > > > > > +++ b/drivers/fpga/of-fpga-region.c
> > > > > > @@ -228,6 +228,16 @@ static struct fpga_image_info
> > > > > *of_fpga_region_parse_ov(
> > > > > >  	if (of_property_read_bool(overlay, "encrypted-fpga-config"))
> > > > > >  		info->flags |=3D FPGA_MGR_ENCRYPTED_BITSTREAM;
> > > > > >
> > > > > > +	if (of_property_read_bool(overlay, "userkey-encrypted-fpga-
> > > > > config"))
> > > > > > +		info->flags |=3D
> > > > > FPGA_MGR_USERKEY_ENCRYPTED_BITSTREAM;
> > > > >
> > > > > Can this just be encrypted-fpga-config/FPGA_MGR_ENCRYPTED?
> > > >
> > > > In Encryption we have two kinds of use case one is Encrypted
> > > > Bitstream loading with Device-key and Other one is Encrypted
> > > > Bitstream loading with User-key. To differentiate both the use
> > > > cases this
> > Changes are needed.
> > > >
> > > > Regards,
> > > > Navakishore.
> >
> > Is this region specific, or could this be a sysfs attribute?
> >
>=20
> These changes are region specific.
>=20
> Regards,
> Navakishore.

