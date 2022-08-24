Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0F0159F07E
	for <lists+linux-fpga@lfdr.de>; Wed, 24 Aug 2022 03:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiHXBDS (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 23 Aug 2022 21:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiHXBDR (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 23 Aug 2022 21:03:17 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6833486FE3
        for <linux-fpga@vger.kernel.org>; Tue, 23 Aug 2022 18:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661302996; x=1692838996;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rgvQ/Jk8tAAymiwSFlRcGdXMoHcb5zPZIgsEZT62smU=;
  b=WhELP2v36DfVMINfvZwaIhP4c/NuqbX3apJOmLHi7NALm81pRbOewZnU
   T7xEj5LWHBHHEDJi9gyMYlX/IA9uyDQ0CvOvwp4Hap5wvX6/RO4cDFdBi
   W9Cof01AVEwTNQHmC6W/EyPyCplPsykjSxXOmk5Za8iRwAHTZydcU7+aJ
   F0b87NDlR3Y8w4GlMblodGPY9U8/pER++zS//t80R4vzV5DJXyYvorrFB
   1AEO/G+cTOkLAgYlhgwnjnQBbs4Ijgp+xRULKmOROk0RU+P+62tY9TwrL
   vdCWj723J7UOIeiPXkHW2zObv3CSEGItKQkt9FSvpG/CGFOiZqzRQYvjD
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10448"; a="293834555"
X-IronPort-AV: E=Sophos;i="5.93,259,1654585200"; 
   d="scan'208";a="293834555"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 18:03:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,259,1654585200"; 
   d="scan'208";a="638892615"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga008.jf.intel.com with ESMTP; 23 Aug 2022 18:03:15 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 23 Aug 2022 18:03:15 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 23 Aug 2022 18:03:14 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 23 Aug 2022 18:03:14 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 23 Aug 2022 18:03:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=McpAaX91rD3gNEyoPlmZxtwy+C3l48R/n3RnHERo5pkv38HOz8b2IoM4NjeB2r/IiIGFC9ic/kcqXBus3xGU/OfAu2rSub8GMTEMvuUmUS8mvzys6kckDNCWE7OqdMLgjvAOfLHBHOo6RAnS8qXdc9OQpNdmUySWIfIB+pFe11ezppt7Qsz3meG4oK0gzjPBkwcEj8yIW8mI+pT/1Q59u7+WeHiGKeCMDv8tPdzdQe06tTktnjp7Hc7VwzQjiRq+8IdkMkOXCS3CT25yawDyM2uA/4z+jgmvUjPMbqPsn4nDrTiA9Es34BpyJqghmI+/VwvgHECy4/0Yhsar77gWnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ke5B5809XZmUh86kunhZ5oEx8QYBZRn4mHSKpIhr8JE=;
 b=ZXdtP2IOADy9LaELLDPa62qOzfAQ7VEZQuxz4OgkOGbsSSbH8ICmWkuXps+DIye5CAru5zPsxQgpY/6Lmim1GtYAkJNxMkczGo+AUWVYidBV4noCHEpjkFikodX1AI6bWmOBqZxzMv865kLoaXyydbd3fdjpTZbmMvZC6rZKCJlxhjHVONhq9CaYUZ62dPGL1BVNk17NbpKbRFuCmVo4d28dtwjcRRgvZ/kFtj7vkrKXep96aXjtJikF0zIirOnpdG07amFxKhFN7pfoHKwW2gFq+/unUiyiRQtLIPJRh3kWpyGld4LJEJAewMGFYFTl88iW3hbN1Ci7zK/FR0vRuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5483.namprd11.prod.outlook.com (2603:10b6:408:104::10)
 by BY5PR11MB4037.namprd11.prod.outlook.com (2603:10b6:a03:188::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21; Wed, 24 Aug
 2022 01:03:12 +0000
Received: from BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::d482:3ee0:a92b:bc39]) by BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::d482:3ee0:a92b:bc39%4]) with mapi id 15.20.5546.022; Wed, 24 Aug 2022
 01:03:12 +0000
