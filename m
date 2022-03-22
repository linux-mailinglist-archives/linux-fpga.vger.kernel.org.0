Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2C34E39E3
	for <lists+linux-fpga@lfdr.de>; Tue, 22 Mar 2022 08:48:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbiCVHrn (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 22 Mar 2022 03:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiCVHrh (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 22 Mar 2022 03:47:37 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D38A1C929;
        Tue, 22 Mar 2022 00:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647935141; x=1679471141;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=43LCu4BdhBVJqNm0wJyoLM/WJb4LWJfcNtr/87WkSPQ=;
  b=KI1+oxmL6Ks3YOqk8bL02wBuJ7MecW+xoKPVJR0RLg+TkAusvLlIy2IN
   E6Huv6OTPEj823SfIeBgFln/OCEuaqxb8/te5niV+UMSsi9ZjgqG8noA5
   RwmeEAhR3Q3ggrIBSs8W8qLpK8q0HqmOII53uoEoz0COQ0UyHoeVLttM4
   ieIJVaL3TIiJPKFcr2C+gVvqIFq1DeMdCQIEoObKateZUozQx1gfBzUQl
   mdiL2zRhHtDbapnvPf2UsRdr/pznht+DqU/c1ZnVrdJCihzXPcEjEhQsM
   ybuh2Om0TMCefJy8JJSpxeDa3npPVl3lWhIytIZG7P+lio8ADlkFDlC6l
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10293"; a="344182061"
X-IronPort-AV: E=Sophos;i="5.90,201,1643702400"; 
   d="scan'208";a="344182061"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2022 00:45:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,201,1643702400"; 
   d="scan'208";a="543580665"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga007.jf.intel.com with ESMTP; 22 Mar 2022 00:45:25 -0700
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 22 Mar 2022 00:45:24 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 22 Mar 2022 00:45:24 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 22 Mar 2022 00:45:23 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 22 Mar 2022 00:45:23 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Tue, 22 Mar 2022 00:45:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KA7PHCeN+qHbSjGX3txr3dS2X1m4rXlQhNgTAAT3Jbe42ihzbtOfW2EwfS0oAiY3ShyOE0gHECEP4L8dpBTxemo7aTl7a85ZYVuozs6HjJqGjSpjqNW850yoEfADHcBkGt1Q26D87pgaV+BnvfRgrYPWTXadqqRIa/kwNDDt9FSqdOiPP600CkBZy4fjwapDL+WlHCOpTmT0urb26iEfl/PmJWHiKEC+M61QjUs0XFI+Smmys94+l35P8IzcuZN19C2MNnslp7beGXr2nyTDqj1ZZOBD1qbvKijyxe9t8SHlJEKtj4Y82pu/l6U5O9IyX4tkXjSWxi30oqJ8hrWtVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ya+kitdwDweVb1m52wf/eHGDnL3ySr1PNMCs+XVIK8Y=;
 b=mSzZJ9Leki4xaLsH6nklC9AtxIklnJrS85wBlcl+laOTAqNQgVSZvwHhSIDwRGQpVZxx76QdSeODmdz//ORFtsm7DFtbMJ+evbSzfTXEl0ceGprW6MbXJNynCkD41xqjoypqByY40vgvs1ETbp4dEkiNnEZf6A/PnfH4gjhhFjHRGVvLoqxmy9pEA7UtS50KVc7EJd7xrZ6N7+lP26b4uIPJFOorCErQwR/CAjhS4/m7fUef48u7X4oYyi4HeunFGpOqhqMWHOqdx9Hb3bsZBjTTV+jXhO8u0tyLdLzAlbXrASLdBbOKAHyACFg7hXoqoy22msfC5YGB5i2QtEeTxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5483.namprd11.prod.outlook.com (2603:10b6:408:104::10)
 by MWHPR11MB1519.namprd11.prod.outlook.com (2603:10b6:301:d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Tue, 22 Mar
 2022 07:45:20 +0000
Received: from BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::8c4b:e24c:c69f:7809]) by BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::8c4b:e24c:c69f:7809%5]) with mapi id 15.20.5102.016; Tue, 22 Mar 2022
 07:45:20 +0000
