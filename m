Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95F9B55293B
	for <lists+linux-fpga@lfdr.de>; Tue, 21 Jun 2022 04:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245293AbiFUCF2 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 20 Jun 2022 22:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235637AbiFUCF1 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 20 Jun 2022 22:05:27 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91DBF15FD5;
        Mon, 20 Jun 2022 19:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655777126; x=1687313126;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qOKhlP7BAqQsgm+YBT83Ieabq3gpM2a/MMl+VD+2aQ8=;
  b=XHTcg0NnNWxHwk1oYeelI3BhbGVpyCaY58cqzEWRIg3sIw8XPRgLa2dh
   snLWR4qsD1oAWB/8duu8DWb4GC3sP45+SieGxOO0i0tfg+bLnCbERZhEH
   B+Owf0UOhF4b0cAnVpEimK7jLgD2cnAyNp89mBIZCsHMGWbRNNznVQuC2
   /TEUOmLa4rjCJBo8QrntFXCBOIejErwufX4ouee4eOtQVB7w61dNgjFsg
   Jgfy1j6zHDVSQzFBQzRGJKwqYDPsYdgYeJifwAw8mZqvR+vTgrTPNXSy1
   yq96d5xT8m1ogilVSvVFdCRz4w/MD1UiJJTOEvcPvgzPX7kmeLXjIvMP2
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10384"; a="268724801"
X-IronPort-AV: E=Sophos;i="5.92,207,1650956400"; 
   d="scan'208";a="268724801"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 19:05:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,207,1650956400"; 
   d="scan'208";a="654926804"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP; 20 Jun 2022 19:05:25 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 20 Jun 2022 19:05:25 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 20 Jun 2022 19:05:24 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 20 Jun 2022 19:05:24 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.42) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 20 Jun 2022 19:05:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mrwxESjXJAeVnWSX53EEfxgZNQ5MPLSEhavPltBNFnKSE+LyojGFZ12sEGczqOpR9Nm4fY8lPItu4YSldEs1NRbZTGeDNqUaN5Hd4lz+jtzXCdaFjjDwE0mPAWhnaUmxFp7o8rfkBgJxICB9xgfWoTVbWrUcRrbb13kRqAB/Ws4MSfr0iPEizf/cUmNAaCmGEZiaALd8WskEqlsrkzf7bvXmFL91VVhKXmKpcKlC+0gh+I9MRhtWuX+Hd9bAoCq8ElRSuRRN7Wtkp/axWvPNXxoHVFA4Y67g8ewC+GGtdIM/yLc5fa2zPiV3EZr7rPkIISrezre1diA9giWJcFohRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MgzznvKvLpesU+MPI9CL09m+Mseecx1F0zw6WhQ89Ns=;
 b=nuQut/PrR6rn9m8xmSCXHHNKalj/mjuCPF5N78c7EFRTMubyd84XiQzSmD2OWqHETd0q64b4oQJ5YjHJIl+RouzCII6ZSRIAtgh1L91JQpoPSEQpuj1H5feK6IRt8B7U02br9CAY0ZCmTUCI6qiRxO27fO3upDQigSLtfaTCF1qHgDtG4lGfSgSSqVwjHQcSRmAGH8klHgWkEmuWFKhu5n2/zlD00U0GqLTHVcepi3wsvmpdFHAB70UHr5tOBihj3cZy9xRYPHVTgyX6AZmaNvN8ooAIj4vGZK62PXL3PcfMsem4e7xLhLeosC6AXPWwkaORKw0X9A2Sv39dq6+TNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5483.namprd11.prod.outlook.com (2603:10b6:408:104::10)
 by PH0PR11MB5061.namprd11.prod.outlook.com (2603:10b6:510:3c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.18; Tue, 21 Jun
 2022 02:05:22 +0000
Received: from BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::a113:c892:d94:dd10]) by BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::a113:c892:d94:dd10%7]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 02:05:22 +0000
From:   "Zhang, Tianfei" <tianfei.zhang@intel.com>
To:     "Xu, Yilun" <yilun.xu@intel.com>
CC:     "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "Wu, Hao" <hao.wu@intel.com>, "trix@redhat.com" <trix@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "Weight, Russell H" <russell.h.weight@intel.com>,
        "matthew.gerlach@linux.intel.com" <matthew.gerlach@linux.intel.com>
Subject: RE: [PATCH v2 4/4] mfd: intel-m10-bmc: support multiple register
 layouts
Thread-Topic: [PATCH v2 4/4] mfd: intel-m10-bmc: support multiple register
 layouts
