Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6D4A569A84
	for <lists+linux-fpga@lfdr.de>; Thu,  7 Jul 2022 08:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234931AbiGGG0s (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 7 Jul 2022 02:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234248AbiGGG0r (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 7 Jul 2022 02:26:47 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10D82A964
        for <linux-fpga@vger.kernel.org>; Wed,  6 Jul 2022 23:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657175205; x=1688711205;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7vBbzUra6U06My/uF++Knazraaj051rPA5ZjI3+1BD8=;
  b=m/LMBkefjVOUlEEsmAJbaiK+HUVc/ykXcige3OYmCaO4UsU1BnI6f07L
   eJhtwR9rFki9loZAZIIOseW/PNCGunh7fxiHGnMu1MW7OXhSKn90ip7CX
   SP+SLG6y3swFFx9gtI10wFyWE0vcDgdxZS8nMCH3dT4w7GDxzdwL07hUh
   gyULYcO0MDOP/wTZoowc7tRC+AR4CH9nqFWN7s4MPWdj8AtTT5Jf6eqKd
   laeO16ce6ipEkCIhSmF0OvNuig2d7mIMPjBLfK9ZVb7ADY3di1Yo/4mwN
   9amh7drlfrsM4DnIKcqSKWcRGzpdhw9W9AiyrAgEJgcrsVfstxx//brQw
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10400"; a="347927472"
X-IronPort-AV: E=Sophos;i="5.92,252,1650956400"; 
   d="scan'208";a="347927472"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 23:26:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,252,1650956400"; 
   d="scan'208";a="661258282"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga004.fm.intel.com with ESMTP; 06 Jul 2022 23:26:44 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 6 Jul 2022 23:26:44 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 6 Jul 2022 23:26:44 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 6 Jul 2022 23:26:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j1+Ia99X8btDBf6DhzF38hIMIvvPTYWMrVfB+6ZoMCEG2cU3mwYo1ws7kYiQ1jJsyGph+7Y0MfoZWjAlF9an+osgT8ZWYzHz+TgnirRPFdwSBna9gjg4v1rD67hJSKjCJDUXrhBQEGStObMjSGrfkymLL37jJeBUzZNOos5T7U7xacLhTltT0jYjXNke8IwFx469yiFFbhKQbXdYy89/MlwGguLjcAlkUZIVKKpaKTlxTpe4C/E+/HOcRGPoqoroz3wPGjQGBfGy+uEYqBq8fP5LErO+oVLFfxT3dzPEFoX6DO2TAg2c+KyoVbJBqWbIvic2hceUoIlfAn4Mb289bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1zGGUmegHljSJkJF6WLvCuSMw3OoxzWRZ5xlI/D/c7k=;
 b=a2ySpbpuKuA0v1K6h8gmpm9ZxaYRmDN+0eaJqLBVPEXxhQcm0qzKNVsEG/j46QXnDpFLZQWdbC4vtXNudMlM621faKOQqyDFODBCEQHyZj5r9vnsDGcCr9S4Lpqf5g9ElX075UNkEPhcOuxhrzf9mMIXRNPgMDJ+MWtxFS8g1FSduS4kPMReR4K97y1h/Zx3ZTx3TSNU+fstVuzZdY5c9Bilky1yqCh6Tv1ZlQvy03A0z7TczLHcsCr2u8xkUtVrS+BsSMg8/bt0ZsJSR7z/JQbcoJfTHtwuSu2qxhi9kAKZL+46to/dUFbiERAHTl1TGKIkT5vPj2p2alDJsNaemg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5483.namprd11.prod.outlook.com (2603:10b6:408:104::10)
 by MWHPR11MB1869.namprd11.prod.outlook.com (2603:10b6:300:108::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.17; Thu, 7 Jul
 2022 06:26:41 +0000
Received: from BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::a113:c892:d94:dd10]) by BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::a113:c892:d94:dd10%7]) with mapi id 15.20.5395.021; Thu, 7 Jul 2022
 06:26:41 +0000
From:   "Zhang, Tianfei" <tianfei.zhang@intel.com>
To:     "Xu, Yilun" <yilun.xu@intel.com>
CC:     "mdf@kernel.org" <mdf@kernel.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "Weight, Russell H" <russell.h.weight@intel.com>,
        "Wu, Hao" <hao.wu@intel.com>, "trix@redhat.com" <trix@redhat.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>
