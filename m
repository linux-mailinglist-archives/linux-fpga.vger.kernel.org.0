Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 491E050EEA0
	for <lists+linux-fpga@lfdr.de>; Tue, 26 Apr 2022 04:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233699AbiDZCSt (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 25 Apr 2022 22:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiDZCSr (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 25 Apr 2022 22:18:47 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6832336B79;
        Mon, 25 Apr 2022 19:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650939341; x=1682475341;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HVnqEfAprWnkYgKlU/xFa3sLUa+BZprVebL13mi0kO8=;
  b=g8exgWxsxO5oZfjm0gzBdHPI7bcOuucFuDVtg4cQ/dhpcTqKgaO+5EqX
   3cK2dsEpR9ASdIP3lVWpLBS0MSLg0WZXSKO8XpCufyEAbgATO6EaNju7w
   VxGrWvinO5QV0VyXHZ3aMEJlPKte3dV+TOkvpecMAKeGI3tttCNQRmr+Y
   no4IOBrORERcw47Byj8+OSfe3r1LyLDVUa1OuRC75DxJ1tDvuGszY2vfN
   uGUFTxO83lJBBAzk/5ADqwT0lTpiXFS+zwy/oTmbo3FuFye8Y0zgWxuhq
   w8lnDQaTb7FI+0CXPqKNf4tYxGu9GtTZk+TnPFSpc9ZtJCVD8UMRLaLjf
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="328364080"
X-IronPort-AV: E=Sophos;i="5.90,289,1643702400"; 
   d="scan'208";a="328364080"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 19:15:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,289,1643702400"; 
   d="scan'208";a="512917037"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga003.jf.intel.com with ESMTP; 25 Apr 2022 19:15:31 -0700
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 25 Apr 2022 19:15:30 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 25 Apr 2022 19:15:30 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 25 Apr 2022 19:15:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MxRAg7boLq3zxT7tPkr9fCokekDQr0gi2KfAfhdpEv9oiooRKOH1BMp6LbOJ4SY+/bKZV5bbClxYswfd/Edaw9n7oakZsJMCkGUMW6tT82P+PszSEHcm3G1kf+h0+oLoiKZxXLA2HADaSbr0KItD6wnIvlq+Mk2T6rSKeSC29RXgCwJ0MEM8URw8dA4sCV2+HlRU6MzF2uSD7r8oHSMf4YclJxNmPs0USEJMoT2nOlIVZoZa1YefiNt+MolDwKOj73R5SIjStA2DzKeCxs6QmVupg2kPHUpC8PjtcGmxgKxOJXkYCUM97BDFOQqf3LfanfAubXB5uyO8iC9wBeT+ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t6I7tNO82OW3EQQtizlm7KD7D8r4xiRWMG2PfFNU+AQ=;
 b=LbIR7XwV8DjXjfklyVuSLkDGLICxQLjmTskzNQug0TdX9zsB94h6YBHJOWUJXILnYBsq40m6186hjNTH9p4EN+LxtzBdhLuFbVygS9GZDcMewcYdFtWmb/LypkQSfdgHvXCWi1NARqMFd8ZwSWupx1jp94Vs+2zhVbUMoB2NLwjGVdkNOUOEnwgXcHrmuVw9dZRgzUTeiv3q27Ydenb8x3FpUD/zWYuK2NzwcdI7BvztIoI3lmttNyKBdlFJYe7uuUm5ibd2JsocWrvc4CPUPTVuwBNs6ivl2cAq14YpwgBSo/Bmp3lx9dOxlc1tLVqx8ILxA78s9tSJUfOubRJ9IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by MN2PR11MB4648.namprd11.prod.outlook.com (2603:10b6:208:26f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Tue, 26 Apr
 2022 02:15:28 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::4838:60ae:b637:3fc0]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::4838:60ae:b637:3fc0%7]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 02:15:28 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     "Xu, Yilun" <yilun.xu@intel.com>, Moritz Fischer <mdf@kernel.org>
CC:     "Zhang, Tianfei" <tianfei.zhang@intel.com>,
        "trix@redhat.com" <trix@redhat.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: RE: [PATCH v7 2/2] Documentation: fpga: dfl: add link address of
  feature id table
Thread-Topic: [PATCH v7 2/2] Documentation: fpga: dfl: add link address of
  feature id table
Thread-Index: AQHYWHZo5VGoL8N2UUSPblDvkyVUjq0BdfTA
Date:   Tue, 26 Apr 2022 02:15:28 +0000
Message-ID: <DM6PR11MB381918B2AE8AFB90D857F3FA85FB9@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <20220419032942.427429-1-tianfei.zhang@intel.com>
 <20220419032942.427429-3-tianfei.zhang@intel.com> <YmFudmiIRh5RHGQ+@archbook>
 <20220425072307.GB363795@yilunxu-OptiPlex-7050>
In-Reply-To: <20220425072307.GB363795@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.401.20
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4c164a88-303d-44dc-b92d-08da272aa1c8
x-ms-traffictypediagnostic: MN2PR11MB4648:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <MN2PR11MB464810EEDCF9EBBA72B57C0985FB9@MN2PR11MB4648.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tIuJPO7IHWUNVbgW6EPOSUO86LGbFaWYikP4UU9mqw5UB9WODMzNNzAcwaDJ871g4y5JtScRLHmLpLgOEZCa4d+lDzy156/b75x/GQ9ny+TLKUFf/qFI4FdDxDhZHsuCLguTqqS49muGJBNLTdQEpSTyo4FJ+l4vRLXsFHwp/8EYlwBaXwF9gqhVjojubnvZnHooQtRH2LF8by1yYaEFTjJ6q3voAYT6nsUxgUK9pS8feL1Ml/t9A0ok5A83uf9GpHdVRqtNqXZXF26JjITiUXPtDTzvaOssV7sHOckcDRRKOkRnl16ZB/goMCutwmq0EQhK3308FI5b61sA2cRJDQKmVlrn2QuO3QjmoOXjLcUOISVLuDJeX3Za/FJFnDhFWZNRKtr5V+TM92msXmRo92BPzQAVuQygF9gdPq5CfwqCv+bgAGzPaBXddGnznH9rv1jxBe+TK3xrEXLAG9yoomGer7ruBPSM2p37YyWexpAI3jznU01rsw56tTITe57KiXCsgDf7sev8vK28hpMI9HObi9Z5bY1NKpiSCqA3F+Pt92EP7C7ibyU+FoDno1MQhqWwNu09SI6tnHpgRIsWE2/dXSEIzCNs0rF2fqoA+P40EDSNALEjtw72Qw0OMyBZUmVwh11hSJEI6g8UzUKcpYD99Bty1wwzKIofFjaPZJA2kDYLB5/B+Y2zqtxjvMWKduobXDNBexMI4kCg6MJ62Iezc2OksCH6p8b0cBVQYghukTzcn1/dXaO9P2TXidYGTA2po4xbW9nb7G1slmTMW9+Q6lAhctc1xnSNW/KLTrI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(54906003)(64756008)(66946007)(9686003)(66556008)(8676002)(76116006)(82960400001)(66446008)(66476007)(4326008)(316002)(71200400001)(122000001)(508600001)(53546011)(6506007)(110136005)(86362001)(186003)(38070700005)(38100700002)(83380400001)(7696005)(26005)(33656002)(55016003)(2906002)(52536014)(8936002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?N53EblJCCJkkvahyYTgZrYHtIivNXdTcFNPdJDUpUbEOJQ3jWY0QuPbQe2P6?=
 =?us-ascii?Q?TSM7KOLVa7HdJE3ONpjOAWnPy4mA6jpH8a28iRH/n+n/l6eyZdtXPV2qpum/?=
 =?us-ascii?Q?EBUK5cV5UlyFfFvnuBiAId6C7JL2Z0W6Uu9vVubhXH4nqyG1SAgnH7wpeA/R?=
 =?us-ascii?Q?GfEGM0IX6yI9Fphwmp22sm7TFyYKlLqoVxaBF1MeqwcMYoD+Yyc+VX52dDIB?=
 =?us-ascii?Q?BylxjgaxXI+Ym3yNzA0SDPDkZWPuLZrIM2KvqHU0RkoghBYZOW8X6KhO6IKc?=
 =?us-ascii?Q?gjWXfC+hsWAqSLaKtGeuitsqwlWB8tQE96Yg/szqD14AfgQZ5VcacXzNGMyt?=
 =?us-ascii?Q?2Okbalrkf027KiMZ+vdoAAaG3XbHDxBf7AQUouYNRUyFTX7D5xMnTgRgQIw0?=
 =?us-ascii?Q?tkXQlt1dpkoIe93DjfTmD7Hi494Q/UTKAvaiFm2JtOOemt0qtL8dp9rDkTuV?=
 =?us-ascii?Q?37MeqZFh0fTVyQ0p+zfV0ieDK0lPnWq8AWgpq9Znmjm9sS2UKG8dEWkBMPuN?=
 =?us-ascii?Q?EodTx+cPZG4MWezVBH1c3krjL8ubO0pGRUgb4XDCp0xmn/Z5C5AqTaroyXMY?=
 =?us-ascii?Q?ynHnoDf2d7kukiW3lIkxgpgHh5Esa3GHBW7RDzvoZQ0MRNW09EPGgh3OU2MU?=
 =?us-ascii?Q?zJoqCUZexwBI4luDp2RVhjW1dXQf3zdmvKsohFJdf8IXlMaAc7dCM/VrnN7t?=
 =?us-ascii?Q?3eaLX0Z9kAJPFKwVr2s8qVJHBM17e5rPpbVXu/LHWAaXx3pTN18YvTMMPHER?=
 =?us-ascii?Q?M7BAnYPZNKBQec8u5fT5j5cXvZtZTWYTy86k9JpFnTl3g1Drv9k0PqWnbQR6?=
 =?us-ascii?Q?AjCCXC96jqlmpCEeTk5/zVRX+7wGMDn0rS5svcw5DbtsMRjCSOarAK2lEOzF?=
 =?us-ascii?Q?H8blWTGYSXQZd+5JS9nTidNwXtzwBzi5rVmkdCVA8o8mnPgoPEt6fKtB6BUT?=
 =?us-ascii?Q?SWTPH6AT9uL8qIXnL6BLubluurXvW+XE4jiH9moXrubMVkH0A7UTDqYCt9fJ?=
 =?us-ascii?Q?1vAWWmbxD4scojJVdcSwKdShliO4thHdmZyz6kURpS9zCNjXb/NwpoK6cNYg?=
 =?us-ascii?Q?RVZjFVZsnPAA80ijn5ddVb6HHTGYZBouW7ElOe1aQirDH7W7bYuRnFgnWVlp?=
 =?us-ascii?Q?2oYFmNikbq/h6gd6JGDr/39kkD50Nb02H3lFAqK6XGI7jHxF24ZuD/HfMNpd?=
 =?us-ascii?Q?53QkMQf2nAcg767sS0c4FDbRQ/bHFYGWM8qDVTruWCr93HtXfjgZSDPbcO1N?=
 =?us-ascii?Q?Z0vgp7PN3RiQQgB3iyIZInnd7jA2lsWdkxSGgjERtEI0POexgs4S2vsIotBe?=
 =?us-ascii?Q?o5DTMcWXVFyNxuD1F1XAzjGA3456jAeCk7C3CRqKY9vniZ8tV4OgJYu0U79o?=
 =?us-ascii?Q?QbDqxlqVQ5WpGHewSJLzByLFto1h126sa139GOwZV1ye8YHCW4Pv38HtIUOY?=
 =?us-ascii?Q?w9nNGFyyUqSISvRQEasfBhEWFLpLSpshEjnz2fG2DqDIjmefMdn3F4yotVSX?=
 =?us-ascii?Q?ZdDaDadIEfyZm7hJNCEb1Zn10I54Vt22/+7CbCBgzp2EusxD6V9AWKsCy68z?=
 =?us-ascii?Q?a5UlWtDMQF8Cv9wA/gW3kImu232/U2AEjklgSUnago4FMPwBZUnctBoJZ9pf?=
 =?us-ascii?Q?p77CSFqMh46GuGwj7kbRHa8OyjvwUjwUfJN3dQLZsFTkG/LKRNsw7dW7xGbr?=
 =?us-ascii?Q?+4DPN1l1fG9A6tCwo6k+Qr34igi0gZR5ZEUfnK7dclpOTDN5jtdcBTqp4eTX?=
 =?us-ascii?Q?SyTGIkOamg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c164a88-303d-44dc-b92d-08da272aa1c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 02:15:28.2273
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tiM8nxPSsSgAdQz3EDUHwRhAnBJrbSchv/OzikmUP6sKmUbtDX7IhN9IDcL/WAFQo5zNdDn8thgtR2Xe3mZ0Gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4648
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> -----Original Message-----
> From: Xu, Yilun <yilun.xu@intel.com>
> Sent: Monday, April 25, 2022 3:23 PM
> To: Moritz Fischer <mdf@kernel.org>
> Cc: Zhang, Tianfei <tianfei.zhang@intel.com>; Wu, Hao <hao.wu@intel.com>;
> trix@redhat.com; linux-fpga@vger.kernel.org; linux-doc@vger.kernel.org;
> corbet@lwn.net; Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Subject: Re: [PATCH v7 2/2] Documentation: fpga: dfl: add link address of
> feature id table
>=20
> On Thu, Apr 21, 2022 at 07:47:18AM -0700, Moritz Fischer wrote:
> > On Mon, Apr 18, 2022 at 11:29:42PM -0400, Tianfei Zhang wrote:
> > > From: Tianfei zhang <tianfei.zhang@intel.com>
> > >
> > > This patch adds the link address of feature id table in documentation=
.
> > >
> > > Reviewed-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > > Signed-off-by: Tianfei zhang <tianfei.zhang@intel.com>
> > Acked-by: Moritz Fischer <mdf@kernel.org>
>=20
> Acked-by: Xu Yilun <yilun.xu@intel.com>
>=20

Acked-by: Wu Hao <hao.wu@intel.com>

> > > ---
> > > v7:
> > >   - change the title and git commit message.
> > >   - add Reviewed by from Matthew Gerlach.
> > > v6: fix documentation from Hao's comment.
> > > v5: fix documentation from Matthew's comment.
> > > ---
> > >  Documentation/fpga/dfl.rst | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >
> > > diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
> > > index ef9eec71f6f3..15b670926084 100644
> > > --- a/Documentation/fpga/dfl.rst
> > > +++ b/Documentation/fpga/dfl.rst
> > > @@ -502,6 +502,11 @@ Developer only needs to provide a sub feature
> driver with matched feature id.
> > >  FME Partial Reconfiguration Sub Feature driver (see drivers/fpga/dfl=
-fme-
> pr.c)
> > >  could be a reference.
> > >
> > > +Please refer to below link to existing feature id table and guide fo=
r new
> feature
> > > +ids application.
> > > +https://github.com/OPAE/dfl-feature-id
> > > +
> > > +
> > >  Location of DFLs on a PCI Device
> > >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >  The original method for finding a DFL on a PCI device assumed the st=
art of
> the
> > > --
> > > 2.26.2
> > >