Thread-Index: AQHYge8UJIM6KFNt7kqviVQUxyhnm61YXZeAgADDbHA=
Date:   Tue, 21 Jun 2022 02:05:22 +0000
Message-ID: <BN9PR11MB54830DB2418CA5321F489C19E3B39@BN9PR11MB5483.namprd11.prod.outlook.com>
References: <20220617020405.128352-1-tianfei.zhang@intel.com>
 <20220617020405.128352-5-tianfei.zhang@intel.com>
 <20220620141919.GA1417169@yilunxu-OptiPlex-7050>
In-Reply-To: <20220620141919.GA1417169@yilunxu-OptiPlex-7050>
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
x-ms-office365-filtering-correlation-id: 12950eb1-51ad-4fc9-2064-08da532a7fe8
x-ms-traffictypediagnostic: PH0PR11MB5061:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <PH0PR11MB5061A0C3217C81724B51AC3DE3B39@PH0PR11MB5061.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CIunoWc3qrQ0U3NCGSifYZyxddWlEAKw0Vlr2jC9AmeZpYIbm3DltoKPeItNwg7slwTnrPFkmZxcS3BJv2PMfzD3UPkJaGxn11nFMahEN2mlKalj7z/G115zE0/m4l145p2immFmpqiQAxCnfN9KKP79mkuzMDntUW/rIhkag4jeNAmLEN0JXd7paMtf0AA4+WQZgsqg8+IyVMC6XLgT79NsfdvmTe4BrmdFhmuDXcM2FlaXsEJfcZCBe3ciYYCrRce6ApDlXBHwAuLIQdTaSL88DdVZUs9D9NbpFG3EEw6MWfIfKI0AMmuu6evO9Dp2Iv8o42W2wSf2lgB59Q8wQGl6UvT37GolsIUKsOnmd9xYp23zDPWk1s0YANHjRRiLFTcAYTOSOJs5mZd3IO1aNg7lACt8EzWo2eAQqA0cQNXdm8DrF58qpa/i35Spv1A3AUAa0ggInOCzQ0wwIBSY5Z/bxv6l1HNK6UFpdD/dV3C0j/xfTBTJhdC9HhI1Jy48bPsyWU/rLxpqguDfLCoYObUNhOH2nJFx0Rfzc+6XaprIVcZo45XUadZWNkP3PiWhXnVs12ULMls4BUcuAJZqUy9alI+TuPnxxqysn/T7N/jzIDx9p9ULiaxkaVo1UWIZShTDOJk3qxx/ppvHW7i2CUoXq3+Bo5IXMpefHVWy9iNX5WFKE6kqqP10Mp5WpKv/tC/pVQ5q3FOvzLTS773V6A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5483.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(376002)(346002)(39860400002)(136003)(71200400001)(186003)(64756008)(478600001)(76116006)(33656002)(66556008)(66446008)(66476007)(5660300002)(6506007)(8676002)(316002)(66946007)(53546011)(52536014)(83380400001)(6862004)(7696005)(122000001)(4326008)(41300700001)(82960400001)(2906002)(38100700002)(8936002)(86362001)(9686003)(55016003)(6636002)(54906003)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jP96JacSJ63RdwsfE7CEv+vudt7L1NYCo/NY8ZP6v62GCLxC7BM/W1H48VDZ?=
 =?us-ascii?Q?Bas3Sb5MBQLdU0Cs4vDaMOCyiKXlg2+AkV+8TE6BCYsPSklI3m95pASViKXr?=
 =?us-ascii?Q?pCnIOrJ8qKINQlM8rnbHz6aUKF38+Q9iJIl2cWfX8E9YeBgr9fqOUUFyZklz?=
 =?us-ascii?Q?ok0ltcA1kCaJrQ6w8/nulCFqADkXJgRjxpUB76vShUMQ2oiuMSTXG2mhIxHg?=
 =?us-ascii?Q?/gFDukV9sC/Q5Hq8sUrhWt7O23HmO7DGPtiK+WqaltuUaOHQ+ayr2WkB0bk0?=
 =?us-ascii?Q?eY9y7XKnE4yAgD6gfnP2osGAsJ2ShYs7Sk+sKZWnH7CwIBY4iPw+MhDtLoL6?=
 =?us-ascii?Q?9ZUZZwJ00atWFmLmvnSGkBrThsvjPEsaZXGFnv7lr9MRvzpv4dV6yWW/X/w6?=
 =?us-ascii?Q?RKdWL1dTRlvcDrXTL/MxAM1xYyLRX1JKRjOehYXqKX4xILbjKWmZMy3MgXCq?=
 =?us-ascii?Q?R8r5BqCFpLyf/+JiMahfMerrcXTAZQ53aEWENkuHyps899wKlprOymlyIMh7?=
 =?us-ascii?Q?XuomCdiZjHKqWYZU3F2LQh+mGUTuqgARBUJiqFNu4Q67hwU8thj89VizCxG3?=
 =?us-ascii?Q?7YfyRJFU+51NaMeRnBamnw1cDfnSU3Bjd0QTVZinktj5ibkOy2i+x0XkR5oY?=
 =?us-ascii?Q?0+4Fr3AzbSKNQ7C+eLK3m1jaJLKkPGnRLzgAayIxlEAsMaxc0t55q6D2T7Ho?=
 =?us-ascii?Q?GK5GSWllDYw9ZSDqTAh9KJIu65+yWglruQfaD/SM9cC67aE4vVc8m14ZjrY7?=
 =?us-ascii?Q?SfZ1n0RogI7TMlJeUUZcvQo6Dtbpj5OP+K7GRGH6Ok8NjNZms00U9XLbG+sF?=
 =?us-ascii?Q?bWcLhk5Zrgu+7FnkwlAjYATfpI1bSgzpy0zwIr/0Ts8i/ywBw71ukA5OTmX3?=
 =?us-ascii?Q?k/hSSsPnpjxG6Fc7BQoimv9KkBfAylZsbEjJiJuxD9Hju7/KPD3CkpTrUHK1?=
 =?us-ascii?Q?iJ1uAlPT/JjRvEUzu3xJuWceQ84DxwtBervmdytpwLG3BIT0PEnFz3SgX+EA?=
 =?us-ascii?Q?6Wz6a1tmGxetP6zejil+ZZGhZdQxznaAbUiLJ4q+KE8r4BMR8BqjCEIq8CjG?=
 =?us-ascii?Q?J6+sNh2BLehEbTAwfd+isTRQygzz6IWO+jDd9RVVJaSkNlZ7EYmYt1IDIXtI?=
 =?us-ascii?Q?SvBu5AENi7d948DG+2rNyZIdg4CPscxrg2rJ+FJllyf5haCBHCbuzdskG8Q6?=
 =?us-ascii?Q?ycqyIrlMhs/sLPIf5SvfLVS7GvyQeVP8Pb6qtsVIIyt3eeUWkUOectd8eYdc?=
 =?us-ascii?Q?IX/HuoSU9/y6eSMip/83AWsj8sMQEbRYct2x8Sobjq46VGDqH2omkVIW61/d?=
 =?us-ascii?Q?ZDbsbs6zuwBulTiey/P40NCD4YGa44wKoXNM1lX/PIs/mKPoRSQC18SZWArT?=
 =?us-ascii?Q?HwduezdOv2oRDb5pkfcZpSu4Fw6t03zsvVBOrglkGHx1voU70YqM4TDLOhSk?=
 =?us-ascii?Q?vDkfhpoYDFeJOy/YkPBrFyUdjn8qpzyRY7+9XH4NxCh7XXpQZGuDkVr2lcpi?=
 =?us-ascii?Q?IjpL58qAc+2jizyutllW2QFzdnWpoozKr++sUJCObdVMzuyLhGW9eSKGbl4j?=
 =?us-ascii?Q?9Qe7EUAvI2xMEWuq1u08VKyoxdq2Pe0uUF3ixD320kg4PYduYHkUZ8GbkzbD?=
 =?us-ascii?Q?FI79Ni5HLU72QITl9oqwIalTtLWgz24e+ZmwUZ0kPRxBggwJ5nmztZffYf5f?=
 =?us-ascii?Q?xpeFhK9lRAP2AQZ84KquPzb2+VVKtTGJYGOyNwl1Xj/ZIReQ1LIK5MdPXynx?=
 =?us-ascii?Q?HQm8AtuqjdJzEIGtlSIB6k6aX5CMMlykzDsk6bWdHNZo/zssM+n6m41HCYIJ?=
