Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D34A23C8C6
	for <lists+linux-fpga@lfdr.de>; Wed,  5 Aug 2020 11:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbgHEJMJ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 5 Aug 2020 05:12:09 -0400
Received: from mga11.intel.com ([192.55.52.93]:47454 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728418AbgHEJLd (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 5 Aug 2020 05:11:33 -0400
IronPort-SDR: C/8H2elE9xVOuuZjwcPGIOBJPi8AfQcZTb/XQRZL7jwH236bYMJN/VEFXxtvIliSRoAeNI3AIx
 gMurMHPcTmHg==
X-IronPort-AV: E=McAfee;i="6000,8403,9703"; a="150263962"
X-IronPort-AV: E=Sophos;i="5.75,436,1589266800"; 
   d="scan'208";a="150263962"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2020 02:11:31 -0700
IronPort-SDR: oQ+Jy5KECblDPDSLT7N0lvR6snNWpzwKeOGW12KVN7MvFTxg6+DZk66ZA/A5TmvW9CIchA1vfT
 64s30QhgcRbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,436,1589266800"; 
   d="scan'208";a="274722918"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by fmsmga007.fm.intel.com with ESMTP; 05 Aug 2020 02:11:28 -0700
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 5 Aug 2020 02:11:28 -0700
Received: from orsmsx106.amr.corp.intel.com (10.22.225.133) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 5 Aug 2020 02:11:28 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 ORSMSX106.amr.corp.intel.com (10.22.225.133) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 5 Aug 2020 02:11:27 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 5 Aug 2020 02:11:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gFdUQmRN0KJsNhgr16/UMPbRXcJujcAWoVvp8B2nt+aE7MPz6QztM/w6IP+hIVvJv49mH446rF/o8/c5iwXRrMxhWtmTr3kCdQBQKN7q40Em7PW0L4GXHphvPLqLUt+rmU5CA95MCbieuwJZ4ZmsJ/zPQMJtMgel4byC5qVD6zFS+ns3UWKGnuYyyzf9Dy71sPopcFs2qDc4pPc8kO7nhEuBOuer5/DMeNO9q8ZfZ3KOPawlcTGF6dRTU8zmz5eEoTMAeVheVQka8sRVSkbSUZPHiRI6xYQfJ9kFVavGVv+gH1vAolyqtkTrhu+nxSSnJVdCBU8vXS96tj7bNM7Zyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3A+XFsj7m7SxUuma8XLqqU5T+bnCzeb2AZOmqv5sd5o=;
 b=as9pI+SKiAUHNe52Y5XL8L6lFw4NmyOJxtpMDwWBUetu53UKHDfOOqTnkX790El+Bpi4tRYvO1QOxWIOk8A+fNBOMq3pKkg4Ni+o18clWJT2S0xgX2wcZN7TDldLGsgSM+ulnUVHOF9PpXc8rFnJauw31+vd3MKZX0XjmjCZL2SyWmA8Uax6RKm28h3TPlg1Nv0raDhTBq6bulFRCHnraxJQMf3ylhmn7qUOYcgobeLJbl8UqOmBlMCW0KfYAgqBkWMUz8DdZh5lpTG1ikQnxBhX76mbnkG7y/m+3etd5hJSv/ujeubcUm/ULRB8g4thgnBvEDBG5OqOKiFGZXGhCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3A+XFsj7m7SxUuma8XLqqU5T+bnCzeb2AZOmqv5sd5o=;
 b=gZHJWXdMBjcJz93rPbPW97koJDGexKZ8oj5ulALGPQIqPWGm66RtIeSwbu3AMBRy4QU0nRalyc9gIbjiLTWXeGpiGdCbgnD9K0/24ZITUXGkBDUJCfZNKfjJ/y6Oz+odu/ryK7Y/npdMkLtVfgDeMx6Si8lSzPlvUjusoSiJzH4=
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM5PR11MB1772.namprd11.prod.outlook.com (2603:10b6:3:112::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.16; Wed, 5 Aug
 2020 09:11:24 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::c1c1:6930:f17d:a80a]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::c1c1:6930:f17d:a80a%4]) with mapi id 15.20.3239.022; Wed, 5 Aug 2020
 09:11:24 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     "Xu, Yilun" <yilun.xu@intel.com>
CC:     "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "trix@redhat.com" <trix@redhat.com>,
        "lgoncalv@redhat.com" <lgoncalv@redhat.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        "Weight, Russell H" <russell.h.weight@intel.com>
Subject: RE: [PATCH v3 4/4] fpga: dfl: add support for N3000 nios private
  feature
Thread-Topic: [PATCH v3 4/4] fpga: dfl: add support for N3000 nios private
  feature
Thread-Index: AQHWawPVvHEDk8mM0EOFYIp8Se/ahqkpM1/w
Date:   Wed, 5 Aug 2020 09:11:24 +0000
Message-ID: <DM6PR11MB38198586126644A058A681D5854B0@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <1596524715-18038-1-git-send-email-yilun.xu@intel.com>
 <1596524715-18038-5-git-send-email-yilun.xu@intel.com>
 <DM6PR11MB38196B703EA0772783466AA9854A0@DM6PR11MB3819.namprd11.prod.outlook.com>
 <20200805083504.GA20262@yilunxu-OptiPlex-7050>
