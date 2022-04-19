Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B45B55066C9
	for <lists+linux-fpga@lfdr.de>; Tue, 19 Apr 2022 10:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233548AbiDSITY (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 19 Apr 2022 04:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349933AbiDSISn (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 19 Apr 2022 04:18:43 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2067.outbound.protection.outlook.com [40.107.212.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 405C4DF2A;
        Tue, 19 Apr 2022 01:16:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l3RcDtHvH0kQJFG2UT2ezr/x2+n4bN+gh78Sgt8ysoFLsHxNqPoutaCY/N6lmzVHRMlSqNi0GKpOiN/+TCHxWWIpHWHcAkSSV91LLWdX0mzKn0rKdZqg9YOKJ8JtAaFM4iR/URjGQowTvgCmDj6/i5SJKKFMtUyGVJCecszeTlxraxAcSOeu7yfyRaQjBtqYqwJUjFzuIX8mpVJuwQlBjxkig8kWX1iGFQ+aNk4vqDJbf0ocMtxntoOcUBY+lCldJUUci1MwTe/VXbs9c25Ulwq0vZP2S5v4W+zgsJIQwMx8qdyye2L5UFNXr5Ug+XeUydGFJL2B3V7THJiQtNT4Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9YilMnMujyx5pKqlPeCdUgQ0CkASsaEEqvMdlzbmTLQ=;
 b=iGoFzKIvy0P10x/38+m+zBM1tc4aF475hMk9ngsevvbVnmU8VaB4Nf8fy6vCMHsBXegXXIH2eZu6EFB4So1kiNR/uR+ysE6ZL4JwTnz8O0wN2XFSDd4z/J6/q7V70kfqyjs8mrS4Jt9oZByhI9vCa2m647zwepj0mwpn6Y8QjBfbxPc4+hy4LOek0U59C67BoHBsvXjYxKcQ4m3Hjjbac5pI9q/BpEf9nbHyO+frCrwvRr3SXQoMp6tLXb1+dI2vwVGVEiTJfVy9jTZI/1WbEUvfhV45BJJ+beNLxB/5lAp/iTK5x+FXmrm+2znff1/rEJy0zu8ZFvfINzuOsTMagg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9YilMnMujyx5pKqlPeCdUgQ0CkASsaEEqvMdlzbmTLQ=;
 b=cSDUYG38Mh5+sdvMRb0JHrXDEbpJ+WaWZMgcWTsJnoRWT2oxmPQp85IFQojSGMqnhi5dcF4BFSbhRsXJLUk8TtdudcCDcw2fBCzOMkxrLPq9hONLsgBn3+X/zOEAGzihTOowxcuj4A4j6H0k5qnJiRBNF2haHtdEUaSPlWrBMVY=
Received: from SN6PR02MB4576.namprd02.prod.outlook.com (2603:10b6:805:af::17)
 by SJ0PR02MB7856.namprd02.prod.outlook.com (2603:10b6:a03:321::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Tue, 19 Apr
 2022 08:15:57 +0000
Received: from SN6PR02MB4576.namprd02.prod.outlook.com
 ([fe80::f1c0:bdc3:9a56:d6d0]) by SN6PR02MB4576.namprd02.prod.outlook.com
 ([fe80::f1c0:bdc3:9a56:d6d0%7]) with mapi id 15.20.5164.025; Tue, 19 Apr 2022
 08:15:57 +0000
From:   Nava kishore Manne <navam@xilinx.com>
To:     Joe Perches <joe@perches.com>, "mdf@kernel.org" <mdf@kernel.org>,
        "hao.wu@intel.com" <hao.wu@intel.com>,
        "yilun.xu@intel.com" <yilun.xu@intel.com>,
        "trix@redhat.com" <trix@redhat.com>,
        Michal Simek <michals@xilinx.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, git <git@xilinx.com>
Subject: RE: [PATCH v4 2/5] fpga: fix for coding style issues
Thread-Topic: [PATCH v4 2/5] fpga: fix for coding style issues
Thread-Index: AQHYUZcjkgksvVyG0kSyIxbadyFg96zyw0MAgAKsDPCAAC6tAIABPj+w
Date:   Tue, 19 Apr 2022 08:15:57 +0000
Message-ID: <SN6PR02MB45761359B029B065092F8691C2F29@SN6PR02MB4576.namprd02.prod.outlook.com>
References: <20220416133719.3382895-1-nava.manne@xilinx.com>
         <20220416133719.3382895-3-nava.manne@xilinx.com>
         <ac22068dad06fd61f2e82c0bf7c0f58a4e5df050.camel@perches.com>
         <SN6PR02MB45763D1B949353F99AAFE7D8C2F39@SN6PR02MB4576.namprd02.prod.outlook.com>
 <d56ad1bc0ef918cc8395b7c0ec7bdd10baf4c1f6.camel@perches.com>
In-Reply-To: <d56ad1bc0ef918cc8395b7c0ec7bdd10baf4c1f6.camel@perches.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: af047198-bd19-45da-a5af-08da21dcd4e6
x-ms-traffictypediagnostic: SJ0PR02MB7856:EE_
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <SJ0PR02MB78562EE31F9CD818FD705223C2F29@SJ0PR02MB7856.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9T6yGSAs1bLb0SpYB9ZcYQUx5eZg/HWpgNsmvjOkDZ28jLsDexBJkYXCzonwk0J0UZAIxHdfMG7jq6qkcrob2HgN+ZnwchC/CzFdcU3mAJBREeH3EcnoYdmiWxSwt6QNKznfdcha6vGd7aRGkS6HW+pmfh3XCkVLDVQ5ZMArHcDihJxUAZ6elEnq9Ki2MICN0qQlwmNniuEDVy0M/wxd2rAt31XXtBo3b1mQ7o+oWtH/p/fzj8PKzm1Kvx7nZ+b2Iom3Rt1rmMzTesm/Uw6B1zbqm2tnR/eatzhViKzXF+FbKWHml9z2We6Eru4aFRlq9cpCdYyFCbRq5TyJKcawYlOicEHwcSsQz0NiUSHC2SsaqHnsEuGVu7EMLY4o9fyYSusMGQ7lhLto1czfXY58ig4FRfjOhEkqUmML0PwEI50L8YP3kiYwOP5zfGc6mYDdV9oLHXs6xLxyuqtjqEjVZIHcg8hN3FxDrX6M1yNGSIABpvdfdLIxkFzLr2zUVmelJJoL+M7fPQ+zB2IAgizjdubobdudmQhuta6zxirE8ODBB3nq983LvETQA/hPoyVh8/ASYwNhAbxKBpIv9dE4t6lkM6AwXfOXo+SsLlA5GgzwesP9H+7Zj6Yb+D2JcbbsKHZDTt0iK0jGyYDbMKa6zIuk+EozqSTjUesiYth+A4ZFG+fHd9Lb3YpMKlnfnRYWHWOYxW6JAgGrEBqp5BMN2jVqSpPleMzI5iw2FZNuqAk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR02MB4576.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8676002)(2906002)(508600001)(921005)(52536014)(64756008)(66446008)(66476007)(5660300002)(86362001)(76116006)(66556008)(66946007)(38070700005)(9686003)(8936002)(83380400001)(122000001)(71200400001)(55016003)(6636002)(7696005)(53546011)(6506007)(110136005)(316002)(26005)(186003)(38100700002)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lcABBuQITT4Mw2nAAtx/RwscSDzsNrx5FSasHVw4ZOwskgrCoOS81LHk9+jb?=
 =?us-ascii?Q?uyGVMqHBiWgcZiB8Cyppk5Z6JAfgcRJKHn6rNMRS8IS2q4QNdF1cHtMi9XyK?=
 =?us-ascii?Q?weSD3NMlgGaeOSx5UNoKwsT+21t6pnNujRXgZ8znR3hVWNhApTti5sEiFxBJ?=
 =?us-ascii?Q?SE1h+2QLU48O5Q+kqhSaAMu0rzIKUF8v+l6GmwtQg4UuaJFfbDhRVYXwGxAc?=
 =?us-ascii?Q?+z4wCoaZa//u58rNgDELtiOOjTwQJtAj5NwbedkCXiDWpKM30GjZCW4F8Jv3?=
 =?us-ascii?Q?6Gv4fPXIJUDrUkH0mqrwV4qC0kC9rOEGPvHQ1kQRgbQLzESMIIQA4CdFTJFz?=
 =?us-ascii?Q?UnJUN5+wn7jbp1IY4eiCbzPnjf2WyViZIFsI6Xg3UTAe0hFzK7uc8XoRQLGo?=
 =?us-ascii?Q?aIspShjvD54jD9rnklQhFRlffmu7ob5cr2k6lEnfU0eecZmgOduYMUy3NQG3?=
 =?us-ascii?Q?wpDKTDd+PvA9tKoNwhvvvIhs7tGQP9vHPmzY8B/wKWicyXmYgMY23/UclTpZ?=
 =?us-ascii?Q?GlBRDJ3o/1U+f7cbVvzXDCkWlQF9BXbWtTpc0AUVpKSeMq/xeQCJkgUTwznz?=
 =?us-ascii?Q?fWajiy8mm4IWNPLLHLiXwhH25o1Q96nFTdEYGBCaHGBCWJDSqWj8CWX2tVor?=
 =?us-ascii?Q?O30tFsqYxfabWV1r3pzYcEd77QbP1QrjZHZmA/nUWptDt1qtzMvA5WecQGZC?=
 =?us-ascii?Q?gcXh3DOP/R6NRwt1SHu3vOmozHAnrTmC8qaLtIK8OYYEunQ6xOEw1Q+U40aY?=
 =?us-ascii?Q?YUP8HMAdnoLZBgLhqwdSPuBF+BlLyfZYvnPmT3djpgSi49LUAX0cBdTdC3DO?=
 =?us-ascii?Q?BbBE997lvv/YlLaFc9Rw3aX4pabHVYPh4ivF/4/tVO7gL3dAk1eRWdDtHlLR?=
 =?us-ascii?Q?nvJ0h05nc5sTdCpcxeo904zHTM5xO5A0HB2d1PiK8PrHaSbIGkfHKU5UOEwQ?=
 =?us-ascii?Q?OZiqBPmWNNN1Zg1J/R+zbmhJndMLrKbVfu3MwlP/zjmA6eWk3mUtZDAW1WS/?=
 =?us-ascii?Q?sjlYxmmhFR77GoRT3B+mUosZrxSfeBTtCfjZaMepOsBTKbEuTT+EVFglR8ys?=
 =?us-ascii?Q?AJnOwfU5/5E8VrGuKGU/ZlgaM7TvviyhfvwzBJnPggvL2S9O1aUAJtkXfOfE?=
 =?us-ascii?Q?rEM8Embr2+4sLgFOlfvAmIMYR9KjQ9xvxL7wrDwTJOSXi2WAjNOdU4SdLD0a?=
 =?us-ascii?Q?VLsdp2Hboi6mvRJBpgmP1VIr9TEyZ35hkz7cM21RY4ywHApnHhDXoqdSy9XS?=
 =?us-ascii?Q?WmJOjPU/F8Zfv1ssYgF53vgXPAlDkw+odIjxB9siOe4EsiwzdLXWGp/Pw1l7?=
 =?us-ascii?Q?AGmc1fEUvzAhIX34C0eaTEpDPBMhndcvMGdcdhO8401rFKkL06U6YTpBZ/FZ?=
 =?us-ascii?Q?5dQ9Kw2/RN+ZUj8TyOd27PRnhgnWhagHzhggaB6+K5DgGiolTz5Cb6OpmMXF?=
 =?us-ascii?Q?GMNECb2G1Str02DQ61eJh7aJheMFbA6NQB/TNwRHl9JhtvI6BNMNsdlKqCyS?=
 =?us-ascii?Q?G9f5d0okgGhg9ivDd/C+GT+v1n76HxeRCSHWRW2p32RXA86FS0GoTyjs/Ksj?=
 =?us-ascii?Q?LcFn5Kzm+lMnuCy9HaK+Bgi6LkRI4T6iiC9TETwBq+V7YtNLDqpjWFOC1a2c?=
 =?us-ascii?Q?7TYVr3mUa5tb2peTJN96x+xOTYmgJCBMrOZHZ2vJuuVTauw9ypN/BqQ9sW5Q?=
 =?us-ascii?Q?XrlJfFe+te7PlV3on48va9vHu6dxVagTbbv7O6SAWS2u1u8GzGKZKYG5enOY?=
 =?us-ascii?Q?EZ6Fj9xkAQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4576.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af047198-bd19-45da-a5af-08da21dcd4e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2022 08:15:57.3191
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rW+lXP4wadVUQrP6kIKkE2oflQBTFUcJdOEgKx2rGyHnUDsi4dG6YCqMUJZLwB1K/h0XMkZPFvunyQv6ntXTNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7856
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Joe,

	Please find my response inline.

> -----Original Message-----
> From: Joe Perches <joe@perches.com>
> Sent: Monday, April 18, 2022 6:04 PM
> To: Nava kishore Manne <navam@xilinx.com>; mdf@kernel.org;
> hao.wu@intel.com; yilun.xu@intel.com; trix@redhat.com; Michal Simek
> <michals@xilinx.com>; linux-fpga@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org; git
> <git@xilinx.com>
> Subject: Re: [PATCH v4 2/5] fpga: fix for coding style issues
>=20
> On Mon, 2022-04-18 at 09:54 +0000, Nava kishore Manne wrote:
> > Hi Joe,
> >
> > 	Please find my response inline.
> >
> > > -----Original Message-----
> > > From: Joe Perches <joe@perches.com>
> > > Sent: Saturday, April 16, 2022 10:29 PM
>=20
> > > On Sat, 2022-04-16 at 19:07 +0530, Nava kishore Manne wrote:
> > > > fixes the below checks reported by checkpatch.pl Lines should not
> > > > end with a '('
> > > > Alignment should match open parenthesis
> > >
> > > in fpga-mgr:
> > > 	Another possibillty would be to change the function arguments
> > >

This API is there for a long back. Not sure changing the function arguments=
 is fine or Not.
@yilun: Is it ok to change the function arguments?

> > > and
> > >
> > > in fpga-region:
> > > 	Ideally keep the include declaration and definition styles synced
> >

Will fix it in next version.

Regards,
Navakishore.