Subject: RE: [PATCH v1 3/3] fpga: m10bmc-sec: add m10bmc_sec_retimer_load
 callback
Thread-Topic: [PATCH v1 3/3] fpga: m10bmc-sec: add m10bmc_sec_retimer_load
 callback
Thread-Index: AQHYkEXl2d25nN1WUkGAW0pMHfa7R61yK4UAgABIKGA=
Date:   Thu, 7 Jul 2022 06:26:41 +0000
Message-ID: <BN9PR11MB5483B990A15BD4FCDE992C2EE3839@BN9PR11MB5483.namprd11.prod.outlook.com>
References: <20220705080058.92532-1-tianfei.zhang@intel.com>
 <20220705080058.92532-4-tianfei.zhang@intel.com>
 <20220707020530.GA3659610@yilunxu-OptiPlex-7050>
In-Reply-To: <20220707020530.GA3659610@yilunxu-OptiPlex-7050>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.6.500.17
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 984bed59-a987-416e-e227-08da5fe1a7e9
x-ms-traffictypediagnostic: MWHPR11MB1869:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h5JndNnFYzzfVnm0sHyz/aImlHVoUxZ6pWKf3E6dQ6DJKHFIjJxUnrwDGuGT2ctgN6RcoJ1oif1zSX86eDTd0e24OfOv9plfdDGXXf6m94Sinx41ube3qn1mxf25OVRM2+HB/0Lm95IHHESHwr2wUmGnKrXzFSzy7sHdoXS9P0RVP6rfCN/9BIosN9bWEKB/cPsvbjkVyXNTr2N15hV3tKSVmFUxQf/Kz6pBJzI4loMd0Ug8ctWYsEUTqAQsoAVm7dS3CRLK2STPWiY585q8GzfN8CsZq9g4D2pDYjfvI2lPuFJQXbdyS0TQXCCtxn67zFvICXYn4juLmw1hxjunCe7gXmrDcjBUZX6y7ZuyZ0SI4bKDzoLEbEKblHE15m0mlTWWVWAfpSIbQxAHY3x8B0dAUEvA+vPCXXIWLavAfPlUsgkjelqCjVHRLv1UuoEwrEwV4G5g61uQg/RZpZ9KtnrTB4q1dqM6eTuFZPJHbDz7N35prNv/V88o7RhxPIDOP7biHax+1lELY/ksTMx7erxecbax6/JqFMs6KBg8SBGFTQXawZvjijsNRK+pahDTwPVA0qGrrKBkViW+u3OHjOo5mOsTmDPjp/WePTSIk0SIkw2pOj36N5XA1CJKSPby2fIjHhMVcBzu4NJKkPNKIcUskue7jDZphi1yRcGDQol3JvCC8AgRKL+2Sw5pB+N7sVO0gxtVAOeuUItVrNQvTG3HTXp9H01Ib8yfEeHOywX5jg2pbeYRWhkFIX2Dy789YXvx2EndaOwiHgLfcj5Xk37/Kih4EbtZjHaor8w53KnXppV+d5D7kBteZS9ApV3f
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5483.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(39860400002)(346002)(366004)(396003)(136003)(2906002)(55016003)(41300700001)(8936002)(38100700002)(6506007)(54906003)(53546011)(6636002)(316002)(7696005)(66476007)(33656002)(71200400001)(66446008)(6862004)(478600001)(64756008)(186003)(52536014)(82960400001)(8676002)(83380400001)(4326008)(38070700005)(86362001)(122000001)(9686003)(5660300002)(66556008)(66946007)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XJzq7nzEcICgKS3HNbT2NjIzM2vKtt1l/ykFt0qjQstYb8XYEqkJOv53zscw?=
 =?us-ascii?Q?CIenGLkL8wbKL4pw3Mtx9Dq8iXwYwtckIHO1Oyo0pJ+hhtRUzfofN2dCaKJ7?=
 =?us-ascii?Q?KGpGZX7DdGFc9PRUNntZKtMSHFv4bG6JGBhsDgZZzYJsUYd7v2gtEwuaPyZT?=
 =?us-ascii?Q?vdWnpsCKIt/1mlHPuhgnpNyGgUm2/YtNt3Gwj6JqHMcz8eNnOqwwN9QaLHfp?=
 =?us-ascii?Q?Pto9jz3Ck78DIdbv+Z4LTXbEDIbRpqznGWRxcavycwDCoewEk38jhG7B5zN7?=
 =?us-ascii?Q?AQKKiGgNC8HGOSIydLZIFVCd6X5DrxJ4WkUMjyDvR0VTAerMnE5qVrScDjhr?=
 =?us-ascii?Q?jh6B50DbhBZbC16Iw90vOPct0y1pSMq32oFqlHfDv9OSut2/KsEYMKI97osv?=
 =?us-ascii?Q?ArgU4WRod1KkQoD1u9DvT8UhbIqZAWAx0/8dltvpEAwfe5C47fY6K3xumAMO?=
 =?us-ascii?Q?A7nukzNRaNBCEgGf1yOj57NJ9QRkGBs2sj1CZx5aGOy+qhTaxBBTYTiURQfU?=
 =?us-ascii?Q?raELtosv/KbtpyjVPBR60VwyyFsnL0TKk/fJaeYeseww8XBM0Pmp0Ru31lWT?=
 =?us-ascii?Q?yltdXMl+dIX2OHkVvAu7hdJbx9L2qtCBNP+uUSuRId8EEj8yVZ141RNjQ1ly?=
 =?us-ascii?Q?rgyS5ASCfer5Af3lKrvPf7SAYTqxzjaG6OxS3FAwNphnvduRYmyC+UXskXrM?=
 =?us-ascii?Q?IPcO69wuMk77qTblmoaak+CXRV/7HFdNHSlcCzm8ECqqhQmFliC/MWiLvz0t?=
 =?us-ascii?Q?hl6pnTSzTKzTnz4IE7cnamKMn0lxrCDu+WCWpWcaI1UlNk0jbqv1UMLXHBN3?=
 =?us-ascii?Q?4nuCe9BKjlVfqGQDLj5haj79tJ9RzjkHrvKN921XAy/F1FNw+m1OPES/lNCX?=
 =?us-ascii?Q?dC8qhG/MqnYPPkg6aexwh0OtodCKF1maFDlHLdSMNfC3uk8Z2wf+w4k5n7a8?=
 =?us-ascii?Q?ufnziwtuyavoQDDdaIYHsiC45TDuKXGBTD0YqQX0cn3+gS3npf8/5Oa1SK3v?=
 =?us-ascii?Q?wMiY4XseyJG9+sRcFL/ldBgnu2d6IdDa9IfDoPd2iBmDvCemYlSeMxJbLKSr?=
 =?us-ascii?Q?wI15hZkJSiIGAi4Besof9L+mfrEsZxnTR4O4M9od1PGv/dyZ74hQ2cXajY2o?=
 =?us-ascii?Q?6JkLrj138IHL8ZeoQ9zfqjm0W1w49eCeJb8eNcNcbFYT6fnYidKuLc59Q7Cz?=
 =?us-ascii?Q?JvXor+KfiDKBD5c02mu2XiRAd6B02DE56yrFGazioKvto25hrjvo87GlJ4fd?=
 =?us-ascii?Q?TvZab3lxuB3YjdPAO5NSf/tSyxpj563SH6WkEfXq8HFYQPELuOEc+9gR3CG4?=
 =?us-ascii?Q?oZf//4g1LcAR0D2bXLCuBPWV3lhEDXntp924LrZUdPsNtjbglLb0/OqciUnh?=
 =?us-ascii?Q?6RYKUFWTvwtzRUMTmW0/nxz7lZL9YwM8haA3wEKcdwnc4d38tdu5Vg4yDBmR?=
 =?us-ascii?Q?KIHRSFN7lC2wqpFq9rc9C/xEHpAnpPLRk/NWcPULMxJ23j47V/Ob2QxpTWlO?=
 =?us-ascii?Q?9bnzhtlUqrywi+qmQ4YBFeOEmiGEhgoeMa39eh+ArDPP1bDkr+UnkCpfvKfV?=
 =?us-ascii?Q?ESfAf/s4FmlZpeKnaozDEmc9OjGKcFFcfiHPJyILdg1SqH2yidansZ1v8ROu?=
 =?us-ascii?Q?q+vU6htLVL7YOhfuEXD7VOwdkpTEj0H5ACdUiejBI6Yu?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5483.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 984bed59-a987-416e-e227-08da5fe1a7e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2022 06:26:41.5593
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q5MPC/Wbqc0RDeaSmo3Lydx+tqZ1XR9J5yFHicxnXRPSpMqgMAeudplCY+thGNyJt7LkIKvMI1uwLEQMkFW8zQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1869
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



