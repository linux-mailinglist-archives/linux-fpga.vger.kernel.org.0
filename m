Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B29571CBD17
	for <lists+linux-fpga@lfdr.de>; Sat,  9 May 2020 05:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728355AbgEID5p (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 8 May 2020 23:57:45 -0400
Received: from mga03.intel.com ([134.134.136.65]:46391 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726415AbgEID5o (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 8 May 2020 23:57:44 -0400
IronPort-SDR: fjDwF5BDh5an/VHqolNunjHYAHcg81ecG94OknKzy+70zVMqE/el0jUqOsjj1IbZPco1OTeBtT
 VltF0snRdDqw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2020 20:57:44 -0700
IronPort-SDR: bLgap+pn6yxVSwQtzjk/hOiYIFIwM51nK0VrF9QcQYeZEF82k2Q9ialYzxjmKEFSxEaYgGfFCf
 jQo3uzubCdjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,370,1583222400"; 
   d="scan'208";a="370702336"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by fmsmga001.fm.intel.com with ESMTP; 08 May 2020 20:57:43 -0700
Received: from fmsmsx155.amr.corp.intel.com (10.18.116.71) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 8 May 2020 20:57:43 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 FMSMSX155.amr.corp.intel.com (10.18.116.71) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 8 May 2020 20:57:43 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.106)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Fri, 8 May 2020 20:57:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TjaiNCe5StQlszWpScsKDELUVc0Lc03rPxPtEeoCOmYF9aRH5SrFmWx/bXC5+ZdEUsZuyQ/irT6yHNaR0GiYEv5NDnnvora0IZuWW4Vx4fLyapR+lJGdqAw589OU8jmPuEV7grNPGoVvCIgPEbCmiiaxJvH9yBF4NTywnUieaW4zIW5YV1zbTY2t5vkpz2emje0HxjwWTQDL3H1IxyeQJJO1GlfHrnlPJMZGcZM5YAzniU2mJh0/HrwYHGVOzm8VpZYE6TwdNV3jUyxHUBe9ExbH3yC38/iX9y68yaNg/v599ybugbutoqxiXVAyp1G7b8+VutXFPIFRy5NeMebxVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SVKTCClnDVX6tYu5RGjuxmNG52kB7T8fo6cNx9P+Olk=;
 b=LvwLr49D+1zLDgtB6VCokTWmVcXmFIT+EXUiP0qc8pRMIwpdh5nW2BEDJpL7LK2l7sMXFJP2dJzxr/nndRL00SAYFMxW2+WdoT/1GfuNdApCvoB4HSwK3EMoBH0KIGkn8mpikNZ84p2bUswSHw/L+cRiQTAmod8GTYjGhC3DgXMNdtH7GKtxhFAPc/wUzijQbdGJ965plZP2Ilf+Q3qyL82p80UUwpKzYX6xY1AS87h7HbdIeYSaQNiRVoJrGuPGJnAHCDGCQbpzAkBbR5L734mwh6NNtaFBoclTrQVuEZIPZRB88ktd/guItd9I0ZdfpNbLnh0L9QX5rqugbpFauA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SVKTCClnDVX6tYu5RGjuxmNG52kB7T8fo6cNx9P+Olk=;
 b=uEx8xt8Iw/fdS+88hfEAMNQ0y4G/L0BGAScaoBKj69iGpRxWk9Ld5nP5orRMXByFH9CfcL0baw4TwqmL2c+cYkVSJU/K/sc3C/tbggPHARnpaTtexY1MPbqPoqilCuou4bns2HJzCD8De3VnYvjjX3HuYHsEUi0wmWu/OTdS+n4=
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM6PR11MB2956.namprd11.prod.outlook.com (2603:10b6:5:64::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Sat, 9 May
 2020 03:57:02 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::98a:bb06:5551:e5a3]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::98a:bb06:5551:e5a3%3]) with mapi id 15.20.2958.033; Sat, 9 May 2020
 03:57:01 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     "matthew.gerlach@linux.intel.com" <matthew.gerlach@linux.intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
CC:     "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mdf@kernel.org" <mdf@kernel.org>
Subject: RE: [PATCH] fpga: dfl: Replace zero-length array with flexible-array
Thread-Topic: [PATCH] fpga: dfl: Replace zero-length array with flexible-array
Thread-Index: AQHWJKA9988Q5CgyQUSojIGlxNZjDaiegY0AgACfuwA=
Date:   Sat, 9 May 2020 03:57:01 +0000
Message-ID: <DM6PR11MB3819D8BD585D5A568F62D2A485A30@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <20200507185256.GA14313@embeddedor>
 <alpine.DEB.2.21.2005081119420.7209@rhweight-WRK1>