From:   "Zhang, Tianfei" <tianfei.zhang@intel.com>
To:     "matthew.gerlach@linux.intel.com" <matthew.gerlach@linux.intel.com>
CC:     "mdf@kernel.org" <mdf@kernel.org>,
        "Xu, Yilun" <yilun.xu@intel.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "Weight, Russell H" <russell.h.weight@intel.com>,
        "Wu, Hao" <hao.wu@intel.com>, "trix@redhat.com" <trix@redhat.com>
Subject: RE: [PATCH v4 2/2] fpga: m10bmc-sec: add m10bmc_sec_retimer_load
 callback
Thread-Topic: [PATCH v4 2/2] fpga: m10bmc-sec: add m10bmc_sec_retimer_load
 callback
Thread-Index: AQHYsG3dEOMowA//8ke5VAP6ylI2Ka282uSAgABta2A=
Date:   Wed, 24 Aug 2022 01:03:11 +0000
Message-ID: <BN9PR11MB5483F99AE84E0EABF089072CE3739@BN9PR11MB5483.namprd11.prod.outlook.com>
References: <20220815060715.37712-1-tianfei.zhang@intel.com>
 <20220815060715.37712-3-tianfei.zhang@intel.com>
 <alpine.DEB.2.22.394.2208231124520.6273@rhweight-WRK1>
