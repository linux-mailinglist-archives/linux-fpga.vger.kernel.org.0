Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5591B50EEC8
	for <lists+linux-fpga@lfdr.de>; Tue, 26 Apr 2022 04:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242360AbiDZCcw (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 25 Apr 2022 22:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241240AbiDZCcv (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 25 Apr 2022 22:32:51 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B2D81267CB
        for <linux-fpga@vger.kernel.org>; Mon, 25 Apr 2022 19:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650940184; x=1682476184;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sMI9gi16BGsRC5peN6YDdF0iKiv9BkSRR+S6clnQZQE=;
  b=AFAh9aXa9WGMpYrh6flWnVllOJDD79wRB/KPueQ6psDfR+hWn2QGrFNC
   NPoShT91VLOZ65HPLFYt0e6b8la8YGiew3fKj6b5UGr+HEPb+GxhR7bIe
   NQmXo2VIZChYHpVs1aBUUKO2zX2QN+Bmt5QTNPqNsZISnwqhahtKfDvgh
   vUlEPrZrw9HM1Eyw+dAhB0lldL10wj+cWvgPKmik4l50yyEZkSrOFUuxU
   EeXAqbsVxh0f62QhNFBFQ55iGAaX51XRdkvwMJLzSpARuBKq7ZecQIWm+
   9JcH7rcs3G8vO56WVbPOwtVCZT2UK4YfNzpck8cIhAiDCmo3YUtRNq0Fk
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="263020251"
X-IronPort-AV: E=Sophos;i="5.90,290,1643702400"; 
   d="scan'208";a="263020251"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 19:29:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,290,1643702400"; 
   d="scan'208";a="730017160"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga005.jf.intel.com with ESMTP; 25 Apr 2022 19:29:28 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 25 Apr 2022 19:29:27 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 25 Apr 2022 19:29:27 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 25 Apr 2022 19:29:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m1Ob9iLQSWCWlEMbP9pMA3QzQTusXKE+afhqXHM0uNLkGbRP2TzmRRHMs3iSHDillHUXvvdcGXw1QQzZaOeO7N6U+XGJl5bDR3AmL2rZED/uHPZ5dphgYXpOd/NCCTgGAZpo6q82eRyge7YH3T9TsAU9qtcT4VjGVv1fkN8M4e2HWxmzaP6c8e/jQJSOt2MBmuTKxpAL8q+vU/eHWBs60sQ23Pmlr4B2rqtI96FbzDt0Z8/QnTIoORf+Hqeaf25/eWD3YGXFSwf5GW3vAcTbb1LBfpU4iS9XyJBtlhqZIN+IkjThU/t0YeDlw8gRT9kdg0Db29DV2JuWJQE/GeDUNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UU757KIPr03WlWsMTkwtfaaeRAjBZL7SS2d0hTg0eWg=;
 b=SGLy2X7ywpYP7nm3Uc9UZ1r2pJ84XMjJYWI9yAO3N3jvgvjLKOxonPU/URzUTfw4Z9PlRnAI9U4RLViqJk8c+03/tXXlUruu3RBFRomZNJ/Uhv8gsEJ+g5EzaqBVq5PyG/8oiT9EKL8UM1ZKxgUmix2H5A167zAXKSW0oBGWLlpNg7GruHjwYgGsDP+TKkhvPWWlLL/BXR1UvLIyYwcgZ/3FPLne72lRduvHVNgTF9RGDmhvNfTwuvLczILau0IMHSVHZBDC3DxWzJxxyx7FTiE4SKVJIG3JkV3WoewLn37GH4h/wpgOpj3SO3iAly+RFvApteNI08tLlplsaNEowg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5483.namprd11.prod.outlook.com (2603:10b6:408:104::10)
 by DM5PR11MB1545.namprd11.prod.outlook.com (2603:10b6:4:9::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.17; Tue, 26 Apr 2022 02:29:25 +0000
Received: from BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::c076:6436:db8e:ee22]) by BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::c076:6436:db8e:ee22%9]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 02:29:25 +0000
From:   "Zhang, Tianfei" <tianfei.zhang@intel.com>
To:     "Wu, Hao" <hao.wu@intel.com>, "Xu, Yilun" <yilun.xu@intel.com>
CC:     "trix@redhat.com" <trix@redhat.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: RE: [PATCH v2] fpga: dfl: Allow Port to be linked to FME's DFL
Thread-Topic: [PATCH v2] fpga: dfl: Allow Port to be linked to FME's DFL
Thread-Index: AQHYU8LoHkY5keYwnkW64jIHxsMWF60AUwQAgAEumoCAAACngA==
Date:   Tue, 26 Apr 2022 02:29:25 +0000
Message-ID: <BN9PR11MB548385FAA79C03AEF3DC2960E3FB9@BN9PR11MB5483.namprd11.prod.outlook.com>
References: <20220419075224.430824-1-tianfei.zhang@intel.com>
 <20220425082006.GD363795@yilunxu-OptiPlex-7050>
 <DM6PR11MB3819CDBE4F18480D9F19F83785FB9@DM6PR11MB3819.namprd11.prod.outlook.com>
