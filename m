Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5A256D4AD
	for <lists+linux-fpga@lfdr.de>; Mon, 11 Jul 2022 08:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbiGKGYd (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 11 Jul 2022 02:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiGKGYL (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 11 Jul 2022 02:24:11 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E9E117068
        for <linux-fpga@vger.kernel.org>; Sun, 10 Jul 2022 23:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657520645; x=1689056645;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=M7Ej6FOm7Zy0usBC5Hb/BBTMbSJA1wuZoyLHliTYa2k=;
  b=KdZ6C/fkq0fQbdJK6HH8FdwiexrAo14Omiaj77YlwCYWSuKsYJpuT7Vr
   VrsWh+uEM6xozzbMvUkkzg6yIK03N7TnOqSv/o1rLrWQMTT1MC5F62Ah+
   ThINCCQUaqCftAGf5Qgu5AlV0tMK2cXSi2a2/OeWFtytZGLN62KZa/Z8d
   gPm8ACtjYX3QV8iWvX73uy7uuSxfy0F8nayydworENpiCCS0JiwJc5dxl
   tbDaYfY93VVa8TrR/3mqFFJ8A/lEeU1zXhqfnu01xaXlq6l8b78kmY+Ei
   ncH5Wti0EF2fW4sjBSxOXmFB8ztQIlhpRSFXE4ZdJXQZyiqY0tE1Z04uX
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10404"; a="348567226"
X-IronPort-AV: E=Sophos;i="5.92,262,1650956400"; 
   d="scan'208";a="348567226"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2022 23:24:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,262,1650956400"; 
   d="scan'208";a="627378897"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP; 10 Jul 2022 23:24:04 -0700
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sun, 10 Jul 2022 23:24:04 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Sun, 10 Jul 2022 23:24:04 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.49) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Sun, 10 Jul 2022 23:24:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ViZz1+mCq3BjXSagfQzffMUSaBnb6i6mBBXEaJp84Aq3nbjnt2JVOVa3jY3pO8Z3icp0NAgpwvOvgPFgUeqr2EJbyGaBq6nod7lWS0FjW2CrFrNbshQtFh08oOntp1S8Rg3cOkKF9Q3AS3DlJiulLUKNrFBAPXxkYujTLtwvkI5GFByGbMRwzC/KdCqZYd9R7g0n5HFsZ+K6CjjA32yb/EaC5Fb5UaFCaFdf34Zd8OyY+KhEfqtRUIhwuTNC3wyarmrBN6tjx/U38NHRsFV3k3J+E9QKvvzcEPRJRuC/4j08M8Uuc1XiWMeBpjogNXFhv6O+TcHokamEg0NHeSMEGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dNz/v90YkD6teTx2Q/oFh/cR7sGr31qw/MidGPDXN48=;
 b=IVhTCc3/aSzksddKGA0lyDQwis9lPQRm1cCv1wHoDP18lnGKE0OV2t14phpG2fn2Np/PcEOTME4VLuxSwVoMgxKZV4KS8QZVaGNzJCGyg76J8FYT4YCgGZZV/6XMWpQVbsfdHVq7eo6ah9YQ2mdmbQm73qNV2fhXvG8F5tNCBAeBqJaDhPJH/dJesxJ+k3LspyyfILJMYHNe4BVWN0QVyR8Ac7+yJOwCeNesilA7mV4op80u2h54c2X/M1fqN7TFhK8zMf6p9PcPLknN2WzyZ/51z6H3ivBo7pYcdLvP33k1sWYPM3p8gSeMzsSxDuYxTgt1n+rd8yFkP++7U05T2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5483.namprd11.prod.outlook.com (2603:10b6:408:104::10)
 by SN6PR11MB3197.namprd11.prod.outlook.com (2603:10b6:805:c5::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.23; Mon, 11 Jul
 2022 06:24:02 +0000
Received: from BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::a113:c892:d94:dd10]) by BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::a113:c892:d94:dd10%7]) with mapi id 15.20.5417.026; Mon, 11 Jul 2022
 06:24:02 +0000