In-Reply-To: <alpine.DEB.2.22.394.2208231124520.6273@rhweight-WRK1>
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
x-ms-office365-filtering-correlation-id: e649efdf-76f1-4b52-8881-08da856c6aba
x-ms-traffictypediagnostic: BY5PR11MB4037:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NsL3NjTWhpDDKzlE85dE8W9eahQfQNMAqUTXWOBbt9ckrzRG0oEdb3htmDMworfXe77VHlTIa/tthqeYcdCMmoogLpcSnbDkeu4n3SZ+sBZadbhFvO+fK7fOwGGhxN3st/H980RLmlq/4YYIjzih9So8Df0qWAOwKh/ZqsS/4uXjBZfpZXMVJN7DxvwhXgjSFhdh/Lc1fFk7Sn7tbvmPwNX6/E+XqmkOS+KsInZiBJncUhDTCj2fmR3Of3V23h63qu+EII4xn+C8vTF1Sn2rtpAJETWGTL+3/639wqVH9+w+KiZdP89ZWqGcVrug33DvqYzlgCYqR3pj5urKEr2TKct/dFfpVQXsB8hFYb6S3pS6oeMCBDJ7g9BPGoy5PjRZytnZ/IftyYGYPSoZOE1uzTiCIgLTncrdZVik/40pX7AJEJqvIScU7lwoSRl98qAe7NaiZsH+Cq09K/U8hA1x705yxqEgeJvnnlu8yhEQks9kOjm5gPb2jnVvOZqFR7x4WVyNYIVyj3VbmlsvFbOkoX8GYDCEJ3QpDB7yzbA1n1s5fqQkTLWSQYAGzRbXkQSU7fBaBdNx8hWc4tggt4kNzBYSq5jzpzFQTSRH8LYJHg9ybQQ7sm5t1hLBUClR+TixjBupvAgE73zt+x5euzquKCvK1HXpCOg7uM6XTTXSuNZvukRgGuZZHyEE6ZuqPvPd21hoxoe2e6RVQLGB7dJqlTZnsDXgxT3J5tBeDm+BYoFiCng0xQvhqoywigY0opKBxiD6hhLJj5nydo1Aq/ln9F1YG81VtjUx3Owaf+GaiW5j5ghOKhz1q1jJsWWQ/4FgnRo4CFn76z0pGEaLvK+4pw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5483.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(136003)(396003)(39860400002)(346002)(376002)(38070700005)(83380400001)(54906003)(66556008)(66446008)(76116006)(64756008)(6916009)(316002)(71200400001)(8676002)(66476007)(186003)(66946007)(4326008)(5660300002)(53546011)(7696005)(2906002)(9686003)(6506007)(8936002)(966005)(41300700001)(33656002)(478600001)(55016003)(52536014)(122000001)(38100700002)(86362001)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?m12CAXCIRaLUjgpS/8PCCFsgGKC4IsCm71t9fLAXF507rgNG98H/8sqC4QMB?=
 =?us-ascii?Q?5jchxTxGRy3ishq/l60DnEH7rIJXvyY2DuuVNcMSBgdmtddPvg7MCgUrQJYb?=
 =?us-ascii?Q?o+osXvtbcZvRfnvVl88VgycbM9SZPOiWEkqtbzMQe+HgTo/qjJy2PiXlFHTM?=
 =?us-ascii?Q?W4mKzjCcNmD2TjCPxnZmGYzaotGVdJ0x2bjJPqvsMGCiWRJcUthdKNPk+EQ0?=
 =?us-ascii?Q?2o5Rgs18Ge3lNOGHvjxduH1ynis/Piz+TzlqiinomAEzCygwhoHYUM7rXxeZ?=
 =?us-ascii?Q?2as/m1xlqXjZcvEq1E1Jd7blxQ/LTTRquuooxzMzR0iWZbDbKNlw730Nrw+L?=
 =?us-ascii?Q?4t18DtYky1YpptpbG/Q7cQfgnXcxXmUlKRZRCbSdDMSW6YEB3Bx6L5AeZkLg?=
 =?us-ascii?Q?KvVbt8MUlWqOODURLUv0v8XHc0IuJxOAsKuStFntLQGGZEFc/ceDaQGC+rVX?=
 =?us-ascii?Q?XAL7jetqIJU0XWdXweLfgxS8iAeKIUAm79w+9a1SlZT0vBODG7o3rT8o81PM?=
 =?us-ascii?Q?tp4gCJHinc0YUbhabvCfk4LVXvNwfa1dLfla2Kk+Wg+2vmlai5IXwf/emMfT?=
 =?us-ascii?Q?TLWWqYTHySYA+BP52OuxhYsGR6ZnLVTuIZu3mW1YucPGi1D0U+GTYRNgejbJ?=
 =?us-ascii?Q?SZJDAvsemwFFYRqGcU7l2oB6faiRSiV9meVxG7CvRuPhDMh+vyLd0igqcnW2?=
 =?us-ascii?Q?hIrYiCB3h34nIvhXNYPLj27kyelAuIS9sb9JKLPTzKliaT/22KN9qVKMQ5Rp?=
 =?us-ascii?Q?TlEAJC8j2MMxfUqJ6tdQi6MmOUuZXOBQspStxlv6XEF0OF1pGQUhLd7JtIIi?=
 =?us-ascii?Q?n2vlnClkn4crI/i3Pj4bJGrbjNvVbtAJMMDOCavtfYFW6AQeLlassGZKGyyC?=
 =?us-ascii?Q?fcDDm0NUSozLSduOr/IPf7Q6mQjlMyn8Ckq/ynNuL3RloIBY0DU1NFASLhEg?=
 =?us-ascii?Q?uN/n1goEvgu8OUDyK1SYKhoAqgaJx+EkUshk5+OPhxS4glUuGnRMIJRLH8Oj?=
 =?us-ascii?Q?e74F5yHz3PrdD6by39LjNmm125UgHbPiZ3ZVISKI2xd8On8tywEn1AlRqYMz?=
 =?us-ascii?Q?OH4wY+h5VbACakr/VBDsXKyPzU+pOl+SLFCcqhT5dfVUz15U/Qyp0mkBRmwl?=
 =?us-ascii?Q?PlbeA21T7MtzC+dnGHyLFCQ7qmj6Ah1NyzA9pj/lEROhbvPd2LlFAh231LmS?=
 =?us-ascii?Q?KIlFP79vZVI/Mou7/kABQVHkckdgEh9OItDrubO/CIHomgVFMd5kk1m4MoAi?=
 =?us-ascii?Q?ZTll4nNsVpmZEhj3TVpX0OuRdWph7lD9z/zcypUqrzz85JyxWA8o/MMX1Sos?=
 =?us-ascii?Q?PeeSjA+9S1HXyyvIGTYGd+usUPVQ4d4l6BpqNVQvhqLHFAjsN4Y9NL9u7Dg/?=
 =?us-ascii?Q?xkCY4eB9taBmMTBAQdDrUrp8h8xmqpjLDQyOG75OSwm7DAywvxHWLgD3uWb7?=
 =?us-ascii?Q?y2FAcfvi/wfR/42M2UGeu9CtBzoiNMP1S/YBCcJKfgND2X4txaDfaxRCzfEL?=
 =?us-ascii?Q?Da4q56axT9TTOjixISGoXcHB4XrJ0nu8XX76BsgV+dV8YaCmlV5sh5K0xaP7?=
 =?us-ascii?Q?J+YuhP6nzHCZP72iMN8d3n+G8B1b7pgNxN0tC4coQk7eO1Mo+8KbAm3cw/Bo?=
 =?us-ascii?Q?KJrur7bobk92WmdXcfgtYjOdd5t6bdd8oX97wrUhUKFu?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5483.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e649efdf-76f1-4b52-8881-08da856c6aba
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2022 01:03:11.9277
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dbyuocLikN1yS1LlJmHc1lCo94I+R4UnJRdnmnpsbWKXgjGUXZnssTwyI8xh6tyADcqxRyi0hLLJ6VvKKsXwIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4037
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