In-Reply-To: <DM6PR11MB3819CDBE4F18480D9F19F83785FB9@DM6PR11MB3819.namprd11.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.6.401.20
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a814692e-1bfe-4bd8-7248-08da272c94cd
x-ms-traffictypediagnostic: DM5PR11MB1545:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <DM5PR11MB1545479A8A79324ECA675F57E3FB9@DM5PR11MB1545.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kn038ElTqkbMOeEJW2FtNdjE7o4o/U2IlYSEnU0BAmcGplhsw3GVmd+mV9zVGZIrdjiP/etJgcwOT9qf6Ruutc9xroPwt7X09GJtcephdCAj5je8FYZwfz5m7zgPWNn38nELoPfXHgXpSVmsvnRUI5nsLZ0VXW9r85Mj7F4VmQxAPFy+CFB+9BWlCTd4okUsHXn3w8OeHdem9hlbBUczB412XrmAlYh4Obenys4DVpT3alJNeQdy3YCz0asgD3IJTbBhRSTd0FdQX0WthuVixuY6UfSPU6GXhukOPTkbCHCaEJHR9cT2gmYLEUIO84y5yZ/gSPNGa3NneoQ7JJZNNqmgsTgKg5m/sjW7tCUUYQKfGoomtuZXF0YuEbSLIvLG/fbuhh9kWmAokbxs0Dax2JTtNhIZCehbU6gVg1X5uQ+GPQNmCT3DwpJIN/4ZgKolRMkZW7hoz663CP5cArjmw0mBUyT9PtavIo0x1keDc1+pkmB1XaijJp6IYmkgArKeeUwh51UUWra6mkci2wSHBkJ5sz1H/U5hUo9S3QbeqOOfjrWQyLPJ41MuXgx8tblUOAkw6cuqUub8EYZWPRDWx0p54K2GhsW+7zO6xN8ftUF+mevD0O5xZP3IV4YA/AdolyWtB8cJU7y7cPGHziNCHpkpcVsX0MH04RmOqHhc9EAYvyTw9EKNSlwT9ZzZ4TZFvDaQk8bGoGnDUELBTO4pgQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5483.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(55016003)(83380400001)(5660300002)(122000001)(82960400001)(6636002)(6506007)(7696005)(9686003)(53546011)(316002)(71200400001)(26005)(38070700005)(186003)(54906003)(508600001)(110136005)(52536014)(8936002)(2906002)(4326008)(8676002)(76116006)(66946007)(66476007)(66556008)(66446008)(33656002)(64756008)(86362001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jF7BQ1qlhFjvowjrfJbe49V+7jygr4VT2gWq+nYtk71VhDCVKkcSd4nEK/Z4?=
 =?us-ascii?Q?sv7DHL/qyKhx89toNJIMgSeHIZ5m5vMch8NtPIqQI/PFM2Ys4Xb4CI5LZHLX?=
 =?us-ascii?Q?HvID0wdjuWi0lxf/WEccSuubV7sIxWWrcyNJL1y6i1mfSFDKD95UNOTo0hut?=
 =?us-ascii?Q?nXznJFieTC6GJk7ytKamBts/psUOk32QQVqA2s1RHOKAm4Bx0wrFW5Ng6R7Q?=
 =?us-ascii?Q?ZmS2f1Me7f0JOU5EmD+/RgKHyuIvRV9znk2AKGryyEMZ5VibAMkkA9H0AGui?=
 =?us-ascii?Q?/z6NIsBi8SR7qkGBP3IJtfyLVtTJ4KF/n+Ea1QbWbr9WTIg4JN1KBtrv1U9x?=
 =?us-ascii?Q?o83sNPHSkp7n0hdZq38z+B66bVQyOGYEvyNKX6dQh2Z7QhIkBefY7wMXP6nG?=
 =?us-ascii?Q?LG6ANIP329wi1Xw+9ih+iShCTd7L32Ouo3qfJCIBCqTp+eDHkMTQmEOhmE38?=
 =?us-ascii?Q?KuPL9uRVKKZfYf2jVkOcmsL7K5b+IPv/FSSiuNfPf3/dN6WQAydHyFmiF5AU?=
 =?us-ascii?Q?WtE/ASNFAZGeS6selot6xYhNxzHxln+qtocvo6+dL4dEakRS4dvHSd8WP6V8?=
 =?us-ascii?Q?5IjtcBnXDfMpeA4PyBDJ7MidLzvLk9E4wzYR5OHI5zDcR1FE5G8lEfC9M3q3?=
 =?us-ascii?Q?JoA9/pJZui2FhCm2is+5ZiA8QHWQXTWyhoKw5ov76ERXJbfZ5nlkUuFVOA0v?=
 =?us-ascii?Q?RXKY3BCE+PhpSA6Jlfr/3r3T8klcPoNVuzOQB32affTLl8HI3C1KVRMrZ1Q8?=
 =?us-ascii?Q?+4hmcU+1/wt3/1qhPrbnRX4v9DJVAds1yiRj0MrIVA8XJMLOGSwBV5g4H3nv?=
 =?us-ascii?Q?skcjzdOJj3YnGp5yjaEApz1VMhvRoc8WliEnLgqHrbHwpGFizmyxuUZW6D6k?=
 =?us-ascii?Q?cBn+TnmsAs7gmDDzN3jgFAvTJZisrlFKS5xemIFhc6vMWbizLFhTW4IKNNb+?=
 =?us-ascii?Q?YtY6ACs91cRceSDOLenswBs0cgpd5cZw0zNLvbgXVsK7s9rGUSIE0z5ao2jC?=
 =?us-ascii?Q?W1hhXzd1IPZ36CcISMPnncBMNMoBKvsiq0qZQnAU6c0WWAwHRJ0BMwldw5q5?=
 =?us-ascii?Q?QAx0v9IuMbc0ROHHo44D42aGDRTfCe4JwOlqieYp3MkklQZ6DqmIYmCttNyv?=
 =?us-ascii?Q?VMa1ZUbcWWtUaRTXvHbSs1LkLwutuKsYpH2uqQl+GPeQ3T+UY8sMAF1qiFa0?=
 =?us-ascii?Q?s7wqBRYLQIq/+ofiAZIOo6zRx4CwiuQrZUHEW2j4IQVJzE1O4MqeaPbYSNjj?=
 =?us-ascii?Q?l0Jt9m5pAPCh0JGhBdoCkZP6kP286GMrhJ2mb3cBSifGYiLv6EY2z96Y7dgA?=
 =?us-ascii?Q?KGnIoEmYI62cm3mpXPiPCSiODf4Fn1eTxI6HggpytMaPN2eU9wpdKmsaz37m?=
 =?us-ascii?Q?Z3e+5BW0EndHIDsYTSwJh+JlNmGZ+pjd9Ps7DLYIH8kN+U19JKyCPGDrOcad?=
 =?us-ascii?Q?d/0H3EFMPfyDtopMW1eCgEG7ksN88r63UPFAi7YVGIxuYxCEXOVxHgbDmJL3?=
 =?us-ascii?Q?b4V0uUXONTzI0T8yGx4bYPnN/JO38eLk4gPblnMPMKCIkY7xO+BQnuYo4P2G?=
 =?us-ascii?Q?5sPPYYSZAZytmKiMkgbJKue1VNZ0R8y3yDebDxSl4TjRYFw8e5qs3LT1BuSC?=
 =?us-ascii?Q?G90pBwN22aN8OpLAb297L7xp1CglrbqFYtj/6MQL0uU3wjEh93HsXw1aPBGB?=
 =?us-ascii?Q?7+fnhaRkFjJDLJGSA06nvCVnCuiZMLnP0af7yeP3cAmx4BZq8eK8VSAwkXFI?=
 =?us-ascii?Q?MgYjYjdo6g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5483.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a814692e-1bfe-4bd8-7248-08da272c94cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 02:29:25.4570
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: czEiRA+6qnaAZtFEdmH+oUMWsxJrSA6jOPmlkme0WAtl8QxjogrkZDdF/8NWDSPPFu/I2JL2f4L9esWsAkcYaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1545
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



> -----Original Message-----
> From: Wu, Hao <hao.wu@intel.com>
> Sent: Tuesday, April 26, 2022 10:23 AM
> To: Xu, Yilun <yilun.xu@intel.com>; Zhang, Tianfei <tianfei.zhang@intel.c=
om>
> Cc: trix@redhat.com; mdf@kernel.org; linux-fpga@vger.kernel.org; Matthew
> Gerlach <matthew.gerlach@linux.intel.com>
> Subject: RE: [PATCH v2] fpga: dfl: Allow Port to be linked to FME's DFL
>=20
> > On Tue, Apr 19, 2022 at 03:52:24AM -0400, Tianfei Zhang wrote:
> > > From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > >
> > > Currently we use PORTn_OFFSET to locate PORT DFLs, and PORT DFLs are
> > > not connected FME DFL. But for some cases (e.g. Intel Open FPGA
> > > Stack device), PORT DFLs are connected to FME DFL directly, so we
> > > don't need to search PORT DFLs via PORTn_OFFSET again. If BAR value
> > > of PORTn_OFFSET is 0x7
> > > (FME_PORT_OFST_BAR_SKIP) then driver will skip searching the DFL for
> > > that port. If BAR value is invalid, return -EINVAL.
> > >
> > > Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > > Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
> > > ---
> > > v2: return -EINVAL if bar number invalid.
> > > ---
> > >  drivers/fpga/dfl-pci.c | 11 +++++++++++
> > >  drivers/fpga/dfl.h     |  1 +
> > >  2 files changed, 12 insertions(+)
> > >
> > > diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c index
> > > 86ed9e4223d3..5bd6ef231ccc 100644
> > > --- a/drivers/fpga/dfl-pci.c
> > > +++ b/drivers/fpga/dfl-pci.c
> > > @@ -263,6 +263,17 @@ static int find_dfls_by_default(struct pci_dev
> *pcidev,
> > >  			 */
> > >  			bar =3D FIELD_GET(FME_PORT_OFST_BAR_ID, v);
> > >  			offset =3D FIELD_GET(FME_PORT_OFST_DFH_OFST, v);
> > > +			if (bar =3D=3D FME_PORT_OFST_BAR_SKIP) {
> > > +				dev_dbg(&pcidev->dev, "skipping search DFL
> > for port %d on BAR %d\n",
> > > +					i, bar);
> >
> > I suggest we remove the dev_dbg, it's a normal case in DFL walking.
> >
> > > +				continue;
> > > +			} else if (bar >=3D PCI_STD_NUM_BARS) {
> > > +				dev_err(&pcidev->dev, "bad BAR %d for
> > port %d\n",
> > > +					bar, i);
> > > +				ret =3D -EINVAL;
> > > +				break;
> >
> > The code is workable, but I suggest we use goto instead of break for
> > error out.
>=20
> Maybe "break" is better, if additional code is required after the loop in=
 the
> future, we don't have to modify the goto label code again. Just my person=
al
> preference.

Yes, Yilun suggested here is goto is better, because this is a hardware iss=
ue, it should be handle the error immediately.

>=20
> >
> > Thanks,
> > Yilun
> >
> > > +			}
> > > +
> > >  			start =3D pci_resource_start(pcidev, bar) + offset;
> > >  			len =3D pci_resource_len(pcidev, bar) - offset;
> > >
> > > diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h index
> > > 53572c7aced0..e0f0abfbeb8c 100644
> > > --- a/drivers/fpga/dfl.h
> > > +++ b/drivers/fpga/dfl.h
> > > @@ -91,6 +91,7 @@
> > >  #define FME_HDR_PORT_OFST(n)	(0x38 + ((n) * 0x8))
> > >  #define FME_HDR_BITSTREAM_ID	0x60
> > >  #define FME_HDR_BITSTREAM_MD	0x68
> > > +#define FME_PORT_OFST_BAR_SKIP	7
> > >
> > >  /* FME Fab Capability Register Bitfield */
> > >  #define FME_CAP_FABRIC_VERID	GENMASK_ULL(7, 0)	/* Fabric
> > version ID */
> > > --
> > > 2.26.2
