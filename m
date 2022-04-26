Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26D1A50EEBA
	for <lists+linux-fpga@lfdr.de>; Tue, 26 Apr 2022 04:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242056AbiDZC0i (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 25 Apr 2022 22:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241989AbiDZC0h (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 25 Apr 2022 22:26:37 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F561AD131
        for <linux-fpga@vger.kernel.org>; Mon, 25 Apr 2022 19:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650939811; x=1682475811;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4sp1mRspIFNSAShYp1g7ezpDpBNvQECH39V4A9gkd8k=;
  b=ndfF3LRZOysTnTU4CR2/gmy50+XliS7w9E2ZVttZytH954dpefC2XKPk
   O5mUwcEegfsoh0AVxZBLoBcBdUsenCpoB9pAZPtTqL0jEee7FB5spvPkl
   8vgTyRgiG+394L03KBlwFr3JnKovbXa1fYgbOqcZnMIxaH8/9rtBJi4nx
   r+5nE0XNMCryRDe9637wc30RDt5CCivUwxoLoVMxzBYldVWn5lR2d2TS0
   JTj5tQhJhhqAo5LSFW4JcnRdImplNJ5bngdBgMLCqWh8CNangvH0vibj3
   ZSKxlrUleyeP3cWZpmVqppCs3XoygMKfkaZXb90YTsWvNzi5cbbcxV7v7
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="247353487"
X-IronPort-AV: E=Sophos;i="5.90,290,1643702400"; 
   d="scan'208";a="247353487"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 19:23:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,289,1643702400"; 
   d="scan'208";a="579621476"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga008.jf.intel.com with ESMTP; 25 Apr 2022 19:23:12 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 25 Apr 2022 19:23:12 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 25 Apr 2022 19:23:11 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 25 Apr 2022 19:23:11 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 25 Apr 2022 19:23:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=McgoiWT91BMe7OjUdEmNxQBZufmOW6iGGJq5mutTUB+UZgnZrU3A6YgpiiLAE9A/2x/x43keyZ1lDWNKe9lkZYU9dQnafSJcIjcSat8yR9pd4eTqLSMQfxi1WkAWta5U66anrdpHg+Nc/fhmqYtfCf8txkBYqx9H9NuV6dRSqJ/aupHZ0rgEL7FnHV0K5ekthYmO7qQC65BkFLUKqTT5O/4qsi5FNT9zKkT6/P6LtEdxsFBGNhApaPqBm4JY9Kq4HSNl4Ng7Tw3f4F7V0eCanqw0JQ3+2YA0VwD0G7yqaDOyHJBD+G4ItuLEZ26ggTu0JkRZ0k02873rEaU6qFLKOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZddpPwlTyTCYTPUeZ/jWgP5vf3kVyV/NG9bJB2Oa6Ts=;
 b=NAOmlNl7pP+uVy3v3PJFQQ7a3wJlaFFwgTCX78/L4JMl6HZ31HAeCSJq93FKAGVj8qadPT380LyIDVmkGDeoC40pRqn3Fhr/7JvJTJ+HrWRpaIjPFkAdLXBnvvShY/nKaZeTJI30M/xQPMBAcdZUZVE3nHZYtJm5Opif/K1EoxeQCGEtR4EjfKvbisbtHBahMROTa2LqTn2CKav7ZvQzc6WZ1K24E00VvdR+1372DcLIfeDvxe8h22GlBFW48FChhH0I8VPkrSZM45PuljGpOnmkLDK9rDStmWxQiGHeWEFt5+LrBKHVUJuWfUkAOtj4P56tGT8vi4ubByLLhdx9Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by BN6PR11MB1411.namprd11.prod.outlook.com (2603:10b6:404:3c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Tue, 26 Apr
 2022 02:23:09 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::4838:60ae:b637:3fc0]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::4838:60ae:b637:3fc0%7]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 02:23:09 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     "Xu, Yilun" <yilun.xu@intel.com>,
        "Zhang, Tianfei" <tianfei.zhang@intel.com>
CC:     "trix@redhat.com" <trix@redhat.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: RE: [PATCH v2] fpga: dfl: Allow Port to be linked to FME's DFL
Thread-Topic: [PATCH v2] fpga: dfl: Allow Port to be linked to FME's DFL
Thread-Index: AQHYWH5hLEy5//OkIUeUFQiB6CLCtq0BdmIQ
Date:   Tue, 26 Apr 2022 02:23:09 +0000
Message-ID: <DM6PR11MB3819CDBE4F18480D9F19F83785FB9@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <20220419075224.430824-1-tianfei.zhang@intel.com>
 <20220425082006.GD363795@yilunxu-OptiPlex-7050>
In-Reply-To: <20220425082006.GD363795@yilunxu-OptiPlex-7050>
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
x-ms-office365-filtering-correlation-id: 89d864f9-2936-4a6e-db96-08da272bb4ab
x-ms-traffictypediagnostic: BN6PR11MB1411:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BN6PR11MB1411CD60E77D7F09ACD6207485FB9@BN6PR11MB1411.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Wtqd5/expv7uWK0VJTBYGQigq1iUuN3rTnWjuxGIQO3VridaZsu765UwgkTDmEUNvzZUr2+QbyasvA00PYr5BHz2JLqXCAvXVY0OAY9AM3T+MBZfvwYbb0neHoWbVR1UvswdlCDvnSyJ4lSZqg3VcYZuzQj17Vsow8sbEuFiXPADqPklNDFHQmys1Iz0KsCObR4AIj4nzLx29E3V2//UmNh0JswWFvVZGkOQciWsdMNMvdavBidqpz/U67xFBcqT58dlMuFpsFFB1oUC7tZEoMsCMmwSc5/NQwV9N60ImlD6GAZBChmYcV6D32DAAZ3HWOty6N/Lv1lzCD+h7XCUBEyhHhlvkdm/g+5TZN3eAMaZCLAiJ5oLbYq+XOEoa1DcX/EcgIbyuwRKP+4sICctYXiPuIirSNdvmZaEM1gzH3HpuDps+K0Ihq9SZ6lPmN22ykBlxFOnyEWW4IngbKC+ND8Mpar22js//+6E3uHc/x/6MuBafenf1DpLN0aXV1MrcNx8FnsE+P3rGno1LKHyCLzKBPg5GyBJ3Jvfa3cCSsEwsCGgr0IgSZYHp+Nqmrya3DvgDVW4YO2YT4lUpe2Y5yxgS6jPtWsVVGZcBSOQM5bxdG1JoF+MfOFEjDHECvggSdRo5XBrPyiBAbhT6p+nyvOVwkZvVjEERIx3W0o22nCWuUCd3muIPirb/vO9799bKn81og8Aw18sCwzuUKhP9g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66556008)(66446008)(66946007)(2906002)(64756008)(508600001)(6506007)(7696005)(76116006)(66476007)(8676002)(52536014)(33656002)(9686003)(71200400001)(8936002)(26005)(4326008)(5660300002)(122000001)(86362001)(55016003)(110136005)(38070700005)(38100700002)(54906003)(6636002)(316002)(186003)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LIl8H48qxgYqnbKJ7PSYqjYUz5QhZX5MbWSNpBjAx6uGtmZbYyIHaatmHlJD?=
 =?us-ascii?Q?PzKnzKK64Xgl0i76mb//qFheh807Jr+Xd+azTOQ4mi6mQZp08RY/pkNR7iHe?=
 =?us-ascii?Q?PiSd2HZyIB5vuBuDljAsTW6/MIt1QnYCQjy9SM7xep9UQTrdA6KJ2an9dnVa?=
 =?us-ascii?Q?xfbkM20SSY0eSPlklCl3eAzgWhKpYPRYjuoVelBLJnwmEqGLuvVOlwBA9RcM?=
 =?us-ascii?Q?ci88gS34Uc7cnma5R/bVMdPDTe2GryV1q3e/frZgMIm+Rd5CUDBLNCSiRnwk?=
 =?us-ascii?Q?vanSm4U/ze8oBocf1eMYJ3sqahGn9BGwxm7nwNBiFaeC+dpG0ojvkiaWgC14?=
 =?us-ascii?Q?yG9h51kpENX9ic5IOM5O3MiPcgzN1EjdvbhsU8BfKXWkuXwGwHIF6yFz3lNX?=
 =?us-ascii?Q?iGhf+vqfNU0JrhUAHZarW7ItRWmZ0JrjB155MStsSBppxjQml+PR54WRzvdq?=
 =?us-ascii?Q?Qrabrxp88gFTxuu+zBeUzV3uJqn2YCmD/MNNHCTcA76FXs0YWdUEDMk1dqnL?=
 =?us-ascii?Q?UMfrvUxySTs+epu7UzaKeK6XK+G2HSka9zZMyrJU4xgSUt7rdjaNn1lrSJsZ?=
 =?us-ascii?Q?p88Ef0a+4BOc5g7OMza3hWkjL5JXSDoq35DH2N9aKpbVxGHeWc2w3QL/M4w7?=
 =?us-ascii?Q?I20SatlpOVw9GhiPtPY71I+9NtWaRnWyyNEJu+JltUg43bz23S8OY56Ke6m8?=
 =?us-ascii?Q?EWdG3PTjVnLPrtrWnTgeXD7waxnGkrifuBEDMOHa7usDL8uvapSJ8Ws8M/H9?=
 =?us-ascii?Q?N+8MZy93kZMZT/SSp1eZFxaemmF+B4VpL5qoV9nwj48THsYSZwajUbtxNEJd?=
 =?us-ascii?Q?509GmW/DguS1WYmd4eXe/wuMaKeRIoXkicPPH2EixEwjj39KWlD/oslvq4AF?=
 =?us-ascii?Q?/bwHfIcsZFLFFMVHOH9WVU26hB40B+55Za2j9dqELGU7DxsCKUfdyAwk6Odf?=
 =?us-ascii?Q?1xmGrXOECcqJArImJEjzOf05ad3DmNfWpRj1PnQ6Z4ErA36SQRlCHvTgslY9?=
 =?us-ascii?Q?yIyL/dV0ZYpsTyB3taj8TKKad9quhxvN0woOGYO+9yEmTQo5Mx/SyPjq0p2f?=
 =?us-ascii?Q?YijzvVVNKJhxLyQF7mUryHQTrNmtXqHRhlcU3/WCq6FSqa0Ugi24r3QN6pT0?=
 =?us-ascii?Q?USVaJf9cBJlfCitQGz7qcuoJKu0URRkB8tOFXdZFfqLMbRN+sRV1RSidhB3n?=
 =?us-ascii?Q?rRct03keI+Y7sVsr7wi7CAq6m90T9+uOUR51LiRKXUZwvhkKnrqCeXBSpyHB?=
 =?us-ascii?Q?Agyw7fO/6smIDMsmzsO7bOOBzIMmU6gK09Xc6zlG14hG2TLOByL5Ib5XYTtl?=
 =?us-ascii?Q?rk4PdDevpyNe403tca9aY6mp+/E908LI0E/IB9xaN/5iBimd7n1EjvJoz8Ng?=
 =?us-ascii?Q?XtAUZMFzbHZ+6cD4aEQAc+liHe34IJ3rJP5OeHjSfo84wMIUMQHtirfeQwBo?=
 =?us-ascii?Q?DO5SklfhwH4Dl+oXD5ZLHuDZ2++Q2xMYsxTo5D6x6v3HAxlwm1jp0Nl+3LFu?=
 =?us-ascii?Q?gSOqhZ/oB0uBtbJ6+evvqY5oUkpKq3ZrJ34DF+cpuVHbt4avatBHaeHe5hXT?=
 =?us-ascii?Q?OXNuOk0nu9yy2VVbXB9AdISCtmo2Wz9GVroejQRmzv7FQetUqzTVu8IRlZV4?=
 =?us-ascii?Q?IjioqvIMfvB9aCzKDOgZAXoGz0EkODVcZW7aMptpIxxVaDjjqHD/jh3ZCzNy?=
 =?us-ascii?Q?SyQyaLgKC9XBQM9B/4AYlILh7/Fa7PsiNdP2IXBe/vWQ9lzM5DKvPA4V5EqO?=
 =?us-ascii?Q?vVXthSufdA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89d864f9-2936-4a6e-db96-08da272bb4ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 02:23:09.4116
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J7Svgbb7aC4ZjslJo1jrYa5FFtNqQAwPIeyHeKDvv/iIKDn+E8KxHDZ+Y0PZNpJiSGMXChCsOblFohm4kV35Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1411
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> On Tue, Apr 19, 2022 at 03:52:24AM -0400, Tianfei Zhang wrote:
> > From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> >
> > Currently we use PORTn_OFFSET to locate PORT DFLs, and PORT DFLs are no=
t
> > connected FME DFL. But for some cases (e.g. Intel Open FPGA Stack devic=
e),
> > PORT DFLs are connected to FME DFL directly, so we don't need to search
> > PORT DFLs via PORTn_OFFSET again. If BAR value of PORTn_OFFSET is 0x7
> > (FME_PORT_OFST_BAR_SKIP) then driver will skip searching the DFL for th=
at
> > port. If BAR value is invalid, return -EINVAL.
> >
> > Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
> > ---
> > v2: return -EINVAL if bar number invalid.
> > ---
> >  drivers/fpga/dfl-pci.c | 11 +++++++++++
> >  drivers/fpga/dfl.h     |  1 +
> >  2 files changed, 12 insertions(+)
> >
> > diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
> > index 86ed9e4223d3..5bd6ef231ccc 100644
> > --- a/drivers/fpga/dfl-pci.c
> > +++ b/drivers/fpga/dfl-pci.c
> > @@ -263,6 +263,17 @@ static int find_dfls_by_default(struct pci_dev *pc=
idev,
> >  			 */
> >  			bar =3D FIELD_GET(FME_PORT_OFST_BAR_ID, v);
> >  			offset =3D FIELD_GET(FME_PORT_OFST_DFH_OFST, v);
> > +			if (bar =3D=3D FME_PORT_OFST_BAR_SKIP) {
> > +				dev_dbg(&pcidev->dev, "skipping search DFL
> for port %d on BAR %d\n",
> > +					i, bar);
>=20
> I suggest we remove the dev_dbg, it's a normal case in DFL walking.
>=20
> > +				continue;
> > +			} else if (bar >=3D PCI_STD_NUM_BARS) {
> > +				dev_err(&pcidev->dev, "bad BAR %d for
> port %d\n",
> > +					bar, i);
> > +				ret =3D -EINVAL;
> > +				break;
>=20
> The code is workable, but I suggest we use goto instead of break for
> error out.

Maybe "break" is better, if additional code is required after the loop in
the future, we don't have to modify the goto label code again. Just my
personal preference.

>=20
> Thanks,
> Yilun
>=20
> > +			}
> > +
> >  			start =3D pci_resource_start(pcidev, bar) + offset;
> >  			len =3D pci_resource_len(pcidev, bar) - offset;
> >
> > diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
> > index 53572c7aced0..e0f0abfbeb8c 100644
> > --- a/drivers/fpga/dfl.h
> > +++ b/drivers/fpga/dfl.h
> > @@ -91,6 +91,7 @@
> >  #define FME_HDR_PORT_OFST(n)	(0x38 + ((n) * 0x8))
> >  #define FME_HDR_BITSTREAM_ID	0x60
> >  #define FME_HDR_BITSTREAM_MD	0x68
> > +#define FME_PORT_OFST_BAR_SKIP	7
> >
> >  /* FME Fab Capability Register Bitfield */
> >  #define FME_CAP_FABRIC_VERID	GENMASK_ULL(7, 0)	/* Fabric
> version ID */
> > --
> > 2.26.2