In-Reply-To: <alpine.DEB.2.21.2005081119420.7209@rhweight-WRK1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.2.0.6
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.52.212]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 65ca9454-aae2-4459-9aac-08d7f3cd07ac
x-ms-traffictypediagnostic: DM6PR11MB2956:
x-microsoft-antispam-prvs: <DM6PR11MB2956890E0A208018CF8E792C85A30@DM6PR11MB2956.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-forefront-prvs: 03982FDC1D
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TSwpoSs3ND2M4l6m55pdzurgNVTZj5THY31ybNcM973DSGk5ej31oH+voj/KuDAGlgqY1cUTlOYE2MCyv7Oki+sfjOTDWyMq2rKcMCt6SVwLFz9dohLSmFbIWLYXlANAMLIi5igRyQpD7zfl8iJvdHw5Toxfi3CGQiNL+CRs7XoHWbyjUZraPyvp8RASpq/2T0rOMPc8LjCWj4vUTPFaFXmCObgJ9sw9aprLYua6dxnKQsyJyOt4JHxpl0RIsbwYXoduxhqVoYrsYOEe64Yon8guarJfcyK7B6S1N9z63hR0tiX26WTcHlU6pa8ob07f1lpa5R30Bay+K1dqqJf9g9vPnJ/9yyERzJ1DpZINxZ05X+1xlVPeyrqO8sZbhiVp3AfnQ/qGebmpEM7rM9DvJzi/lu9HkoT+/ofwqZrk36VE7CD/yD7a6X/MG3ixjRlr2G1jB/dLym0e0QiBDFrqnXEW4OZ5z3gEBcA8Xt47ChZXdZXz/dHELAnhJ4+5AmK/oY+nJu79eBoe6TD6Xo7OAhq8fgksJBY8nxf5TnNz1a46rejWWJ2dMRZRxb6J4pNJKukSHRIpLRJYSQ8kBuCWk3neD00JtuizseCvfl13R1c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(366004)(136003)(346002)(376002)(39860400002)(33430700001)(26005)(53546011)(54906003)(5660300002)(7696005)(52536014)(66476007)(64756008)(86362001)(966005)(66446008)(478600001)(9686003)(66556008)(186003)(316002)(33656002)(2906002)(6506007)(8676002)(33440700001)(55016002)(66946007)(71200400001)(8936002)(110136005)(4326008)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: X6Y47DLweD51tym8XhLT0Vetj3POpGgdpMFmePNMsC5jJcPOYGnQsmtgJzkdU5GZBtglt5QWpHcPYrPsekdsSOA3TpWFa+I1bTqXkdKT0QQQbJ/5ncZmvq8b5f0CKk1f+q8+/9wW8UHiH5kB2VV6EymIchHJXab+FDTRDqf7FC+CU5/PFq2LWOc2PPVVy58ltJVE7+8xNcT+meKVNDtuhZnDzeG55AII52ARvrraZk1M6UFOnA/1fQvgRj/5glsfinEPRY4rVj/DVsCdbmO/UAhFro23kjYhAa/N0LUizuqhKreMOMXFlRYZHJ5AiOeOqVe/GbieadsT4jzHfRz+PSMyMug7xNhBxfkvBG67GgOh5oDkKHEhei6Xth33oulWVmS1mUZm0VonbE5tq/nvnWoIH6PFAyN0tM1P6YZmbiFKZ9Ijgo6AYcifKCECLoEnlvjcXiDt+07JYWEUrEgDBto//Pmhr5zrfXS62ypsq8Y=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 65ca9454-aae2-4459-9aac-08d7f3cd07ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2020 03:57:01.7572
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NiwBzYQTbQJM1ApIEt+7Xp0UcA+OPerZ5RCyqgjKUF1HTC8e15u/DqL6V0+ORjJOGByBiFf2f22YLdza/bjVUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2956
X-OriginatorOrg: intel.com
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

I think Moritz had already applied it to his tree per last submission.
https://lkml.org/lkml/2020/3/21/373

Thanks
Hao

> -----Original Message-----
> From: matthew.gerlach@linux.intel.com <matthew.gerlach@linux.intel.com>
> Sent: Saturday, May 9, 2020 2:21 AM
> To: Gustavo A. R. Silva <gustavoars@kernel.org>
> Cc: Wu, Hao <hao.wu@intel.com>; linux-fpga@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH] fpga: dfl: Replace zero-length array with flexible-a=
rray
>=20
>=20
>=20
> This looks like a a good change to me.
>=20
> Tested-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>=20
> On Thu, 7 May 2020, Gustavo A. R. Silva wrote:
>=20
> > The current codebase makes use of the zero-length array language
> > extension to the C90 standard, but the preferred mechanism to declare
> > variable-length types such as these ones is a flexible array member[1][=
2],
> > introduced in C99:
> >
> > struct foo {
> >        int stuff;
> >        struct boo array[];
> > };
> >
> > By making use of the mechanism above, we will get a compiler warning
> > in case the flexible array does not occur last in the structure, which
> > will help us prevent some kind of undefined behavior bugs from being
> > inadvertently introduced[3] to the codebase from now on.
> >
> > Also, notice that, dynamic memory allocations won't be affected by
> > this change:
> >
> > "Flexible array members have incomplete type, and so the sizeof operato=
r
> > may not be applied. As a quirk of the original implementation of
> > zero-length arrays, sizeof evaluates to zero."[1]
> >
> > sizeof(flexible-array-member) triggers a warning because flexible array
> > members have incomplete type[1]. There are some instances of code in
> > which the sizeof operator is being incorrectly/erroneously applied to
> > zero-length arrays and the result is zero. Such instances may be hiding
> > some bugs. So, this work (flexible-array member conversions) will also
> > help to get completely rid of those sorts of issues.
> >
> > This issue was found with the help of Coccinelle.
> >
> > [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> > [2] https://github.com/KSPP/linux/issues/21
> > [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
> >
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > ---
> > drivers/fpga/dfl.h |    2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
> > index 9f0e656de720..1cd51ea52ce1 100644
> > --- a/drivers/fpga/dfl.h
> > +++ b/drivers/fpga/dfl.h
> > @@ -235,7 +235,7 @@ struct dfl_feature_platform_data {
> > 	unsigned long dev_status;
> > 	void *private;
> > 	int num;
> > -	struct dfl_feature features[0];
> > +	struct dfl_feature features[];
> > };
> >
> > static inline
> >
> >
