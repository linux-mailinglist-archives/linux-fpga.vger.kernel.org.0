Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54E6D51B818
	for <lists+linux-fpga@lfdr.de>; Thu,  5 May 2022 08:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237446AbiEEGl1 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 5 May 2022 02:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237351AbiEEGl0 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 5 May 2022 02:41:26 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107C71A3A7;
        Wed,  4 May 2022 23:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651732667; x=1683268667;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bR5QP4SZ/llnksGKUl3tRe021IzQ8hlGge0HlIZJAO0=;
  b=czAGh96uLR/jj66PLqvae5KkcqsL48pgYH7NvFG/68WUlu0grP4uBI2f
   Ki58a0DLIgfJYWH/KZqCv8TngeinG3+hxD8OT4VxbxKkGP6mg590CUMT6
   Lu3hrBSHQssR2oy3aBQmD43/h88RldZluut8FlttHwXfQk7hJ1dC9W+o5
   nflQk3eFk0xlKoG9YpMqEypu2PzHpudxQt2DWBtiyh4E4vwn+U5GTe1ft
   qw1b4XIiUWP5q/fZOQxc9lwByRtV8Is0wmiI3wRqwExEtyCKVtinMOYLx
   g3uHE+L0ENWelaKYGAeX0PqaKGxHFxYUF1pVC5n4M6M3ddJYi9t8UFWmq
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="266860301"
X-IronPort-AV: E=Sophos;i="5.91,200,1647327600"; 
   d="scan'208";a="266860301"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 23:34:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,200,1647327600"; 
   d="scan'208";a="891202877"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by fmsmga005.fm.intel.com with ESMTP; 04 May 2022 23:34:58 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 4 May 2022 23:34:57 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 4 May 2022 23:34:57 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.102)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 4 May 2022 23:34:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D1iieCAYI/8b1jQwdPZcDBbep4N+v6+jBrYRNDTmGOgIZZHV0AfqmV+hdt03lOu7OWHzUYBcuIzpTCnBaTrJBlctb92uf5NbKSp1UJvrESN6Gwve3XoQByxEKuhYfFrQrL7NQFWNQGf4jgbpdLvTaGGrXPC2LFmv91oLISpUbsQt0ltP39nBeGfVKNzGTVgjoksLJ37fta0TCo4Iyig7Se9dbp9OzIJJJGmDk0lFuw/N1mNkaCCxwgd1geR9bATrIRGGZf6pOCiyXj1BsXlx5UO6qkUvELsZe/1cUF7gALO8/WvOgOmn1ELd+KAiLcNv6jiWJZ7S9I1PCvGRUJJIxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TEL9DTWyAgmEeKc+JJT3MyLlXsuPcWAsNL/8RC2QFOc=;
 b=FYRONtuNkwiEiAg/F09TrsexeHCLjGsBVw91+IlFNvwsAPGgMIqIzzfODg//JHgEOLYKf1HYnjjvGcg2cBrUjGTP14gI/NEtFg7w+QhKJrcEu9GymTXFAley2U8fhxdOVems4oj7oBuOEF0HVlV7UucX1fs/aMfnGhKhkvn9Tf9uDKOCGNZQ8/34i3pWlr/GTtqmLis1XN0Plu7iJ0Cuoy9M8C5SEG9f94BdVXdTWz/lIg8jN9pFTZzrzhHx1gidbjIctNHtf5uURlTILVX3DU8jkqZxhYJApDFJT1GFRXd95xlu8I7V8KDkStW3m8lLb36JRQElVgrAsnJquVkK7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by BN6PR11MB1746.namprd11.prod.outlook.com (2603:10b6:404:fb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Thu, 5 May
 2022 06:34:55 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::4838:60ae:b637:3fc0]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::4838:60ae:b637:3fc0%7]) with mapi id 15.20.5206.025; Thu, 5 May 2022
 06:34:55 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     "Zhang, Tianfei" <tianfei.zhang@intel.com>,
        "trix@redhat.com" <trix@redhat.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "Xu, Yilun" <yilun.xu@intel.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Matthew Gerlach" <matthew.gerlach@linux.intel.com>