From:   "Zhang, Tianfei" <tianfei.zhang@intel.com>
To:     "matthew.gerlach@linux.intel.com" <matthew.gerlach@linux.intel.com>
CC:     "Wu, Hao" <hao.wu@intel.com>, "trix@redhat.com" <trix@redhat.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "Xu, Yilun" <yilun.xu@intel.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "corbet@lwn.net" <corbet@lwn.net>
Subject: RE: [PATCH v4 2/2] Documentation: fpga: dfl: add description of
 Feature ID
Thread-Topic: [PATCH v4 2/2] Documentation: fpga: dfl: add description of
 Feature ID
Thread-Index: AQHYOncg7GsMrXxd9kSP/V7qFr9prazKe1aAgACQ1lA=
Date:   Tue, 22 Mar 2022 07:45:20 +0000
Message-ID: <BN9PR11MB5483564D3A228D690C6AE60CE3179@BN9PR11MB5483.namprd11.prod.outlook.com>
References: <20220318031654.2130587-1-tianfei.zhang@intel.com>
 <20220318031654.2130587-3-tianfei.zhang@intel.com>
 <alpine.DEB.2.22.394.2203211604590.4191417@rhweight-WRK1>
In-Reply-To: <alpine.DEB.2.22.394.2203211604590.4191417@rhweight-WRK1>
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
x-ms-office365-filtering-correlation-id: bfa0895e-8ddc-4f81-6ce8-08da0bd7ea91
x-ms-traffictypediagnostic: MWHPR11MB1519:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <MWHPR11MB1519C157D2102C5FEFEAE0D1E3179@MWHPR11MB1519.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YZAfw3nk8UNiKFqr0NP0bNLBAHVJ4YnTSc2bo3jXWhYK58doOOMON9gsx4lnZIWt6tpy1qEXScfbmeg2ozcWEB445U9aBomAe7voO8rgEnenX18whQS60Ugchf1wk2Ch5kIDG1vTItR9D0q7JRqnDvpOFkYdbFTkDgag+t03rVyzTXCd0/hFwIFyADX0A2z4pWFGR7vU32x1m9EInECglFwaw67jc+LY/QqYZDHndfxzwZFR5eliQ9EuRmx1HWbUgaSSmgTjPEOybgNs9q2ZygMEzzkwRiV23GLAOWzyGNjsLd5Nta76KXCkDmNABEviIzzR4Sk0Q0go/1g/tLPGyFhi+A/oKhTmRM0ItomFSmCUYWV/7IDYoAZRQXH5JxYHjVsLNIgX8HqxTDjlfbR5CYb8JfUXFaFtlFv3TxPbfDTqoMM6HBXtUmnlib5LodAtqtyrvvP5crVxOQsYtEtx5I17q1Zdedd6H6DXV/67Qvx6qKEqQL9TyXYigu4pTQeclOozxBMSnx/j04dmGqh/WIy3K0M1WNVS1pwczfpZaue8qkCBjyhe1Ojao8JwiHYQtD0XVcYwQhHcduzsmOYPg0MyLfCtbi+5MUHSw7b+OpuxWb5xahMNzTxRiPidDgd9cp+RTS/6R1Rw0DmdAnLRAbCgl7MhRBRycVMiqM5Js8g8NgblSBF6dYjAmTyZcHwOSiDnVE/PJr0lXYDEn9shYsj9oJ+DAh/ibG9H4uYb8D+G7RFZre8NLq0L26UFsIWBjqPeXMp5q97fFDxlTxbNiUD44SAAMcJkl+CZjx3BvNIZBqiJxh/xQCi1kjYgllkUTzdVHBL8n4bUq+zq4j4tmw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5483.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(53546011)(83380400001)(9686003)(6506007)(7696005)(33656002)(82960400001)(508600001)(55016003)(186003)(71200400001)(54906003)(5660300002)(38070700005)(8936002)(52536014)(38100700002)(316002)(4326008)(6916009)(86362001)(66556008)(8676002)(2906002)(122000001)(66476007)(66446008)(64756008)(66946007)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?B8+45dXvmT2f8IDtKxgYXTR7gCg804fCIehgvtwqWqGk9FsHQ4ZF6r+o3Ut3?=
 =?us-ascii?Q?efPyWqCHSIXqzYseL6y2dmyGVfbBINGzw1jsXqEkfzwbLe8sjO+oQDPoyhqS?=
 =?us-ascii?Q?HGR+U/2dpV3vOT6nzRezI5CyIfXYXuixx3NNZ/y0xQGCrj3i7rR45fmrxsa0?=
 =?us-ascii?Q?VGdYqlQEYKER8OoSLfpVLEu/5kfrHXnl6wlTaFvpHC2la/aTJJYuYKLVHF6/?=
 =?us-ascii?Q?iSr6vK0VSAFlBqK7v+DerTSpdvCsA+caXIVP1wcE0B5230tBVTbJrnJxUDlw?=
 =?us-ascii?Q?RGvNBKt0sieUxhOZohF+zC6hG89wagYBNawpN8H9F8BjtwTRAv9xSn6ZLW/8?=
 =?us-ascii?Q?OWkp2OZPI9vUgb4KgNR2zR+2+Ov4cBr1Boab4YQ0sfYWoculIGOoLz0DRqaB?=
 =?us-ascii?Q?6HwrOZJWMxs4FniNChnQ/pT9HU3dLNH6/qObkpaAVAL+X1qhIYEVTDTexYpl?=
 =?us-ascii?Q?Lq4c8pzwr9xKhfsA3n2bsqFRo64WM8lpsbfsMD+GXvYH3VqCWwODWPdFL1HM?=
 =?us-ascii?Q?1SUOkJTYV01ZGGGIhflw231VgwcKpF8MPGOYna2kK59PEVxnhr/0UhQWyWtL?=
 =?us-ascii?Q?l/mVf0DK0X+jEkUwkLReBJe8NegRVcTwuEI3VKA3giWFZnG9j//kdZWdszrl?=
 =?us-ascii?Q?YnYa5E0gDJkIlG6X0w1+QYdYDB4qNcyItnMqqBhM5beiMhmqSTtSJH0dZtu/?=
 =?us-ascii?Q?iO8GPAkd7aR2ZEwA1OScCRG5eJpEoM+6GP22s8bZuxS4FHQtaYI+NIjQu20p?=
 =?us-ascii?Q?G9ZpP/dUk7YyYOQc33jo+oEGT3LNHG8IuTSGjsiMjWepxlsAaeuXdpBRSD2c?=
 =?us-ascii?Q?GBY4RP+8j5IMfnj0DAOMuPlvOiGuBQofZ+mKvyVpR+m1x44oDiFkrw3Z/JNa?=
 =?us-ascii?Q?RZsVKy2AV0GaVJ72Y+Ya0qBSwjWFwdLW1Gxs3y2Bql0w63O/8r8o6xS9oosg?=
 =?us-ascii?Q?V05qhF1lu3wOdHZSF5+tKT7wSyPLLkhpEEBHGbtv4IioUb0nkKURBJz849Xm?=
 =?us-ascii?Q?297YUxCbHeKPi0GKejuyFBI0q7AMJ+8YdOO8XiC6sCX5gitLN8oZedHB5rU9?=
 =?us-ascii?Q?OaUtDzFBbjZ8YejV6oY7odjqYOvr75O+7fBgJDHbVLoJ2Dp1YEnHiE/0mqZ9?=
 =?us-ascii?Q?MOpzo8Wzqp8Jm8IuBYu2i9pIj6WwEsRao+pHVc2bduarnK/uaCOScE9xCgvK?=
 =?us-ascii?Q?XUPWoa1Sh0z+JpHKO3HDaWJdM/sRQg9guEzttWkiFATC2K7SSXs3N8c9zxTy?=
 =?us-ascii?Q?8GdvZL9fCQ5G0WreiqP3b50RMJZiRTgdZXX62uTr7UtOWAXhAGZlrKfn54UQ?=
 =?us-ascii?Q?Xs3hBLA6BzZOTNRjGzN10LfYOQEg+aupcjlBe0FN2J53bIWTKptlG4emq4hN?=
 =?us-ascii?Q?UPjr7O22DrlN5Rkw0NhLhCNHUhOT0ZCXE4uMnh/F077mqiojxiFUC87zS/J4?=
 =?us-ascii?Q?6l/67taEeIDg1Czfet3owmbZ86APtCrU?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5483.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfa0895e-8ddc-4f81-6ce8-08da0bd7ea91
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2022 07:45:20.6057
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pv1R1rBR46p4ObBZSSHFNvyj97yMyHKvcrq35TJec21YTaPQOFYK75chngSjXrPh1ZmgmOgyxdogwjNB6lrEqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1519
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