> -----Original Message-----
> From: Xu, Yilun <yilun.xu@intel.com>
> Sent: Thursday, July 7, 2022 10:06 AM
> To: Zhang, Tianfei <tianfei.zhang@intel.com>
> Cc: mdf@kernel.org; lee.jones@linaro.org; Weight, Russell H
> <russell.h.weight@intel.com>; Wu, Hao <hao.wu@intel.com>;
> trix@redhat.com; linux-fpga@vger.kernel.org
> Subject: Re: [PATCH v1 3/3] fpga: m10bmc-sec: add m10bmc_sec_retimer_load
> callback
>=20
> On Tue, Jul 05, 2022 at 04:00:58AM -0400, Tianfei Zhang wrote:
> > From: Russ Weight <russell.h.weight@intel.com>
> >
> > Create m10bmc_sec_retimer_load() callback function to provide a
> > trigger to update a new retimer (Intel
> > C827 Ethernet transceiver) firmware on Intel PAC
>=20
> A firmware loader framework is upstreamed recently, does that meet your
> need?

You mean that the firmware loader Russ has submitted? We have used this fir=
mware loader framework to flash the M10 BMC image.
The retimer firmware was contained into M10 BMC image, this patch trigger t=
he retimer firmware reload.

>=20
> Thanks,
> Yilun
>=20
> > N3000 Card.
> >
> > Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> > Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
> > ---
> >  drivers/fpga/intel-m10-bmc-sec-update.c | 146 ++++++++++++++++++++++++
> >  include/linux/mfd/intel-m10-bmc.h       |  31 +++++
> >  2 files changed, 177 insertions(+)
> >
> > diff --git a/drivers/fpga/intel-m10-bmc-sec-update.c
> > b/drivers/fpga/intel-m10-bmc-sec-update.c
> > index 640690e6c131..707dfd8a1931 100644
> > --- a/drivers/fpga/intel-m10-bmc-sec-update.c
> > +++ b/drivers/fpga/intel-m10-bmc-sec-update.c
> > @@ -299,6 +299,148 @@ static int m10bmc_sec_bmc_image_load_1(struct
> m10bmc_sec *sec)
> >  	return m10bmc_sec_bmc_image_load(sec, 1);  }
> >
> > +static int trigger_retimer_eeprom_load(struct m10bmc_sec *sec) {
> > +	struct intel_m10bmc *m10bmc =3D sec->m10bmc;
> > +	unsigned int val;
> > +	int ret;
> > +
> > +	ret =3D m10bmc_sys_update_bits(m10bmc, M10BMC_DOORBELL,
> > +				     DRBL_PKVL_EEPROM_LOAD_SEC,
> > +				     DRBL_PKVL_EEPROM_LOAD_SEC);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/*
> > +	 * If the current NIOS FW supports this retimer update feature, then
> > +	 * it will clear the same PKVL_EEPROM_LOAD bit in 2 seconds.
> Otherwise
> > +	 * the driver needs to clear the PKVL_EEPROM_LOAD bit manually and
> > +	 * return an error code.
> > +	 */
> > +	ret =3D regmap_read_poll_timeout(m10bmc->regmap,
> > +				       M10BMC_SYS_BASE +
> M10BMC_DOORBELL, val,
> > +				       (!(val & DRBL_PKVL_EEPROM_LOAD_SEC)),
> > +				       M10BMC_PKVL_LOAD_INTERVAL_US,
> > +				       M10BMC_PKVL_LOAD_TIMEOUT_US);
> > +	if (ret =3D=3D -ETIMEDOUT) {
> > +		dev_err(sec->dev, "PKVL_EEPROM_LOAD clear timedout\n");
> > +		m10bmc_sys_update_bits(m10bmc, M10BMC_DOORBELL,
> > +				       DRBL_PKVL_EEPROM_LOAD_SEC, 0);
> > +		ret =3D -ENODEV;
> > +	} else if (ret) {
> > +		dev_err(sec->dev, "poll EEPROM_LOAD error %d\n", ret);
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +static int poll_retimer_eeprom_load_done(struct m10bmc_sec *sec) {
> > +	struct intel_m10bmc *m10bmc =3D sec->m10bmc;
> > +	unsigned int doorbell;
> > +	int ret;
> > +
> > +	/*
> > +	 * RSU_STAT_PKVL_REJECT indicates that the current image is
> > +	 * already programmed. RSU_PROG_PKVL_PROM_DONE that the
> firmware
> > +	 * update process has finished, but does not necessarily indicate
> > +	 * a successful update.
> > +	 */
> > +	ret =3D regmap_read_poll_timeout(m10bmc->regmap,
> > +				       M10BMC_SYS_BASE +
> M10BMC_DOORBELL,
> > +				       doorbell,
> > +				       ((rsu_prog(doorbell) =3D=3D
> > +					 RSU_PROG_PKVL_PROM_DONE) ||
> > +					(rsu_stat(doorbell) =3D=3D
> > +					 RSU_STAT_PKVL_REJECT)),
> > +				       M10BMC_PKVL_PRELOAD_INTERVAL_US,
> > +				       M10BMC_PKVL_PRELOAD_TIMEOUT_US);
> > +	if (ret) {
> > +		if (ret =3D=3D -ETIMEDOUT)
> > +			dev_err(sec->dev,
> > +				"Doorbell check timedout: 0x%08x\n",
> doorbell);
> > +		else
> > +			dev_err(sec->dev, "poll Doorbell error\n");
> > +		return ret;
> > +	}
> > +
> > +	if (rsu_stat(doorbell) =3D=3D RSU_STAT_PKVL_REJECT) {
> > +		dev_err(sec->dev, "duplicate image rejected\n");
> > +		return -ECANCELED;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int poll_retimer_preload_done(struct m10bmc_sec *sec) {
> > +	struct intel_m10bmc *m10bmc =3D sec->m10bmc;
> > +	unsigned int val;
> > +	int ret;
> > +
> > +	/*
> > +	 * Wait for the updated firmware to be loaded by the PKVL device
> > +	 * and confirm that the updated firmware is operational
> > +	 */
> > +	ret =3D regmap_read_poll_timeout(m10bmc->regmap,
> > +				       M10BMC_SYS_BASE +
> M10BMC_PKVL_POLL_CTRL, val,
> > +				       ((val & M10BMC_PKVL_PRELOAD) =3D=3D
> M10BMC_PKVL_PRELOAD),
> > +				       M10BMC_PKVL_PRELOAD_INTERVAL_US,
> > +				       M10BMC_PKVL_PRELOAD_TIMEOUT_US);
> > +	if (ret) {
> > +		dev_err(sec->dev, "poll M10BMC_PKVL_PRELOAD error %d\n",
> ret);
> > +		return ret;
> > +	}
> > +
> > +	if ((val & M10BMC_PKVL_UPG_STATUS_MASK) !=3D
> M10BMC_PKVL_UPG_STATUS_GOOD) {
> > +		dev_err(sec->dev, "error detected during upgrade\n");
> > +		return -EIO;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int retimer_check_idle(struct m10bmc_sec *sec) {
> > +	u32 doorbell;
> > +	int ret;
> > +
> > +	ret =3D m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL,
> &doorbell);
> > +	if (ret)
> > +		return -EIO;
> > +
> > +	if (rsu_prog(doorbell) !=3D RSU_PROG_IDLE &&
> > +	    rsu_prog(doorbell) !=3D RSU_PROG_RSU_DONE &&
> > +	    rsu_prog(doorbell) !=3D RSU_PROG_PKVL_PROM_DONE) {
> > +		log_error_regs(sec, doorbell);
> > +		return -EBUSY;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int m10bmc_sec_retimer_eeprom_load(struct m10bmc_sec *sec) {
> > +	int ret;
> > +
> > +	ret =3D retimer_check_idle(sec);
> > +	if (ret)
> > +		goto exit;
> > +
> > +	ret =3D trigger_retimer_eeprom_load(sec);
> > +	if (ret)
> > +		goto exit;
> > +
> > +	ret =3D poll_retimer_eeprom_load_done(sec);
> > +	if (ret)
> > +		goto exit;
> > +
> > +	ret =3D poll_retimer_preload_done(sec);
> > +
> > +exit:
> > +	return ret;
> > +}
> > +
> >  static struct image_load m10bmc_image_load_hndlrs[] =3D {
> >  	{
> >  		.name =3D "bmc_factory",
> > @@ -308,6 +450,10 @@ static struct image_load
> m10bmc_image_load_hndlrs[] =3D {
> >  		.name =3D "bmc_user",
> >  		.load_image =3D m10bmc_sec_bmc_image_load_0,
> >  	},
> > +	{
> > +		.name =3D "retimer_fw",
> > +		.load_image =3D m10bmc_sec_retimer_eeprom_load,
> > +	},
> >  	{}
> >  };
> >
> > diff --git a/include/linux/mfd/intel-m10-bmc.h
> > b/include/linux/mfd/intel-m10-bmc.h
> > index 8e434886a5a1..23025e4d2779 100644
> > --- a/include/linux/mfd/intel-m10-bmc.h
> > +++ b/include/linux/mfd/intel-m10-bmc.h
> > @@ -36,6 +36,37 @@
> >  #define M10BMC_VER_PCB_INFO_MSK		GENMASK(31, 24)
> >  #define M10BMC_VER_LEGACY_INVALID	0xffffffff
> >
> > +/* Retimer related registers, in system register region */
> > +#define M10BMC_PKVL_POLL_CTRL		0x80
> > +#define M10BMC_PKVL_A_PRELOAD		BIT(16)
> > +#define M10BMC_PKVL_A_PRELOAD_TO	BIT(17)
> > +#define M10BMC_PKVL_A_DATA_TOO_BIG	BIT(18)
> > +#define M10BMC_PKVL_A_HDR_CKSUM	BIT(20)
> > +#define M10BMC_PKVL_B_PRELOAD		BIT(24)
> > +#define M10BMC_PKVL_B_PRELOAD_TO	BIT(25)
> > +#define M10BMC_PKVL_B_DATA_TOO_BIG	BIT(26)
> > +#define M10BMC_PKVL_B_HDR_CKSUM	BIT(28)
> > +
> > +#define M10BMC_PKVL_PRELOAD		(M10BMC_PKVL_A_PRELOAD |
> M10BMC_PKVL_B_PRELOAD)
> > +#define M10BMC_PKVL_PRELOAD_TIMEOUT
> 	(M10BMC_PKVL_A_PRELOAD_TO | \
> > +					 M10BMC_PKVL_B_PRELOAD_TO)
> > +#define M10BMC_PKVL_DATA_TOO_BIG
> 	(M10BMC_PKVL_A_DATA_TOO_BIG | \
> > +					 M10BMC_PKVL_B_DATA_TOO_BIG)
> > +#define M10BMC_PKVL_HDR_CHECKSUM
> 	(M10BMC_PKVL_A_HDR_CKSUM | \
> > +					 M10BMC_PKVL_B_HDR_CKSUM)
> > +
> > +#define M10BMC_PKVL_UPG_STATUS_MASK	(M10BMC_PKVL_PRELOAD |
> M10BMC_PKVL_PRELOAD_TIMEOUT |\
> > +					 M10BMC_PKVL_DATA_TOO_BIG |
> M10BMC_PKVL_HDR_CHECKSUM)
> > +#define M10BMC_PKVL_UPG_STATUS_GOOD	(M10BMC_PKVL_PRELOAD |
> M10BMC_PKVL_HDR_CHECKSUM)
> > +
> > +/* interval 100ms and timeout 2s */
> > +#define M10BMC_PKVL_LOAD_INTERVAL_US	(100 * 1000)
> > +#define M10BMC_PKVL_LOAD_TIMEOUT_US	(2 * 1000 * 1000)
> > +
> > +/* interval 100ms and timeout 30s */
> > +#define M10BMC_PKVL_PRELOAD_INTERVAL_US	(100 * 1000)
> > +#define M10BMC_PKVL_PRELOAD_TIMEOUT_US	(30 * 1000 * 1000)
> > +
> >  /* Secure update doorbell register, in system register region */
> >  #define M10BMC_DOORBELL			0x400
> >
> > --
> > 2.26.2
