Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDBAF23C749
	for <lists+linux-fpga@lfdr.de>; Wed,  5 Aug 2020 09:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbgHEH63 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 5 Aug 2020 03:58:29 -0400
Received: from mga18.intel.com ([134.134.136.126]:51291 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbgHEH61 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 5 Aug 2020 03:58:27 -0400
IronPort-SDR: rCy/9Vty1DTyBzJejWZm3psnEeV5iUGlGRMta7rK7BKH1DOMHiRXwajb3DxFDwewsxjtoktu/N
 Of6rIqXdjUhA==
X-IronPort-AV: E=McAfee;i="6000,8403,9703"; a="140076991"
X-IronPort-AV: E=Sophos;i="5.75,436,1589266800"; 
   d="scan'208";a="140076991"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2020 00:58:25 -0700
IronPort-SDR: 71GrBF4BsY/EnmStCgNSDfqPuwkj3wdxBGg5jihMyWTiyvzYuzf+2lAa0euVuqlMqpMzWUKK9X
 D7exJsvGy3Zg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,436,1589266800"; 
   d="scan'208";a="274705860"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by fmsmga007.fm.intel.com with ESMTP; 05 Aug 2020 00:58:24 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 5 Aug 2020 00:58:24 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 5 Aug 2020 00:58:24 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 5 Aug 2020 00:58:24 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.51) by
 edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Wed, 5 Aug 2020 00:58:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L//5DcyEYtpsWdDmsw6Sez9ak8k0DEOL7gBpuTD/k1lcbkSKnNRH5UZHp86FcGq5rsusujizjtMm/CXg0qoEHcgBvbyje2lS5GAoyiSPbARqLnVmsDBkork/YixzecOyaDnP3npJJ3dj2WL+XBPAv4ssFR9LVKLz4ddro/m/W9c/D2OCvgOT9PIJop0MaZpFGcK1ctCSR1tWSffelYFquWPfpprYcIQ7MvFNSTjmey6lTAyEawRj3JDE1tulGC+WkFEb5D3ZubOwI1klOk3R/itVHN2aXOtTvN3Fzm/X17ZrmsAZIE9ot0V26nWz/1N8R/qqSu6AGU4fj9cxTetOwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A0cxir2E5ZpVmC9frX7pBstaCRmqrXgH1abG7rsNZ9s=;
 b=kLYYyr0skvEnVdsdtMzKQ1/RO0OtGuFy372pmMPK71NUDI6LY6P9HAhOzgbR7EbXIwWxHI5xfGtCw0+wLjcnuSQoM8k2Pk2L47BoVA01zbQ8+Kq2M2pqFapQsLVRKvBB3XkkXqc2LkYXHUMMDeyMU6hpN93ErRW4nfbC0S26F9s/vq5/ojJf9Ak2DDNvgwo2p4QD2TBxyp3zBVBcW8Zwu9FTb7tx3l7/fy6sMPmkOoYmJXSJiFx7mLoBK11rJxj/W3iOUTIHLgxQh02xJqxwRT7xo4d81Ceo9KuT6q/akivS2aox6PcrnVOB/AEqA+M5Pvh3bnb45I3L+I5g1DKYNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A0cxir2E5ZpVmC9frX7pBstaCRmqrXgH1abG7rsNZ9s=;
 b=cAmmPQVzTPlEgwLZP1LFv4R5wsLMjB96BFjRrYC6PAbX0qsptm/NMMviRQCKzLojWE0TvXce9bjgSIJF07HeZvCIgbkZEqbhkdhOmEn30jSIkQUz9GS2Q1XyIcN0Y5yp9+483G/KlxWNATOojNXjolX0lOGAJc6pOyJ7GxfxJiA=
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM5PR11MB1948.namprd11.prod.outlook.com (2603:10b6:3:112::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.21; Wed, 5 Aug
 2020 07:58:21 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::c1c1:6930:f17d:a80a]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::c1c1:6930:f17d:a80a%4]) with mapi id 15.20.3239.022; Wed, 5 Aug 2020
 07:58:21 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     Moritz Fischer <mdf@kernel.org>,
        "trix@redhat.com" <trix@redhat.com>
CC:     "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] MAINTAINERS: Add Tom Rix as fpga reviewer
Thread-Topic: [PATCH] MAINTAINERS: Add Tom Rix as fpga reviewer
Thread-Index: AQHWans7T4WlLLIB2kGoBg4966P7lqkoJ0KAgAD96rA=
Date:   Wed, 5 Aug 2020 07:58:21 +0000
Message-ID: <DM6PR11MB3819024D3EE4913E0AA97680854B0@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <20200804162003.19402-1-trix@redhat.com>
 <20200804164133.GA1499313@epycbox.lan>
