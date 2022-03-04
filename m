Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE6B04CD069
	for <lists+linux-fpga@lfdr.de>; Fri,  4 Mar 2022 09:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbiCDIpj (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 4 Mar 2022 03:45:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbiCDIpi (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 4 Mar 2022 03:45:38 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA92D527F3
        for <linux-fpga@vger.kernel.org>; Fri,  4 Mar 2022 00:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646383490; x=1677919490;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fGRTzGlLoPLi+Y770irppSsVbaArActvVNY5OTxFz+0=;
  b=Ze8jp3hTl2hyCCUidUmlQIpHXX1bpSpZTJzHwMSgg7xIy/6Av2Z22Sed
   0aaiZr9C8zm6tv9VIuSF+13mzZLnoUaqAkjcvUUoDJ19LMB0rV+WDeRIG
   08bZUIUw9JDvKkJD7jCZbARTqMRRWNVnSuu6StktZHLmFIbdiuHg7HDxx
   Bedd/diwHSVYvEV1cL9ybpWC7EBQCxr5nKcvXU/gDZ9IJkBq+8up3ovBZ
   tzglfEqrov3uQ4fG+xghQ2j4BpypdXzq4oJAeGYrx1HjAnDqRwwSmeIOz
   33CW8AWOVzMH8zYyinmtRMKIrZEwR+MLhntR9s+epBjS1RymLs6eCCxhf
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10275"; a="253660782"
X-IronPort-AV: E=Sophos;i="5.90,154,1643702400"; 
   d="scan'208";a="253660782"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2022 00:44:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,154,1643702400"; 
   d="scan'208";a="642445020"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga004.jf.intel.com with ESMTP; 04 Mar 2022 00:44:47 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 4 Mar 2022 00:44:47 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Fri, 4 Mar 2022 00:44:47 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.109)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Fri, 4 Mar 2022 00:44:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VE/AuAbiX3CuAOir5lefl4v9hpeDzVFq9+LHjzIgnrZrHFNRMiQPC3ng7D1Mxh7JpfIH70pJOMUpCRjfIlQpiN4AJXFJIqRqFpKUiA9yiHN++epOaAgo9lPzRXYUZZhFkrKjL7Sb3RZp/W/HTC3BJje4NxBlRJ42oEipF160DrgIW0qayWuAYFajqHpfJPSKBljQPKvBGSsNGUKiwOWuNdMBXo+jFJ5svL59dyKtvz96Le2mjSfMqzwqmOg3w2j73Efe6NN81hBkn9lOQRZksqx4N1+8q8pPBH/tGClCx78W61NjIVKRfJqjG3/LDrX0iC3wCVLoFl1+qbDmySk8EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wWRU7OIKYEKKuFWN1nnRhuOOAeZpM0yJri61p6l2Juo=;
 b=IKw/HJknodjt4k6FCqiZrUhuaNkdrNGpHRkKqgNdyPSOVOLsmjXwuwtnCqFq8hHJcuymvkgyGykSaY9S1G3CkFaH0CAl8hrvYA6cwl7HQZVo+MyAwFw9ZvU5vVoM2Sy+IKXneR1y4YxMKoESAdRaugC8+8c41w+QhfovUc6aDDqeoXzf/Cvp1rQuoIpUg0kzkVw66t5F8rBEYd3j2GgjbYbDucuPoFXf4wLKLb+C9uOthAYeQYHysZWzQAnOuZhcsCfw2rx838vuy19Yu9wxT//KQoNtX64FGJNEXAfE0h7ruk3zg6bGp/xkkO7fHwUtm0/sRdG1njw3kcTYLVB1WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5735.namprd11.prod.outlook.com (2603:10b6:8:10::7) by
 BN6PR11MB1891.namprd11.prod.outlook.com (2603:10b6:404:107::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.15; Fri, 4 Mar
 2022 08:44:44 +0000
Received: from DM8PR11MB5735.namprd11.prod.outlook.com
 ([fe80::948:c1e4:4f45:e53f]) by DM8PR11MB5735.namprd11.prod.outlook.com
 ([fe80::948:c1e4:4f45:e53f%5]) with mapi id 15.20.5038.016; Fri, 4 Mar 2022
 08:44:44 +0000
From:   "Ang, Tien Sung" <tien.sung.ang@intel.com>
To:     "Wu, Hao" <hao.wu@intel.com>, "Xu, Yilun" <yilun.xu@intel.com>
CC:     Moritz Fischer <mdf@kernel.org>, Tom Rix <trix@redhat.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>
Subject: RE: [PATCH] fpga: altera-cvp: Increase the credit timeout
Thread-Topic: [PATCH] fpga: altera-cvp: Increase the credit timeout
Thread-Index: AQHYJunzc0vqy726LUioVAKtQqjR3KykdDqAgARQMwCABjQlgA==
Date:   Fri, 4 Mar 2022 08:44:44 +0000
Message-ID: <DM8PR11MB5735394B66899E6244C99AA6BE059@DM8PR11MB5735.namprd11.prod.outlook.com>
References: <20220221141127.3765-1-tien.sung.ang@intel.com>
 <20220225160203.GA1377773@yilunxu-OptiPlex-7050>
 <DM6PR11MB381994DFABA2C0F1FC4E236A85019@DM6PR11MB3819.namprd11.prod.outlook.com>
In-Reply-To: <DM6PR11MB381994DFABA2C0F1FC4E236A85019@DM6PR11MB3819.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0971b3c7-3e6a-49bc-7b18-08d9fdbb3b42
x-ms-traffictypediagnostic: BN6PR11MB1891:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BN6PR11MB18918F92F9726FCA4282188BBE059@BN6PR11MB1891.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wD0HPnJvj8Ww2dxTn1ZBzHrPnnyGKuMlTYO/QB1m5CXVnRd8uSEMqgSw6Ukau0O5GzCmdeXaYhGZvFsZBWvtZg7zBfiKIkdFf/LOEaVL0jOrLk/wxJDoxf90d3m1+8y2ypmObTE/balQwkOrHG6TOfgubUYwNb4AzE0LFQDwYznDhwzOZjHYH7PwTOpiAaLRrEpEP66SdOJsDogi9x3bMBFIs6uJun9CgTCiRnwXZ8dSQjkkSxW5UetvtwdYynM2YMtd2lez9fazdE/sKsFFvtWOGNpRe0LrckTjMO1YuR+y13t+GRfxmfHcBh6j2wLysdbY7OrnpBny6Ps5rQ1HWoNDlqVmqrlIXcw1G7dyeEhjunBbqImX9oM48KKBUdkiH93R7rJNHyTjMceiZgAGeX/lqQeodVYyxzZL5ckF/Kje2ixDQxEMxw9d792eZi9ox4PsX3ImwZbRK90EbTJZkL/UHdCi/p45IASTs9RhYaS++NH22s2v3kW7i3hDy5ljno1WVo23yJqwOK0D8lldEnDRnaisUJshPk1rK07uWT6STSxVAje+AwbH4SuJyJqjagaSkzoZRuj36iGKgz10Nl6RQ1Pw0BJMtjLvkEwwT/SBadh4/FfpTXpXtsYdOfbkN3HDKeZC1RZpSpwCRp9CKQoHd8A//6av0BXkKbiOq62TmT8mGJ0XoTRxbl6bsYwchDnGHUN8OimPCOeARxPdMA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5735.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(83380400001)(5660300002)(54906003)(6636002)(53546011)(26005)(6506007)(186003)(52536014)(8936002)(7696005)(55016003)(9686003)(66556008)(66476007)(66446008)(71200400001)(316002)(122000001)(82960400001)(64756008)(86362001)(33656002)(508600001)(38100700002)(38070700005)(66946007)(76116006)(8676002)(4326008)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?o4+xThVK2mb9Jit8vv1XnzmvZp19Prw8KZ9IqCU98Y2/uMNqZqnCmymSQmsO?=
 =?us-ascii?Q?w5IaWmdZyoy7kSpwERU5gyb1mmyFQDl0BRvIRgZ0ezgD8PLanvM5Kzd2Jz5f?=
 =?us-ascii?Q?el+2iV/TCFt0DAyhv56UArG5HpXXc12WF6eb5hbsuCrJzUR0pE5OUkPXJgTf?=
 =?us-ascii?Q?uXKZyCfNwyETK+D7CkcAkJOuKqZLSZl3sj8tFccbpL9dtaXsoFemTuH1gyGw?=
 =?us-ascii?Q?gNaN5Mt6LY2b0pTEWccXJ62ZIWTQSn5e2BKr1/8oe/u7msVu7Z1fWCVafrbA?=
 =?us-ascii?Q?MB5Y8Y85kryL3ewl0CSSCeeB24Lkda4rCuDTkhHZc4fTw2YTM1KJDMViHhr3?=
 =?us-ascii?Q?xh/SAP+gbUt3CsKPDw/MthitWzQVC3IAkRzmT8Q+jHHULSRiIylFf4WmVPre?=
 =?us-ascii?Q?xUPhWVXgK9gbtzdW90iaGrylUm/d1Eyumk4PYvSfTCiT4lGlUHl9AVebvwA+?=
 =?us-ascii?Q?kggeaEM5rEkVx9DInyK2UVWWB3SsFSTRYHjCJ0KFgy2TButz97jl40fKeDBB?=
 =?us-ascii?Q?Mrbap7oaExAUVGauP+gCOXMVb2jfHh0Zu2PMQ7NdB8ujIztHn+LZQWx0Hl5y?=
 =?us-ascii?Q?99H5N20ynpsoF20YNpaITkoaGIwOFdhxjtWzN7Ulu1MEXQawBaRatns6uY6D?=
 =?us-ascii?Q?sw11hFG1uTcH8wVxPy5GBdkSvFAhoPVjN2oCQesoyL8a8ajjhX91ycUBnreT?=
 =?us-ascii?Q?Cyda7b6bP60aWq4WndroVdavsiXinUheaP2eMLv5p14pKWiO8be7qJy+iLhb?=
 =?us-ascii?Q?Ipv76Ms/v2itmmgGUnuCGQqAUcsAHwTa7frSi1ax4WxPmVcjXqNaskb0V2BN?=
 =?us-ascii?Q?Lloy1sYt/s7lt9en6OyWwjcZmIz8w5uHnN8aEEMuVn048jNh1ULJFeUf5Y07?=
 =?us-ascii?Q?PouVBJ0vumeSCMRE9BjE+YKOpr+ehcUY+wNlx1JT54eXkst2Ei/RV9GSKNhk?=
 =?us-ascii?Q?q0zMUmUU5MaV6RpSqqubcbBl9AhAbFu/L4I9ADjRWo5mXC7kgjL+QKmomVDx?=
 =?us-ascii?Q?IQUidUHLmHUtr8Mu54gE96VByuyvA3sTNPQVMRKQNwveaHLOwXv4wCyXkVeJ?=
 =?us-ascii?Q?IVLuCMzFhaL/qqhhNASqpDFfg3trQQq312bYUWoEmWiIKWB4t2BUNSJUZGan?=
 =?us-ascii?Q?SNVRlBDbccdERXqwt+LaQbl2oG5V814/XTg6whyUwmTlW5Gl24GF7gDx+Y2r?=
 =?us-ascii?Q?jGqKrMQ0mcmqZVE3Mq2Aar9w0w54dEdd2rdh3+ns8umOt2V+Y/AYJ/bodDlg?=
 =?us-ascii?Q?qAdFGN4JDwaontExiu83qncAyyZditDJlTSvvg3CC1xQS9EZ7fluKBnOitSu?=
 =?us-ascii?Q?VpVoE0ca8iWLSW844owlSJxYrGiRodKpROb4bHITGn0helmVmGpI2ucvkxf3?=
 =?us-ascii?Q?hCblhZurjkCTvf6uRqHd0bgpsA+ESHezsUSSmCi1poGWBwh7P9sPeB1efQXv?=
 =?us-ascii?Q?J/cNgSXbSH3N9UAOl8VqymRCoIL+LiGssyvwuUfHPyJ18LJcT3Fpk8pybRfr?=
 =?us-ascii?Q?l6avz2pQGnRQU79cKTLsI84XC8AFoRh9Cb6rCjeCZMRO2lxRx3AeZxTtATO+?=
 =?us-ascii?Q?l1gEw9qyZ/VvZLVxk342L+9oKi+hMRpslkcq94mAVn90YcwMSA953lWXUXUt?=
 =?us-ascii?Q?GWosIknNSscWwfWsxDQ6Qmk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5735.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0971b3c7-3e6a-49bc-7b18-08d9fdbb3b42
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2022 08:44:44.3466
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1beBHpSvmU0rIjmg4sMJtXQWYuamiieSOpNZa0KQCF8ncuTbBQbjWILmlrZQXrlobt3eFXr1Nwibn8jwsaVc0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1891
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Hao,

We have tested the 40ms change with 500 loops and deem this satisfying
based on the recommendations by the Intel FPGA SDM HW team.
SDM was expected to respond within  a maximum time of 20ms +-error margin.=
=20
However, there were cases this weren't the case during tests.=20
After many rounds of tests, they conclude that 40ms is doable.=20
And, this is  double the previous time-out of 20ms.=20
There is a bigger margin added this time.=20
Overall, we don't intend to increase the time-out any further.=20
Thanks
Tien Sung

-----Original Message-----
From: Wu, Hao <hao.wu@intel.com>=20
Sent: Monday, 28 February, 2022 5:54 PM
To: Xu, Yilun <yilun.xu@intel.com>; Ang, Tien Sung <tien.sung.ang@intel.com=
>
Cc: Moritz Fischer <mdf@kernel.org>; Tom Rix <trix@redhat.com>; linux-fpga@=
vger.kernel.org
Subject: RE: [PATCH] fpga: altera-cvp: Increase the credit timeout

> Subject: Re: [PATCH] fpga: altera-cvp: Increase the credit timeout
>=20
> On Mon, Feb 21, 2022 at 10:11:27PM +0800, tien.sung.ang@intel.com wrote:
> > From: Ang Tien Sung <tien.sung.ang@intel.com>
> >
> > Increase the timeout for SDM (Secure device manager) data credits=20
> > from 20ms to 40ms. Internal stress tests running at 500 loops failed=20
> > with the current timeout of 20ms. At the start of a FPGA=20
> > configuration, the CVP host driver reads the transmit credits from=20
> > SDM. It then sends bitstream FPGA data to SDM based on the total=20
> > credits. Each credit allows the CVP host driver to send 4kBytes of=20
> > data. There are situations whereby, the SDM did not respond in time dur=
ing testing.

Why this timeout is changed to 40ms not 50ms or 60ms?
What's the time we expected from SDM?
I hope we don't need to change this again.

Thanks
Hao

> >
> > Signed-off-by: Ang Tien Sung <tien.sung.ang@intel.com>
> > ---
> >  drivers/fpga/altera-cvp.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c=20
> > index 4ffb9da537d8..5295ff90482b 100644
> > --- a/drivers/fpga/altera-cvp.c
> > +++ b/drivers/fpga/altera-cvp.c
> > @@ -52,7 +52,7 @@
> >  /* V2 Defines */
> >  #define VSE_CVP_TX_CREDITS		0x49	/* 8bit */
> >
> > -#define V2_CREDIT_TIMEOUT_US		20000
> > +#define V2_CREDIT_TIMEOUT_US		40000
> >  #define V2_CHECK_CREDIT_US		10
> >  #define V2_POLL_TIMEOUT_US		1000000
> >  #define V2_USER_TIMEOUT_US		500000
>=20
> Acked-by: Xu Yilun <yilun.xu@intel.com>
>=20
> > --
> > 2.25.1