In-Reply-To: <20200805083504.GA20262@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.2.0.6
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.46.36]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1b1f01d4-d13c-4dca-780b-08d8391f86f1
x-ms-traffictypediagnostic: DM5PR11MB1772:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB17723E60BC2906629E76B022854B0@DM5PR11MB1772.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kyEIuetRyzUGAN0nIzIodyjP1nmb4dUTCBoOk+ZYP/F7I8tPr6Od94T/jNiGRKTESVPltMoc8zD16rQcZmUruiJbSczEPi0e9LpDgvmuA4acyXQoXI3IKayvVBGaFa80eVWW7P7hb3eogUR/mpoU+yR1+9jT0DKPL1jAJCJvjEJeikS6Uzk/ftMbWUmTFBYjrf6snpqQWZcB3aGEzMG6FHMXqPqz1kVSAxuiLhahboHzvohYwD5otB1w8X2SqS4DHvm4zezctYFocG/eB/mPNaTn8LUqFbRSJbIhDLUTjKDPbuiiUb4k11OOwtSG63t0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(346002)(376002)(39860400002)(366004)(136003)(33656002)(71200400001)(8936002)(478600001)(6862004)(4326008)(186003)(83380400001)(26005)(7696005)(2906002)(6506007)(86362001)(76116006)(55016002)(66946007)(316002)(6636002)(9686003)(66446008)(64756008)(66556008)(66476007)(52536014)(5660300002)(54906003)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 7aOT54rO4yhkF3w9T479tUUFfu0G/9pglSaIGulXzBzORgnK+FfLLyV1Dh/0kRMMlMHmHucmBfzPq27xVBpPgzIDISfVRpipbq3e8uHwyNZZ82wZxmdKdmfqZmH0dYVE3vR1gLtFxGMWSqz9Kll1GvGzdiKB+lRDci0arBGw3toNMPre87SJp8bqAgZbnlIUVqxVc7ErieNHQVEIQjAe3WwDnfOIXTxJXa1ErtzhbhGHyEBj02kriS6NDeaBWHITbjHngu85qRKzBgoUYAWkFLMXfMb3bs9A8zhuajMYUbYA19FwdByLRk1ErK+9lwpDaznObydV4xDiTGqlbg51bMyQh1Ggitz0lLiGN9Kuu014pQEVqF6C1Wh7Xw0UkTFHFKlq8uVr1hcSV9uK3D8dbvpEx3bsVWAUCf2BkjmCR1pby1HXVHBnn7DI7EZZAzDmhNLOxW5hzuWqOOl/bM/opHUKmyw6Q3oMn4VijYMSLzB9oESAcs1vsavmT5O7hqmnXGD7zPrfjaOCoTZpZjZlXqWCpc8SOTGar40nYPNXFVyL4HtoIiWZ52r5QnYhYPi/jD6XkmDDsownjgxi99naHIeuHnEjN6EnkKkh3pMnixHIExtWwpVBV55XsvSPxFUwz08neUYV4WxI1ZxHSriK/A==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b1f01d4-d13c-4dca-780b-08d8391f86f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2020 09:11:24.2107
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YQ5cj/MhH4fTTEPUBuytL3pmsfhdVyKT2u17oqyHhYvYxC5iJ8oVgRNJGflAQUaGZxEEcGQM/b6TdfMQr4GdDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1772
X-OriginatorOrg: intel.com
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> Subject: Re: [PATCH v3 4/4] fpga: dfl: add support for N3000 nios private
> feature
>=20
> Thanks for your quick response, I'm OK with most changes. Some comments
> inline.
>=20
> On Tue, Aug 04, 2020 at 08:56:12PM +0800, Wu, Hao wrote:
> > > Subject: [PATCH v3 4/4] fpga: dfl: add support for N3000 nios private
> feature
> >
> > > +#define NIOS_INIT0x1000
> > > +#define NIOS_INIT_DONEBIT(0)
> > > +#define NIOS_INIT_STARTBIT(1)
> > > +/* Mode for PKVL A, link 0, the same below */
> > > +#define REQ_FEC_MODE_A0_MSKGENMASK(9, 8)
> > > +#define REQ_FEC_MODE_A1_MSKGENMASK(11, 10)
> > > +#define REQ_FEC_MODE_A2_MSKGENMASK(13, 12)
> > > +#define REQ_FEC_MODE_A3_MSKGENMASK(15, 14)
> > > +#define REQ_FEC_MODE_B0_MSKGENMASK(17, 16)
> > > +#define REQ_FEC_MODE_B1_MSKGENMASK(19, 18)
> > > +#define REQ_FEC_MODE_B2_MSKGENMASK(21, 20)
> > > +#define REQ_FEC_MODE_B3_MSKGENMASK(23, 22)
> > > +#define REQ_FEC_MODE_NO0x0
> > > +#define REQ_FEC_MODE_KR0x1
> > > +#define REQ_FEC_MODE_RS0x2
> >
> > What does REQ mean?
>=20
> It's the abbreviation of REQUEST, on spec these fields names
> REQUEST_FEC_MODE_X_X

Ok, got it.

>=20
> > > +/* ns is the abbreviation of nios_spi */
> > > +static int ns_bus_poll_stat_timeout(void __iomem *base, u64 *v)
> >
> > Why adding "bus" here? I just see it's polling on register bits, right?
> > It's a little confusing on ns_bus.
>=20
> It is the polling for regmap read/write, the regmap is also called
> regbus, so I name ns_bus here.
>=20
> I could change the name, do you think there is confusing also for
> ns_bus_reg_read & ns_bus_reg_write?

This regmap is only used to access the SPI master shared with Nios
core, right? If we compare nios_spi_bus_reg_read with=20
nios_spi_reg_read, I think nios_spi/ns_reg_read is better,=20

how do you think?

Thanks
Hao

>=20
> Thanks,
> Yilun.