x-ms-exchange-antispam-messagedata-1: GTrEcumKrlnyJQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5483.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12950eb1-51ad-4fc9-2064-08da532a7fe8
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2022 02:05:22.5841
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r1souK7zB5cEdoyyzVWx4nrwA6dH8iB1OSfAtX1zs4zbgciYgtIizopnQGhyGUmN8EVAmkQA5tM8nwORlezwLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5061
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



> -----Original Message-----
> From: Xu, Yilun <yilun.xu@intel.com>
> Sent: Monday, June 20, 2022 10:19 PM
> To: Zhang, Tianfei <tianfei.zhang@intel.com>
> Cc: lee.jones@linaro.org; Wu, Hao <hao.wu@intel.com>; trix@redhat.com;
> linux-kernel@vger.kernel.org; linux-fpga@vger.kernel.org; Weight, Russell=
 H
> <russell.h.weight@intel.com>; matthew.gerlach@linux.intel.com
> Subject: Re: [PATCH v2 4/4] mfd: intel-m10-bmc: support multiple register
> layouts
>=20
> On Thu, Jun 16, 2022 at 10:04:05PM -0400, Tianfei Zhang wrote:
> > There are different base addresses for the MAX10 CSR register.
>=20
> Actually I see differences for each register, not only the register base.=
..
>=20
> > Introducing a new data structure m10bmc_csr for the register
> > definition of MAX10 CSR. Embedded m10bmc_csr into struct intel_m10bmc
> > to support multiple register layouts.
>=20
> Since the new BMC has different connections to host, different register l=
ayouts,
> different sub devices. Actually I can hardly find anything to share betwe=
en them,
> so how about we just create a new driver for your new BMC?