From:   "Zhang, Tianfei" <tianfei.zhang@intel.com>
To:     "Xu, Yilun" <yilun.xu@intel.com>
CC:     "mdf@kernel.org" <mdf@kernel.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "Weight, Russell H" <russell.h.weight@intel.com>,
        "Wu, Hao" <hao.wu@intel.com>, "trix@redhat.com" <trix@redhat.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>
Subject: RE: [PATCH v1 2/3] fpga: m10bmc-sec: add sysfs to load bmc images
Thread-Topic: [PATCH v1 2/3] fpga: m10bmc-sec: add sysfs to load bmc images
Thread-Index: AQHYkEXkh741RZaajk2ZGCzvg8XH7K1yKgaAgAaK5rA=
Date:   Mon, 11 Jul 2022 06:24:01 +0000
Message-ID: <BN9PR11MB548365BF8E5D4B6C0BB3FEDBE3879@BN9PR11MB5483.namprd11.prod.outlook.com>
References: <20220705080058.92532-1-tianfei.zhang@intel.com>
 <20220705080058.92532-3-tianfei.zhang@intel.com>
 <20220707020009.GA3654919@yilunxu-OptiPlex-7050>
In-Reply-To: <20220707020009.GA3654919@yilunxu-OptiPlex-7050>
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
x-ms-office365-filtering-correlation-id: 114eba63-e3c4-4f09-2082-08da6305f26a
x-ms-traffictypediagnostic: SN6PR11MB3197:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DnA+NlepbaWKh4zRou7JwKxtvXK5xVkbWKil64wsZKGjDmTh6BD248w2D5N1mJof8wskR16DLt0M0oQPqv+zdxjfratpiLvmUuYlFhBpYhEdW17Zs+fk72uTpXQWSczqcW0dF48+1gQmg9+jRe5R2GomSb2HbjrIWQerCA3JUl8vda37Jq0m8/1NEQzGLBfBimcLAlg0z6yzBZIwwQoZ98f1we0y3IRNlIy683UkkP23eA6iW2tguWCjzly5a1jwWMnQKbv3he/vIWhx7/v3s7mdkAfuEBfBCTXr3I4fZFqGeYYta9ANYQTkeUZylBYxdewX4Z1SePmLjyLtuOBhbEPEF1VYE9Cz2a7zb3qZ6Fgyh2FN/TwBtf76S9Enh4jnL4ztf7K9og/mkLhSXSGNgInNyd7XtS59WMvTlWjJoDoyDOlWaJCZXUuIOGPtRnfuFRiCPiHQaTJpvhLkiL75pkgKzZwHLxjoIaejhiq7mpXU7UTNB8zjxowuGy5+v0x09vkuVPPD9kxDOqFC7RsVnTtwA5FaoC7TWok7460F5qo9xvpSAX9IZUeulp9OJ1C0qG0oJvg0ONSvcd4Jv7Va84jGUegOV2F86iAQM/6YHUfA6AOAPpW3cQ3j+JQmbWXY4jePAg1krNyUAiRwCpnWKZMkGXWzzrdBeQe6EaWbgj5iLTH7h4OuQSPkpwKANI8F3srI9ljJ1xhvbIqACIwlmVWXVF9lNDOk5k5/z3DdBvRepyHKje0Df1r8OKRe90bVtZs9MV8AvNtyf+2ZeBKqvZ+f85n+o9Ex4cfE4Nl/JyLMGqnScMmU3faH+pxfqieaaioJbg4jHWqR+dC8/xz8wc+fyd2O6qJM3B/PPO/2/1w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5483.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(396003)(376002)(346002)(39860400002)(6862004)(8936002)(52536014)(4326008)(6636002)(7696005)(6506007)(33656002)(41300700001)(54906003)(71200400001)(55016003)(38100700002)(38070700005)(66476007)(9686003)(64756008)(2906002)(66556008)(66446008)(316002)(66946007)(8676002)(76116006)(53546011)(82960400001)(478600001)(966005)(5660300002)(122000001)(186003)(83380400001)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0CEtC6C6m/dkW2SrXToHsXaa2KULCk3pbzRBuDyIepVzZn25ho2WEQHtq+DK?=
 =?us-ascii?Q?EeuH5bakLJRBo0xRE0BSQ+5wTyFe1TAkdjQqJnbP70ZZJlPWj8nVASUvWHVP?=
 =?us-ascii?Q?x39CfCWyGJ3MdvsLSjrGCUSB7QDOFr7QEnXV57oMXmqwzXGbqtN+q1JVAPpp?=
 =?us-ascii?Q?2GYRY+ZOpNQVSsW4OLW2Y4HdeWezB9RKyo4D0LQTxmOHu8RAGguHJL8V0BBe?=
 =?us-ascii?Q?DID6jnEHDVD776C97PgcS11iRXwGRvPrZSMeKitFNjGpNVLm8GY6m1rE77r0?=
 =?us-ascii?Q?b047TrJy6AKmqsdDanCyJeX9afg/aJm9jmZYOv+X57E8Xwwo1hWZnX29luMx?=
 =?us-ascii?Q?C2x98fhjWGqhPGl6fuZu138FTBNQ6C9DaMHAn/muiKZ6spoEFG0K2ru+pyeG?=
 =?us-ascii?Q?08SmH+C0NfHgm7psMfbrT7cgQm8iIqqVJ8VR0NMhgsa/Zyjml7Co4sLMOXkB?=
 =?us-ascii?Q?/BU36GCB4/b5hd0lzW5T2mqbzhqms6PJnZnIYJxjkA69FyjznTHw5DeIwV5v?=
 =?us-ascii?Q?zYY0SNE6UlQMyIhAB7JGp7ZoCOsxWPTLH6eEETFMroQDW2xfzWp63oofD2Zb?=
 =?us-ascii?Q?WMtWt/omX+QbtzSe7TF0Y+8Q4ubCXtcyJXANRb8mx/1cVeIpJihQcTKqzmYa?=
 =?us-ascii?Q?E3DG54UUNbo3sXifdkHcEVYDp/Bje+reseDr6E65heJzVx7F2gBG/ZNoJda+?=
 =?us-ascii?Q?WarzL/nQjHexwHYT2ved6hWVzCqv4UiA2tImJF1OscLDaSN802tHrf5iitJ7?=
 =?us-ascii?Q?UvJ260L3XtFk1wLrClw2/FwdgRVyS03Mi2YqfOoyP12zS+nIErI+1J48oeIW?=
 =?us-ascii?Q?7YMg8SEyVQm5crmMaj/G7cyfCYCAyN29jHV/9QZSrCkUPTwRBb1vexygMRs7?=
 =?us-ascii?Q?H5s5GZU4WR7rQ3tzK3N2euJlRur3mRdO76YlT1Rj1gJAkfmrYjssiX0tM6LR?=
 =?us-ascii?Q?K1dDrhVx8M0ief59lncVwUt9b/nd/jtUBV3e5JM5mArIoZgOAbp428zQYawt?=
 =?us-ascii?Q?kosQkBis3TC6SvWA7c+d4ILrVUkRU+/y1zDsxWehyRnbZsdLlfki4wU2e/kT?=
 =?us-ascii?Q?CYUE7mgB9rUUNOgMI9cCh6prZffLtgnTgLLHQBHX6Fh501S089GvQKDmtdFE?=
 =?us-ascii?Q?PlgzojkA7jN6JsSvCO2wO3pif/PgOqoqnroM/KExk1MVmxRquxWVtfYwIjA8?=
 =?us-ascii?Q?SLlWY/UheT5V3HRHO9CZtsgbsiF8NDDuC4bEn5uwZi9zVZ/hZAvd9XYZRnFZ?=
 =?us-ascii?Q?ggL3vEEMMQPjnX1QtaiU2g4qjcf/N5RaaANtyO5bE+4tyeibkNl9/P1FPk0D?=
 =?us-ascii?Q?4w/SLZPK67SlT12MY4B1S8lVZLdK2tXO8AzNNoEyIUgtoIsIf5oOCMywOn8z?=
 =?us-ascii?Q?tQ/NA7oOG+LN62PawhUlNc4UUvqJGfdHqaRHnkj6eehNAoWgF8NNMmXtR3XB?=
 =?us-ascii?Q?ZcO4F+PKNi1OnQvZWTpANa2yv09F/M3fNWHidk9VOQnOGAjQb6q3eTWxJkLZ?=
 =?us-ascii?Q?Q2EZuz3VSFFD6sgMXIOAy0E3zihNr+5Pyt8NKJkkd6C+YK638rsQvbNC4l7A?=
 =?us-ascii?Q?6+uVVu3EbpIccgv6ckvfXvlDqV1zgw9zToSQDbHwF7LnQowiJJEPLCNmRsWH?=
 =?us-ascii?Q?DyXYvDCe27VI3fu9xYLmQg3TsTkNYidktPQ+oa9Rqjjw?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5483.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 114eba63-e3c4-4f09-2082-08da6305f26a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2022 06:24:01.9217
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yM7sxac/egh+BkIHhwjo9+JJvnkhCBMwCbmJSEekKplvSPS/PxAf2gGUCT4YLIJgifeeXyE9d7xydp3x91mH7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3197
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
> Sent: Thursday, July 7, 2022 10:00 AM
> To: Zhang, Tianfei <tianfei.zhang@intel.com>
> Cc: mdf@kernel.org; lee.jones@linaro.org; Weight, Russell H
> <russell.h.weight@intel.com>; Wu, Hao <hao.wu@intel.com>;
> trix@redhat.com; linux-fpga@vger.kernel.org
> Subject: Re: [PATCH v1 2/3] fpga: m10bmc-sec: add sysfs to load bmc image=
s
>=20
> On Tue, Jul 05, 2022 at 04:00:57AM -0400, Tianfei Zhang wrote:
> > From: Russ Weight <russell.h.weight@intel.com>
> >
> > Add the available_images and image_load sysfs files. The
> > available_images file returns a space separated list of key words that
> > may be written into the image_load file. These keywords describe an
> > FPGA, BMC, or firmware image in FLASH or EEPROM storage that may be
> loaded.
> >
> > The image_load sysfs file may be written with a key word to trigger a
> > reload of an FPGA, BMC, or firmware image from FLASH or EEPROM.
> >
> > Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> > Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
> > ---
> >  .../sysfs-driver-intel-m10-bmc-sec-update     |  21 ++++
> >  drivers/fpga/intel-m10-bmc-sec-update.c       | 104 ++++++++++++++++++
> >  2 files changed, 125 insertions(+)
> >
> > diff --git
> > a/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update
> > b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update
> > index 0a41afe0ab4c..8ded1a59d4db 100644
> > --- a/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update
> > +++ b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update
> > @@ -59,3 +59,24 @@ Contact:	Russ Weight
> <russell.h.weight@intel.com>
> >  Description:	Read only. Returns number of times the secure update
> >  		staging area has been flashed.
> >  		Format: "%u".
> > +
> > +What:		/sys/bus/platform/drivers/intel-m10bmc-sec-
> update/.../control/available_images
> > +Date:		July 2022
> > +KernelVersion:  5.20
> > +Contact:	Russ Weight <russell.h.weight@intel.com>
> > +Description:	Read-only. This file returns a space separated list of
> > +		key words that may be written into the image_load file
> > +		described below. These keywords decribe an FPGA, BMC,
> > +		or firmware image in FLASH or EEPROM storage that may
> > +		be loaded.
> > +
> > +What:		/sys/bus/platform/drivers/intel-m10bmc-sec-
> update/.../control/image_load
> > +Date:		July 2022
> > +KernelVersion:  5.20
> > +Contact:	Russ Weight <russell.h.weight@intel.com>
> > +Description:	Write-only. A key word may be written to this file to
> > +		trigger a reload of an FPGA, BMC, or firmware image from
>=20
> A FPGA reprogramming could be handled by FPGA manager, so we may not
> introduce a new API for the same purpose.