> -----Original Message-----
> From: matthew.gerlach@linux.intel.com <matthew.gerlach@linux.intel.com>
> Sent: Wednesday, August 24, 2022 2:27 AM
> To: Zhang, Tianfei <tianfei.zhang@intel.com>
> Cc: mdf@kernel.org; Xu, Yilun <yilun.xu@intel.com>; linux-fpga@vger.kerne=
l.org;
> lee.jones@linaro.org; Weight, Russell H <russell.h.weight@intel.com>; Wu,=
 Hao
> <hao.wu@intel.com>; trix@redhat.com
> Subject: Re: [PATCH v4 2/2] fpga: m10bmc-sec: add m10bmc_sec_retimer_load
> callback
>=20
>=20
>=20
> On Mon, 15 Aug 2022, Tianfei Zhang wrote:
>=20
> > From: Russ Weight <russell.h.weight@intel.com>
> >
> > Create m10bmc_sec_retimer_load() callback function to provide a
> > trigger to update a new retimer (Intel
> > C827 Ethernet transceiver) firmware on Intel PAC
> > N3000 Card.
> >
> > Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> > Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
>=20
> Hi Tianfei,
>=20
> You forgot to add Acked-by: Lee Jones <lee@kernel.org>.

I think Lee Jones just acked by other patch (in PMCI pachset) not this patc=
hset.
https://patchwork.kernel.org/project/linux-fpga/patch/20220617020405.128352=
-2-tianfei.zhang@intel.com/

In this patchset, Lee Jones suggested that use regmap API directly and don'=
t need a simple wrapper.
https://patchwork.kernel.org/project/linux-fpga/patch/20220725092836.647028=
-2-tianfei.zhang@intel.com/


>=20
> Reviewed-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>

Thanks Matthew.