There is two version of BMC for Intel PAC FPGA card, one is SPI bus interfa=
ce other is PMCI bus interface.
They are different register layouts. But the working flow of some functiona=
lity  are very similar, and just slight different, for example,
access the BMC version/MAC address, the doorbell mechanism of read/write th=
e flash and so on.

If we create a new driver, there are will be lots of duplicate code between=
 old driver and new driver.

>=20
> Thanks,
> Yilun
>=20
> >
> > Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
> > ---
> >  drivers/mfd/intel-m10-bmc-core.c  | 30 +++++++++++++++++++++++++-----
> > include/linux/mfd/intel-m10-bmc.h | 20 +++++++++++++++++++-
> >  2 files changed, 44 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/mfd/intel-m10-bmc-core.c
> > b/drivers/mfd/intel-m10-bmc-core.c
> > index c6a1a4c28357..f85f8e2aa9a1 100644
> > --- a/drivers/mfd/intel-m10-bmc-core.c
> > +++ b/drivers/mfd/intel-m10-bmc-core.c
> > @@ -10,6 +10,22 @@
> >  #include <linux/mfd/intel-m10-bmc.h>
> >  #include <linux/module.h>
> >
> > +static const struct m10bmc_csr m10bmc_pmci_csr =3D {
> > +	.base =3D M10BMC_PMCI_SYS_BASE,
> > +	.build_version =3D M10BMC_PMCI_BUILD_VER,
> > +	.fw_version =3D NIOS2_PMCI_FW_VERSION,
> > +	.mac_low =3D M10BMC_PMCI_MAC_LOW,
> > +	.mac_high =3D M10BMC_PMCI_MAC_HIGH,
> > +};
> > +
> > +static const struct m10bmc_csr m10bmc_spi_csr =3D {
> > +	.base =3D M10BMC_SYS_BASE,
> > +	.build_version =3D M10BMC_BUILD_VER,
> > +	.fw_version =3D NIOS2_FW_VERSION,
> > +	.mac_low =3D M10BMC_MAC_LOW,
> > +	.mac_high =3D M10BMC_MAC_HIGH,
> > +};
> > +
> >  static struct mfd_cell m10bmc_n6000_bmc_subdevs[] =3D {
> >  	{ .name =3D "n6000bmc-hwmon" },
> >  	{ .name =3D "n6000bmc-sec-update" }
> > @@ -36,7 +52,7 @@ static ssize_t bmc_version_show(struct device *dev,
> >  	unsigned int val;
> >  	int ret;
> >
> > -	ret =3D m10bmc_sys_read(ddata, M10BMC_BUILD_VER, &val);
> > +	ret =3D m10bmc_sys_read(ddata, ddata->csr->build_version, &val);
> >  	if (ret)
> >  		return ret;
> >
> > @@ -51,7 +67,7 @@ static ssize_t bmcfw_version_show(struct device *dev,
> >  	unsigned int val;
> >  	int ret;
> >
> > -	ret =3D m10bmc_sys_read(ddata, NIOS2_FW_VERSION, &val);
> > +	ret =3D m10bmc_sys_read(ddata, ddata->csr->fw_version, &val);
> >  	if (ret)
> >  		return ret;
> >
> > @@ -66,11 +82,11 @@ static ssize_t mac_address_show(struct device *dev,
> >  	unsigned int macaddr_low, macaddr_high;
> >  	int ret;
> >
> > -	ret =3D m10bmc_sys_read(ddata, M10BMC_MAC_LOW, &macaddr_low);
> > +	ret =3D m10bmc_sys_read(ddata, ddata->csr->mac_low, &macaddr_low);
> >  	if (ret)
> >  		return ret;
> >
> > -	ret =3D m10bmc_sys_read(ddata, M10BMC_MAC_HIGH, &macaddr_high);
> > +	ret =3D m10bmc_sys_read(ddata, ddata->csr->mac_high,
> &macaddr_high);
> >  	if (ret)
> >  		return ret;
> >
> > @@ -91,7 +107,7 @@ static ssize_t mac_count_show(struct device *dev,
> >  	unsigned int macaddr_high;
> >  	int ret;
> >
> > -	ret =3D m10bmc_sys_read(ddata, M10BMC_MAC_HIGH, &macaddr_high);
> > +	ret =3D m10bmc_sys_read(ddata, ddata->csr->mac_high,
> &macaddr_high);
> >  	if (ret)
> >  		return ret;
> >
> > @@ -163,18 +179,22 @@ int m10bmc_dev_init(struct intel_m10bmc
> *m10bmc)
> >  	case M10_N3000:
> >  		cells =3D m10bmc_pacn3000_subdevs;
> >  		n_cell =3D ARRAY_SIZE(m10bmc_pacn3000_subdevs);
> > +		m10bmc->csr =3D &m10bmc_spi_csr;
> >  		break;
> >  	case M10_D5005:
> >  		cells =3D m10bmc_d5005_subdevs;
> >  		n_cell =3D ARRAY_SIZE(m10bmc_d5005_subdevs);
> > +		m10bmc->csr =3D &m10bmc_spi_csr;
> >  		break;
> >  	case M10_N5010:
> >  		cells =3D m10bmc_n5010_subdevs;
> >  		n_cell =3D ARRAY_SIZE(m10bmc_n5010_subdevs);
> > +		m10bmc->csr =3D &m10bmc_spi_csr;
> >  		break;
> >  	case M10_N6000:
> >  		cells =3D m10bmc_n6000_bmc_subdevs;
> >  		n_cell =3D ARRAY_SIZE(m10bmc_n6000_bmc_subdevs);
> > +		m10bmc->csr =3D &m10bmc_pmci_csr;
> >  		break;
> >  	default:
> >  		return -ENODEV;
> > diff --git a/include/linux/mfd/intel-m10-bmc.h
> > b/include/linux/mfd/intel-m10-bmc.h
> > index 83c4d3993dcb..3a4fdab2acbd 100644
> > --- a/include/linux/mfd/intel-m10-bmc.h
> > +++ b/include/linux/mfd/intel-m10-bmc.h
> > @@ -125,6 +125,11 @@
> >  #define M10BMC_PMCI_TELEM_START		0x400
> >  #define M10BMC_PMCI_TELEM_END		0x78c
> >
> > +#define M10BMC_PMCI_BUILD_VER   0x0
> > +#define NIOS2_PMCI_FW_VERSION   0x4
> > +#define M10BMC_PMCI_MAC_LOW    0x20
> > +#define M10BMC_PMCI_MAC_HIGH    0x24
> > +
> >  /* Supported MAX10 BMC types */
> >  enum m10bmc_type {
> >  	M10_N3000,
> > @@ -133,16 +138,29 @@ enum m10bmc_type {
> >  	M10_N6000
> >  };
> >
> > +/**
> > + * struct m10bmc_csr - Intel MAX 10 BMC CSR register  */ struct
> > +m10bmc_csr {
> > +	unsigned int base;
> > +	unsigned int build_version;
> > +	unsigned int fw_version;
> > +	unsigned int mac_low;
> > +	unsigned int mac_high;
> > +};
> > +
> >  /**
> >   * struct intel_m10bmc - Intel MAX 10 BMC parent driver data structure
> >   * @dev: this device
> >   * @regmap: the regmap used to access registers by m10bmc itself
> >   * @type: the type of MAX10 BMC
> > + * @csr: the register definition of MAX10 BMC
> >   */
> >  struct intel_m10bmc {
> >  	struct device *dev;
> >  	struct regmap *regmap;
> >  	enum m10bmc_type type;
> > +	const struct m10bmc_csr *csr;
> >  };
> >
> >  /*
> > @@ -174,7 +192,7 @@ m10bmc_raw_read(struct intel_m10bmc *m10bmc,
> unsigned int addr,
> >   * M10BMC_SYS_BASE accordingly.
> >   */
> >  #define m10bmc_sys_read(m10bmc, offset, val) \
> > -	m10bmc_raw_read(m10bmc, M10BMC_SYS_BASE + (offset), val)
> > +	m10bmc_raw_read(m10bmc, m10bmc->csr->base + (offset), val)
> >
> >  /*
> >   * MAX10 BMC Core support
> > --
> > 2.26.2