The FPGA reprogramming is in the MAX10 BMC Secure Update drive, which insta=
ntiates the new Firmware
Upload functionality, like update the image into flash. Those functionaliti=
es have implemented by Russ's patchset.
https://lore.kernel.org/linux-fpga/20220606160038.846236-1-russell.h.weight=
@intel.com/

This patch doesn't related to the FPGA reprogramming, it just do the FPGA/B=
MC image reload,
and trigger the FPGA/BMC to reload a new image from different flash page. F=
or example, on N3000 card, the=20
FPGA image has 2 pages, page 0 for factory image, page 1 for user image. Th=
is patch was easy to select and=20
trigger the FPGA to reload the image via sysfs file, like factory or user i=
mage.

I will change the title of patch change in next version patch:
fpga: m10bmc-sec: add sysfs files to reload fpga/bmc images

>=20
> Thanks,
> Yilun
>=20
> > +		FLASH or EEPROM. Refer to the available_images file for a
> > +		list of supported key words for the underlying device.
> > +		Writing an unsupported string to this file will result in
> > +		EINVAL being returned.
> > diff --git a/drivers/fpga/intel-m10-bmc-sec-update.c
> > b/drivers/fpga/intel-m10-bmc-sec-update.c
> > index 72c677c910de..640690e6c131 100644
> > --- a/drivers/fpga/intel-m10-bmc-sec-update.c
> > +++ b/drivers/fpga/intel-m10-bmc-sec-update.c
> > @@ -14,6 +14,8 @@
> >  #include <linux/platform_device.h>
> >  #include <linux/slab.h>
> >
> > +struct image_load;
> > +
> >  struct m10bmc_sec {
> >  	struct device *dev;
> >  	struct intel_m10bmc *m10bmc;
> > @@ -21,6 +23,12 @@ struct m10bmc_sec {
> >  	char *fw_name;
> >  	u32 fw_name_id;
> >  	bool cancel_request;
> > +	struct image_load *image_load;	/* terminated with { } member */
> > +};
> > +
> > +struct image_load {
> > +	const char *name;
> > +	int (*load_image)(struct m10bmc_sec *sec);
> >  };
> >
> >  static DEFINE_XARRAY_ALLOC(fw_upload_xa);
> > @@ -137,6 +145,54 @@ DEVICE_ATTR_SEC_CSK_RO(pr, PR_PROG_ADDR +
> > CSK_VEC_OFFSET);
> >
> >  #define FLASH_COUNT_SIZE 4096	/* count stored as inverted bit vector
> */
> >
> > +static ssize_t available_images_show(struct device *dev,
> > +				     struct device_attribute *attr, char *buf) {
> > +	struct m10bmc_sec *sec =3D dev_get_drvdata(dev);
> > +	const struct image_load *hndlr;
> > +	ssize_t count =3D 0;
> > +
> > +	for (hndlr =3D sec->image_load; hndlr->name; hndlr++) {
> > +		count +=3D scnprintf(buf + count, PAGE_SIZE - count,
> > +				   "%s ", hndlr->name);
> > +	}
> > +
> > +	buf[count - 1] =3D '\n';
> > +
> > +	return count;
> > +}
> > +static DEVICE_ATTR_RO(available_images);
> > +
> > +static ssize_t image_load_store(struct device *dev,
> > +				struct device_attribute *attr,
> > +				const char *buf, size_t count)
> > +{
> > +	struct m10bmc_sec *sec =3D dev_get_drvdata(dev);
> > +	const struct image_load *hndlr;
> > +	int ret =3D -EINVAL;
> > +
> > +	for (hndlr =3D sec->image_load; hndlr->name; hndlr++) {
> > +		if (sysfs_streq(buf, hndlr->name)) {
> > +			ret =3D hndlr->load_image(sec);
> > +			break;
> > +		}
> > +	}
> > +
> > +	return ret ? : count;
> > +}
> > +static DEVICE_ATTR_WO(image_load);
> > +
> > +static struct attribute *m10bmc_control_attrs[] =3D {
> > +	&dev_attr_available_images.attr,
> > +	&dev_attr_image_load.attr,
> > +	NULL,
> > +};
> > +
> > +static struct attribute_group m10bmc_control_attr_group =3D {
> > +	.name =3D "control",
> > +	.attrs =3D m10bmc_control_attrs,
> > +};
> > +
> >  static ssize_t flash_count_show(struct device *dev,
> >  				struct device_attribute *attr, char *buf)  { @@
> -195,6 +251,7 @@
> > static struct attribute_group m10bmc_security_attr_group =3D {
> >
> >  static const struct attribute_group *m10bmc_sec_attr_groups[] =3D {
> >  	&m10bmc_security_attr_group,
> > +	&m10bmc_control_attr_group,
> >  	NULL,
> >  };
> >
> > @@ -208,6 +265,52 @@ static void log_error_regs(struct m10bmc_sec *sec,
> u32 doorbell)
> >  		dev_err(sec->dev, "RSU auth result: 0x%08x\n", auth_result);  }
> >
> > +static int m10bmc_sec_bmc_image_load(struct m10bmc_sec *sec,
> > +				     unsigned int val)
> > +{
> > +	u32 doorbell;
> > +	int ret;
> > +
> > +	if (val > 1) {
> > +		dev_err(sec->dev, "invalid reload val =3D %d\n", val);
> > +		return -EINVAL;
> > +	}
> > +
> > +	ret =3D m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL,
> &doorbell);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (doorbell & DRBL_REBOOT_DISABLED)
> > +		return -EBUSY;
> > +
> > +	return m10bmc_sys_update_bits(sec->m10bmc, M10BMC_DOORBELL,
> > +				      DRBL_CONFIG_SEL | DRBL_REBOOT_REQ,
> > +				      FIELD_PREP(DRBL_CONFIG_SEL, val) |
> > +				      DRBL_REBOOT_REQ);
> > +}
> > +
> > +static int m10bmc_sec_bmc_image_load_0(struct m10bmc_sec *sec) {
> > +	return m10bmc_sec_bmc_image_load(sec, 0); }
> > +
> > +static int m10bmc_sec_bmc_image_load_1(struct m10bmc_sec *sec) {
> > +	return m10bmc_sec_bmc_image_load(sec, 1); }
> > +
> > +static struct image_load m10bmc_image_load_hndlrs[] =3D {
> > +	{
> > +		.name =3D "bmc_factory",
> > +		.load_image =3D m10bmc_sec_bmc_image_load_1,
> > +	},
> > +	{
> > +		.name =3D "bmc_user",
> > +		.load_image =3D m10bmc_sec_bmc_image_load_0,
> > +	},
> > +	{}
> > +};
> > +
> >  static enum fw_upload_err rsu_check_idle(struct m10bmc_sec *sec)  {
> >  	u32 doorbell;
> > @@ -565,6 +668,7 @@ static int m10bmc_sec_probe(struct platform_device
> *pdev)
> >  	sec->dev =3D &pdev->dev;
> >  	sec->m10bmc =3D dev_get_drvdata(pdev->dev.parent);
> >  	dev_set_drvdata(&pdev->dev, sec);
> > +	sec->image_load =3D m10bmc_image_load_hndlrs;
> >
> >  	ret =3D xa_alloc(&fw_upload_xa, &sec->fw_name_id, sec,
> >  		       xa_limit_32b, GFP_KERNEL);
> > --
> > 2.26.2