> -----Original Message-----
> From: matthew.gerlach@linux.intel.com <matthew.gerlach@linux.intel.com>
> Sent: Tuesday, March 22, 2022 7:05 AM
> To: Zhang, Tianfei <tianfei.zhang@intel.com>
> Cc: Wu, Hao <hao.wu@intel.com>; trix@redhat.com; mdf@kernel.org; Xu, Yilu=
n
> <yilun.xu@intel.com>; linux-fpga@vger.kernel.org; linux-doc@vger.kernel.o=
rg;
> rdunlap@infradead.org; corbet@lwn.net
> Subject: Re: [PATCH v4 2/2] Documentation: fpga: dfl: add description of
> Feature ID
>=20
>=20
>=20
> On Thu, 17 Mar 2022, Tianfei Zhang wrote:
>=20
> > From: Tianfei zhang <tianfei.zhang@intel.com>
> >
> > This patch adds the description and registration of Feature ID in
> > documentation.
> >
> > Signed-off-by: Tianfei zhang <tianfei.zhang@intel.com>
> > ---
> > Documentation/fpga/dfl.rst | 10 ++++++++++
> > 1 file changed, 10 insertions(+)
> >
> > diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
> > index ef9eec71f6f3..260cac3b7215 100644
> > --- a/Documentation/fpga/dfl.rst
> > +++ b/Documentation/fpga/dfl.rst
> > @@ -502,6 +502,16 @@ Developer only needs to provide a sub feature driv=
er
> with matched feature id.
> > FME Partial Reconfiguration Sub Feature driver (see
> > drivers/fpga/dfl-fme-pr.c) could be a reference.
> >
> > +Individual DFL drivers are bound DFL devices based on Feature Type and
> Feature ID.
> > +The definition of Feature Type and Feature ID can be found:
> > +
> > +https://github.com/OPAE/linux-dfl-feature-id/blob/master/dfl-feature-
> > +ids.rst
> > +
> > +If you want to add a new feature ID for FPGA DFL feature device, you
> > +must use a pull
>=20
> s/you muse use/submit/

Thanks, I will change to:  you must submit a pull request ...

>=20
> > +request to register a feature ID for DFL. Here is the DFL Feature ID R=
egistry:
> > +
> > +https://github.com/OPAE/linux-dfl-feature-id
> > +
> > Location of DFLs on a PCI Device
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > The original method for finding a DFL on a PCI device assumed the
> > start of the
> > --
> > 2.26.2
> >
> >