In-Reply-To: <20200804164133.GA1499313@epycbox.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.2.0.6
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.46.36]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 07510d88-07a7-4997-3efc-08d83915526e
x-ms-traffictypediagnostic: DM5PR11MB1948:
x-microsoft-antispam-prvs: <DM5PR11MB1948C91580C44BC15E10F2C8854B0@DM5PR11MB1948.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cl8j5tiFWhRU+9JnGVQqOx8kr68QRyPNJ/qIIpk2WQxV8IQSfMzWfYJkJkUZXfKgXYu7UuGz5Ay3JNiAbrzOQ+Jmn2hfF8j7XWBdBhe8tvbEuCj/mkHKCm7wEe2IucIwoW1BOAgHzmI1ooX4ekeGyyhnemuU4Lnslk7tRuzFaNTDoWjHTcT/xOEHP1wVXb9kDmTaNZTe9Wsx1ljgR8DsO6/F03AYFXGAv4vbMqJK8rl58OnGAQngLrbbbsKuTZWXdtP6nSx/qwd4hC/sOyr4Gl604Sd2t/YpUXvGK/5L3iieEwV+JxYiv5Yd0+szeVdG8n8s50wwitxVhLHkDz23NhRLXJBayPcCne51RhKz5epHTULlKCbuaLtduwIMwq5nYhPAFin1mEVR8A3MMDwmOQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(346002)(376002)(366004)(396003)(39860400002)(86362001)(316002)(54906003)(8676002)(110136005)(8936002)(55016002)(71200400001)(478600001)(9686003)(6506007)(33656002)(52536014)(76116006)(66946007)(66476007)(66556008)(64756008)(66446008)(5660300002)(186003)(26005)(4326008)(2906002)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: oIIcGaZYGQ46HjgOy72oTBHEg/Q/R0R/E/5toQz/uHpRYuWZh3deIlwX0JTQcYnIRr5c+KWVb577J/IKVT54TpqOwKd2v2zuk/DDwYY1hL1rxUXWm8Z2a1jg4s4NZq9cpstZFYErZBjiRzsmJaynhv/nTC9mhM2dj+XNdgHVZjezPhQl9d5AG6jB9vw4F6mXD0Qe2Yyxff01cq5YcIO8t4KWYOHFwCQSQRPkJWWfYeaUl9Fcu+e3roCaiuQ1pTS9f9C4IslBQ3wfXC6Zg1GS9UYGr3Mlpia/CkEGiZH11RwYAhU30uhP9HKxiez/odKgxwxNyhcilV8dQoEgxQQlFoeubJasdfOEvWFZxaLIlCehL5USX2OAoRKHZ28Q7NmlY5f1CnY3h1cQ2myDjZJBCgtMq/tBFvP3IGrLZPa/QgEbKmUHR/Ju/fhRZo02ssSmW62D+bQU7ZAm/48BKnTY8jZqfQRMRXRovUvMIkvcgw8G72RxeeoGr0IxCgUrR20gFC/TkXYot9Y4gn9RPRghOPI71OArYrl4/ZpdL6qJtpTLOTrUSI7njBoYmVUPGq5lCo2X3kFF2YA7Rix3itLtg4CDWYuUuP7FaAscoIETPSnQc57i3eJnSTBHhZ9i6N6tCXYxkn+mCqi3zYc1Kvq2Jg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07510d88-07a7-4997-3efc-08d83915526e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2020 07:58:21.1879
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: imZOzlRlmKFaDe/iYC52YaMznDk99F4aXQP6SElXFqQPLsds63ZZJduTgIQrKj/BWn0CQEE0qbMuA5ZfuUCqSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1948
X-OriginatorOrg: intel.com
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> Subject: Re: [PATCH] MAINTAINERS: Add Tom Rix as fpga reviewer
>=20
> Hi Tom,
>=20
> On Tue, Aug 04, 2020 at 09:20:03AM -0700, trix@redhat.com wrote:
> > From: Tom Rix <trix@redhat.com>
> >
> > I take care of fpga kernel and userspace for Red Hat and would
> > like help out more with the mainline kernel.
> >
> > Signed-off-by: Tom Rix <trix@redhat.com>
> > ---
> >  MAINTAINERS | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index ce2737b1feb5..6fdb01776413 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -6805,6 +6805,7 @@ F:	drivers/net/ethernet/nvidia/*
> >
> >  FPGA DFL DRIVERS
> >  M:	Wu Hao <hao.wu@intel.com>
> > +R:	Tom Rix <trix@redhat.com>
> >  L:	linux-fpga@vger.kernel.org
> >  S:	Maintained
> >  F:	Documentation/fpga/dfl.rst
> > @@ -6813,6 +6814,7 @@ F:	include/uapi/linux/fpga-dfl.h
> >
> >  FPGA MANAGER FRAMEWORK
> >  M:	Moritz Fischer <mdf@kernel.org>
> > +R:	Tom Rix <trix@redhat.com>
> >  L:	linux-fpga@vger.kernel.org
> >  S:	Maintained
> >  W:	http://www.rocketboards.org
> > --
> > 2.18.1
> >
> Acked-by: Moritz Fischer <mdf@kernel.org>
>=20
> I can take the patch, can I get an Acked-by from Hao?

Sure. : )=20

Acked-by: Wu Hao <hao.wu@intel.com>

Thanks!
Hao

>=20
> Thanks!
>=20
> Moritz