Subject: RE: [PATCH v4] uio: dfl: add HSSI subsystem feature id
Thread-Topic: [PATCH v4] uio: dfl: add HSSI subsystem feature id
Thread-Index: AQHYYBXhbDfzmBtOIEy5kNhTwRg2C60P0h9g
Date:   Thu, 5 May 2022 06:34:55 +0000
Message-ID: <DM6PR11MB38197DBE27837090E0C9165985C29@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <20220505001628.681226-1-tianfei.zhang@intel.com>
In-Reply-To: <20220505001628.681226-1-tianfei.zhang@intel.com>
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
x-ms-office365-filtering-correlation-id: 01f2419c-736c-4efa-2e79-08da2e615e6d
x-ms-traffictypediagnostic: BN6PR11MB1746:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BN6PR11MB1746749014AB755661BC79D685C29@BN6PR11MB1746.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lPXrRdAfC9ChBs18qhkhMbDa01fx21jNTxsZkuiPukNt7yirA79Gj373PGIC9zdP6x9gZgQLdnNqbmvrCJstOmrmLDULcZsgnqKHM3l/lbpwhhuO3g2LsOptl9avFqdRp8R3bsP8Rh2T1LBp9CJYVgSBiIG+T1AoUgtQTMy0Xg/yRRK+Fv1nGKUIZ5CS1FHnpN9SlUKQkA4xP9QSBhv5Ynx9sSkC47oAvA/G/3mg7jq9XxDHyyLTrPRZfYLkvneBevuiUBHjBKWEBxUV5CiyotX+7lWP4eThEbO5HG4MBMi4KSeY8tanMywqg7F6OKWLV0XWw1yszibYDC6h4E11jQ0QOfKcizTMHqZ66tYkVU90Q9byQ/K1GDzZWMex9Pv4WIyDtFHyosDEc18ur5pC/gMOvqR7lbGK0CofbhT7KOegFrOrzjIHYaQlY6vmKgYg44p0mgS5VGwiJ7u9oNmGeWZlUGkekfAmxX0uO/nvYLehgCOPHzjGmr8qUFJeS6f4benoblXtOic5k7lsyn7havBxWBm93nySRbi6G7UqdgF0GeB3MEiznf48CTLu3R5vtDU9SFGJ1is3pyYYqsninV+JMHhtSSVPkxMXT/VOk0quXoC35YXezGOlAdP7rPN65D6OJ9Mjt3FQ0n8a9V8bCW7ohO7b6iIimkk+Pyy8bX2goAMBvU5sbelEGDTISGABYJNTjE0wuldH63bBBxcesQt4DQtu6svYZghNSfshCL687BIHxwjDVA9o5SiDSGp+SET+8pFVSyJKwrgFszI/TukUUzcue8BhL6FlpFdgK84=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(53546011)(6506007)(26005)(38070700005)(7696005)(38100700002)(122000001)(86362001)(9686003)(82960400001)(186003)(33656002)(66446008)(66476007)(316002)(64756008)(5660300002)(83380400001)(4326008)(8676002)(66556008)(66946007)(76116006)(52536014)(55016003)(2906002)(54906003)(8936002)(110136005)(508600001)(71200400001)(966005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?O0TqLGDBHy1T4X4HvgJSoCPsEFkfbrfcErpsYuWY6f2d9vo+d2X+bM+unn6B?=
 =?us-ascii?Q?gJ/Gm07kdjpRH29EpuZEHus86Ux/ZtrZfe90aUgB72dtNwOXyrbK3Jnx5sCD?=
 =?us-ascii?Q?BFBXxo9y16T/Pt3/wLwyzActQaNYWrVoGTT3BBW9f1qK9xLY8R+GNIVxLUNj?=
 =?us-ascii?Q?ammwU1XhuhvK843DoRbicCmvJdwNnUDXyW5jTg82Wep5RRWVuIUxkDogklTa?=
 =?us-ascii?Q?c2ZriLlxwU3g2Ujp8zGud1I0BSDw4vVWMyG+sj8u1BsOP61MDBLdfriNG887?=
 =?us-ascii?Q?sAws2QIqqtYGNKAGqDTGQfH174iuEutgGLr55uFeLTutLNkQdc+KGZNdDtk/?=
 =?us-ascii?Q?FUpZ+MyS0UfIPc+LA+BhuwSKYMMBrZc18NoQ0vnBat0ruB/Fe2Z//ElUo0hb?=
 =?us-ascii?Q?VsDUb6yXyEWOxyvDepwnsR4tFtGcW5yuJUxGYyuhgPJ5xTzWz/Yft29HMyk5?=
 =?us-ascii?Q?QMPbSeip3Iu5OhUZYcMYjxPJMUFDA+pt06iWFcHZqNwtaBdcAB1PjCOf2O6q?=
 =?us-ascii?Q?0eyqEz4pLUJCJDaODjGcPCqqhiiV2FO5jgls9ukjnCTKkb1VPjAI/Ny8Ko19?=
 =?us-ascii?Q?x6fR0XnIpP7d4RJo50Y4i0QwSUvbMS3ZOiAJEB1PJBnokmLfVay4pBREeNur?=
 =?us-ascii?Q?ch5HhUo9Go4CzDA1PWbtRyP01kJsL/9n+9RT56M4zQzfV6fFmYiOP7drKZDn?=
 =?us-ascii?Q?iq9+Ocyn2njBRvAD41UiD+eVJ52xJzxv2m3mhfHTn1+IF0sVzh5vKURrRfjn?=
 =?us-ascii?Q?9X0DNXVZ4QYmVid0ihm/VMOA4G9/c0qUb5Beehb0IjCRHT1fpbtfZ2q9Sknm?=
 =?us-ascii?Q?PBpNBMcgs3SNY5g6j4Cs3gREE6FzVONPnbtbalTqqGjXrT1iGutL8gPXXdHS?=
 =?us-ascii?Q?WoTPtd8Oj5otMNR+oTf6yanPhoI8U29mM5TUJwjf/PdehFvPCrRGjg9f4uLZ?=
 =?us-ascii?Q?n/vKEwhomIAsPVzNWMQzlEcEH4wDvDFJmWzYts/kQ5bPux5d8SSdf7J6groq?=
 =?us-ascii?Q?XjDQ7N8UuUHlreZLqA4JatS7UwDisTCaAoQkku4P1LB6oCh9dE9MDtw6NwMR?=
 =?us-ascii?Q?M/RPpZ4rBhDRgiolG670MychGHybhdEu9erfb2fzEbqbONJbiRC1rsMlVsjj?=
 =?us-ascii?Q?Y25KYrzZByoeQJeP+2jtHIBjCRz2KqiPuHwhZKzaOW+6B2Jslm/3UXOj3ZFO?=
 =?us-ascii?Q?dSbLMaNOalwbJhliuuDvoZaVPjmzBNKHkc8+q8JinL5wFRSfDTTlyqZy8/II?=
 =?us-ascii?Q?U7+vXOGtan3sV0JhEtRa9JpYj7UcaWPOSYbjXIjpXyAV9x+REqZXwHInOTGs?=
 =?us-ascii?Q?6xUrsj5r9WaQ6HQnCEFA4Woiw0JG0q7mDA5YaimlHSiN1yU/zfS5Ze3fzU3Y?=
 =?us-ascii?Q?dCDUrHPUvTgU0hgDrBGchm47jkkGOWV00y2zvS7z4G9/C3uASRbKHcn2R+pl?=
 =?us-ascii?Q?+oCGMnqA9xCqKOc8F9c46teEzM3u0WG1A5DLw8D5bHmEOOR/oZFDRRV2xOYB?=
 =?us-ascii?Q?62HgMpKsLJmi5k6GMbNH+Zu+DKe5Gplj9ibo+aNFYvNluktBEtwTvK9pxVv9?=
 =?us-ascii?Q?uWdD9wNAOeDAjs3Y+FUq4oxoBiF2y512nGMT40sY/9mo1ZM9eAO+Nw+JbxF6?=
 =?us-ascii?Q?+bFTPhqLYWibjIAy6idnBTzLrLlLXB4SMMwxTft+Gek5LRhAk/NBdH9HZYuK?=
 =?us-ascii?Q?R2xVdlYWHYtfmHX+gcROKu0GWz/iesxf1MykwtgmPImFiLjh3vCQBAvOYI8c?=
 =?us-ascii?Q?ddjEKgPe+g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01f2419c-736c-4efa-2e79-08da2e615e6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2022 06:34:55.7109
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w7Q35UUY/p8iWsN1iV2TMd3hIYPuUWAw1vIHwr8x5ZlBfsYrcWxO5mHIpAM2q6JCe3p6jkvbwConOAxEWxOFeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1746
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
> From: Zhang, Tianfei <tianfei.zhang@intel.com>
> Sent: Thursday, May 5, 2022 8:16 AM
> To: Wu, Hao <hao.wu@intel.com>; trix@redhat.com; mdf@kernel.org; Xu, Yilu=
n
> <yilun.xu@intel.com>; linux-fpga@vger.kernel.org;
> gregkh@linuxfoundation.org
> Cc: linux-kernel@vger.kernel.org; Matthew Gerlach
> <matthew.gerlach@linux.intel.com>; Zhang, Tianfei <tianfei.zhang@intel.co=
m>
> Subject: [PATCH v4] uio: dfl: add HSSI subsystem feature id
>=20
> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>=20
> Add the Device Feature List (DFL) feature id for the
> High Speed Serial Interface (HSSI) Subsystem to the
> table of ids supported by the uio_dfl driver.
>=20
> The HSSI Subsystem is a configurable set of IP blocks
> to be used as part of a Ethernet or PCS/FEC/PMA pipeline.
> Like the Ethernet group used by the N3000 card, the HSSI
> Subsystem does not fully implement a network device from
> a Linux netdev perspective and is controlled and monitored
> from user space software via the uio interface.
>=20
> The Feature ID table of DFL can be found:
> https://github.com/OPAE/dfl-feature-id

Is it possible to have multiple different HSSI implementations?
Will they share the same feature id or not? If yes, why uses a
generic name here?

Is it possible someday this feature id is marked as legacy not used
and introduce a new one as the same name?

>=20
> Reviewed-by: Tom Rix <trix@redhat.com>
> Acked-by: Xu Yilun <yilun.xu@intel.com>
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
> ---
> v4: add Reviewed-by and Acked-by tag and add Feature ID table url in git
> message.
> v3: change the name of this feature id to HSSI_SUBSYS and rewrite
>     the git message.
> v2: add HSSI introduction and the git repo of Feature ID table.
> ---
>  drivers/uio/uio_dfl.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/uio/uio_dfl.c b/drivers/uio/uio_dfl.c
> index 89c0fc7b0cbc..8f39cc8bb034 100644
> --- a/drivers/uio/uio_dfl.c
> +++ b/drivers/uio/uio_dfl.c
> @@ -45,9 +45,11 @@ static int uio_dfl_probe(struct dfl_device *ddev)
>  }
>=20
>  #define FME_FEATURE_ID_ETH_GROUP	0x10
> +#define FME_FEATURE_ID_HSSI_SUBSYS	0x15
>=20
>  static const struct dfl_device_id uio_dfl_ids[] =3D {
>  	{ FME_ID, FME_FEATURE_ID_ETH_GROUP },
> +	{ FME_ID, FME_FEATURE_ID_HSSI_SUBSYS },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(dfl, uio_dfl_ids);
> --
> 2.26.2