>=20
> Looks good to me.
> > ---
> > v3:
> > uses regmap_update_bits() API instead of m10bmc_sys_update_bits().
> > ---
> > drivers/fpga/intel-m10-bmc-sec-update.c | 148 ++++++++++++++++++++++++
> > include/linux/mfd/intel-m10-bmc.h       |  31 +++++
> > 2 files changed, 179 insertions(+)
> >
> > diff --git a/drivers/fpga/intel-m10-bmc-sec-update.c
> > b/drivers/fpga/intel-m10-bmc-sec-update.c
> > index 3a082911cf67..bef07e97c107 100644
> > --- a/drivers/fpga/intel-m10-bmc-sec-update.c
> > +++ b/drivers/fpga/intel-m10-bmc-sec-update.c
> > @@ -300,6 +300,150 @@ static int m10bmc_sec_bmc_image_load_1(struct
> m10bmc_sec *sec)
> > 	return m10bmc_sec_bmc_image_load(sec, 1); }
> >
> > +static int trigger_retimer_eeprom_load(struct m10bmc_sec *sec) {
> > +	struct intel_m10bmc *m10bmc =3D sec->m10bmc;
> > +	unsigned int val;
> > +	int ret;
> > +
> > +	ret =3D regmap_update_bits(m10bmc->regmap,
> > +				 M10BMC_SYS_BASE + M10BMC_DOORBELL,
> > +				 DRBL_PKVL_EEPROM_LOAD_SEC,
> > +				 DRBL_PKVL_EEPROM_LOAD_SEC);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/*
> > +	 * If the current NIOS FW supports this retimer update feature, then
> > +	 * it will clear the same PKVL_EEPROM_LOAD bit in 2 seconds. Otherwis=
e
> > +	 * the driver needs to clear the PKVL_EEPROM_LOAD bit manually and
> > +	 * return an error code.
> > +	 */
> > +	ret =3D regmap_read_poll_timeout(m10bmc->regmap,
> > +				       M10BMC_SYS_BASE + M10BMC_DOORBELL,
> val,
> > +				       (!(val & DRBL_PKVL_EEPROM_LOAD_SEC)),
> > +				       M10BMC_PKVL_LOAD_INTERVAL_US,
> > +				       M10BMC_PKVL_LOAD_TIMEOUT_US);
> > +	if (ret =3D=3D -ETIMEDOUT) {
> > +		dev_err(sec->dev, "PKVL_EEPROM_LOAD clear timedout\n");
> > +		regmap_update_bits(m10bmc->regmap,
> > +				   M10BMC_SYS_BASE + M10BMC_DOORBELL,
> > +				   DRBL_PKVL_EEPROM_LOAD_SEC, 0);
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
> > +	 * already programmed. RSU_PROG_PKVL_PROM_DONE that the firmware
> > +	 * update process has finished, but does not necessarily indicate
> > +	 * a successful update.
> > +	 */
> > +	ret =3D regmap_read_poll_timeout(m10bmc->regmap,
> > +				       M10BMC_SYS_BASE + M10BMC_DOORBELL,
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
> > +				"Doorbell check timedout: 0x%08x\n", doorbell);
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
> > +		dev_err(sec->dev, "poll M10BMC_PKVL_PRELOAD error %d\n", ret);
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
> > +	ret =3D m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, &doorbell);
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
> > static struct image_load m10bmc_image_load_hndlrs[] =3D {
> > 	{
> > 		.name =3D "bmc_factory",
> > @@ -309,6 +453,10 @@ static struct image_load m10bmc_image_load_hndlrs[=
] =3D
> {
> > 		.name =3D "bmc_user",
> > 		.load_image =3D m10bmc_sec_bmc_image_load_0,
> > 	},
> > +	{
> > +		.name =3D "retimer_fw",
> > +		.load_image =3D m10bmc_sec_retimer_eeprom_load,
> > +	},
> > 	{}
> > };
> >
> > diff --git a/include/linux/mfd/intel-m10-bmc.h
> > b/include/linux/mfd/intel-m10-bmc.h
> > index f0044b14136e..c06b9d3d1c5d 100644
> > --- a/include/linux/mfd/intel-m10-bmc.h
> > +++ b/include/linux/mfd/intel-m10-bmc.h
> > @@ -36,6 +36,37 @@
> > #define M10BMC_VER_PCB_INFO_MSK		GENMASK(31, 24)
> > #define M10BMC_VER_LEGACY_INVALID	0xffffffff
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
> > +#define M10BMC_PKVL_PRELOAD_TIMEOUT	(M10BMC_PKVL_A_PRELOAD_TO |
> \
> > +					 M10BMC_PKVL_B_PRELOAD_TO)
> > +#define M10BMC_PKVL_DATA_TOO_BIG
> 	(M10BMC_PKVL_A_DATA_TOO_BIG | \
> > +					 M10BMC_PKVL_B_DATA_TOO_BIG)
> > +#define M10BMC_PKVL_HDR_CHECKSUM	(M10BMC_PKVL_A_HDR_CKSUM |
> \
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
> > /* Secure update doorbell register, in system register region */
> > #define M10BMC_DOORBELL			0x400
> >
> > --
> > 2.26.2
> >
> >
