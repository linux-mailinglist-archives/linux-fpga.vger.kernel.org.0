Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA8450EECC
	for <lists+linux-fpga@lfdr.de>; Tue, 26 Apr 2022 04:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236368AbiDZCeo (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 25 Apr 2022 22:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234612AbiDZCeo (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 25 Apr 2022 22:34:44 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 644B1126353;
        Mon, 25 Apr 2022 19:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650940298; x=1682476298;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=j0mouzIh1HEv7mP+ZvbsiOS9WssKtplCOKCxQHem2eg=;
  b=RFsQnJilyw812ayzweyfGL4esUZctMzA1iNHs5AiYqJw0ttWL9PhH5tU
   WDZaYrJ7KHO9M4y5KCcyZrryGltKJAB1/nO8flGR/JQFSJzx1RwRM/OWM
   f7NBknEJYUDSbDsxNWHgA0dxUz+SWF3O6MCz8q1tQ80pllDBhVI/tKRE8
   17FENIVQmuSK06YMHdh4k7Jvxm05COAucwgjsj8gN3VPSEOzgt76LqFk7
   26+sUwX1Szwt9kQ9SLsgVZUHUIqn+7aQg6+rpVE28GiDdZbQZ099ZSRHT
   GvbdA8onnaRBs1jXjnOjQSWxkVbezlvu6GcfGLwvgHwSLci1q72bHK2xg
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="264947137"
X-IronPort-AV: E=Sophos;i="5.90,290,1643702400"; 
   d="scan'208";a="264947137"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 19:31:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,290,1643702400"; 
   d="scan'208";a="628307447"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by fmsmga004.fm.intel.com with ESMTP; 25 Apr 2022 19:31:36 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 25 Apr 2022 19:31:36 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 25 Apr 2022 19:31:36 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 25 Apr 2022 19:31:36 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 25 Apr 2022 19:31:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fj19TyiM8MDLFh+L4Ilm5chpp7ezBkZguQiLoJ415U7n9/RdNRT3emfPPjmUEv+T6EE8UMRBH/kZTjzYZ4oLGnwe3T94RDDiznQVH1SQeEyhzLgRLGJ8kAkJTHeKNf8qRHsI2fh34hdIWFTT3nXyK3SIjXzVWAviMpM6LnsYPqGexhdpeGW+zpGfO2aamaq4AIbeTWBCDHpD2yv9730gqSUy8MBQ5ISPu5AP1PjegroWj+WuLkxZkJOGn3YByVaG6PBrmDannUWrYazh3C6fvc5gSTByB/ro1e03vyz/wgSGj9GCWFBELYcSmSaE1CAFGsKQb7Rzvhw/+iWvvEr8/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FhXS681aJP67US3/7vbZVGOqErGdeg3rht12pMHWVrM=;
 b=O/Cd11sTEWdUzPt2bQzOvhKw7OSpKnUw9xEih0n/f76K6y3pP2OCtsC3R2+oFQoYRoC8ePOZdFhErO1McvFgwpGhy/X/dzNFElyZGJXUA7Pd4lrFU6jGxAEs3owAjdytyMZjUpGsv5k7e0qoXMEGOOTsKr2AE61mgekU6KXtbplgCUfKxlh7HgXI2pzFGTWzcI4FF+8Au+1onwEIhIowUY0K0whSqEDqpGSIM2jBc77E5fxayAxh7BecOFH5nfYfC8WUlZuNSv+SUIE/Fsefiv8pu/YOw3xQkMTZ4Xr9vcIOKDDC0RtH4YneByMOAL/m9Wuk3cV2044MIyKXnxn4Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by BY5PR11MB3878.namprd11.prod.outlook.com (2603:10b6:a03:182::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Tue, 26 Apr
 2022 02:31:34 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::4838:60ae:b637:3fc0]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::4838:60ae:b637:3fc0%7]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 02:31:34 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     "matthew.gerlach@linux.intel.com" <matthew.gerlach@linux.intel.com>,
        "Zhang, Tianfei" <tianfei.zhang@intel.com>
CC:     "trix@redhat.com" <trix@redhat.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "Xu, Yilun" <yilun.xu@intel.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] uio: dfl: add HSSI feature id
Thread-Topic: [PATCH v2] uio: dfl: add HSSI feature id
Thread-Index: AQHYTjZdBoHDFBYOuES9CQIlYPGclaz06tqwgAKlRYOACf1WkA==
Date:   Tue, 26 Apr 2022 02:31:33 +0000
Message-ID: <DM6PR11MB38197992351E559308C8F58185FB9@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <20220412062353.53984-1-tianfei.zhang@intel.com>
 <DM6PR11MB38190E6EEF6DE3EB900290C585F39@DM6PR11MB3819.namprd11.prod.outlook.com>
 <BN9PR11MB548330FAA7EF6B9DAC2F0E76E3F29@BN9PR11MB5483.namprd11.prod.outlook.com>
 <alpine.DEB.2.22.394.2204191048300.5866@rhweight-WRK1>
In-Reply-To: <alpine.DEB.2.22.394.2204191048300.5866@rhweight-WRK1>
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
x-ms-office365-filtering-correlation-id: 13c07491-ab4c-408b-8174-08da272ce153
x-ms-traffictypediagnostic: BY5PR11MB3878:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BY5PR11MB38782AD926AADD83A19FA45985FB9@BY5PR11MB3878.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bl8uKgfshSXZON/zH1NSiY7xD88gB1YI4H1FkQNO7A7xFAi+HrfFEMnBaATBHuXkTEjLRwHuYy8PC9PiOAQzqRWPrWcQft7FdzUkRwTBAPCBnbNWRumeuzM514pa0RGV/zCOGG67rzFjaTan5VyWyhR97RtCT9+qxhCYFK0XQMOp/emffabfZCOfcRQtk6g4EMFUehu6gY7EDodEblap7WnMjuLAt/ftortvNMhSBCgD1g3voCHs5IltxrRKZHwrjWdb/rru/Jyw5O/vIBDkb9hdqKsXDfoWvp0zkmQNFuzFxhkAeOZr4EiDMlvmigG56D+++Q0D6A2xwsxIprlBVGf3jZQOrJIYRawwTGKo+iYOFgTr5v68MsoXnpMPFO62yhXVVd6fhav5Yop/omqgNVn1WNMN1SPclT08hAvm5DwMdRZcjgN8gGoxyRchztx1iqlkUHceiLmUfti637DlkOmGA+BsbZgTQjk1e0aQD6yD//zikEjLCrAwje5Td2OxCCHva7OssYTKwZsFzpzfaa8zsnPkQ3uB7BbTLu4Ar8/xk/WabUFlXlBX8KQwj69pq5mN94mrzkUm1XfC/akB6vLmSvRmJmK6JcbGfOHb5HXwfBTeiAARzC7vL7uYwmGLVY5viXJp2gVnX9kT3eIWEJ6kGRtC6AMSJymxdevWRrBNV+a7BrFM+el1QROlT8T5mfImRh1LdnqNDLJqbjAVuKteJOLBTITZrr/KiX9+ZseQIWibdfRdSuyzTfFZ9fbdKJHs6OP2aWWCykPiWw2YTaTIXz9bFIoqWLYM7U8YtsOZTkeoAEtTUmIZVHeXH/te
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66446008)(66556008)(64756008)(55016003)(66476007)(86362001)(76116006)(6636002)(7696005)(71200400001)(4326008)(5660300002)(66946007)(186003)(83380400001)(38070700005)(38100700002)(8936002)(316002)(966005)(508600001)(2906002)(8676002)(26005)(110136005)(54906003)(122000001)(9686003)(33656002)(82960400001)(52536014)(6506007)(53546011)(21314003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4HXTOF1YoKxqflIk/T61er7DTtfZBc57nRryEAXEDOwWVWVyJB0hha95BJ+X?=
 =?us-ascii?Q?em2X4gYLHNEVbiALOS1CBYHAzrRcgX8awvL9YP3nGf5HxtjilKLykT9Q5g5Z?=
 =?us-ascii?Q?G6wa5M46hiThZGjK8jjqvYa70ytYLbVLKKVweWXEBVGcYVrHhEluYV1DV3mP?=
 =?us-ascii?Q?8C2CQZBZyl9ASiczayriyLpoA/sIEUnHXVXcqjeMhhFG0FVbphCQjS2lMkQ/?=
 =?us-ascii?Q?h+qLU+VMzLdUuhVcaE/0InnuAxdYVKkkM5RGCKATPdGR4m14JhmyUWQ7N5kG?=
 =?us-ascii?Q?p3It3YWfu101YWBJAcN/URgRNdJyYJR3D3heDKXYX8j9Di7HRqItNtxo2RAk?=
 =?us-ascii?Q?eHA+UWl7C+ElsbyPTXR7UN3vj/8ywuaX4LyZFrie3Jgy6utdstlBhc+YS5cC?=
 =?us-ascii?Q?jG3b6J2RXXEtjh3k6r4bHhiLJuEQ3jYTQEHuIV8l+kTi2OiKVqLhyijSwqhg?=
 =?us-ascii?Q?vAeXWIXvJnYUX3WnPDMZpupWRBQmWir4V5GDNHJ9QtKkoDUwmduXPyoeSsZU?=
 =?us-ascii?Q?1KivLEid/nPxxM04uuFNv2Kk0NJl6H37dkIzL9u0Psj9GHlCWYUAkNKn6w9L?=
 =?us-ascii?Q?PtlZFsgT84IQGEoDwqjrQ4nNsA3FeD+9+6WnS9q0c/DiYuXUqp359dsn1yqP?=
 =?us-ascii?Q?R8AlyNxlXzHYy7TKn/IaTpqRxwrApPDXw+I6WiGUJ2X/ZRxgD2tke46RatxR?=
 =?us-ascii?Q?Chohu2++X5Dmbq2d6jFqfv6+xha6uZcL1gDmzg6zV3NB+/eW0hAdUy2y5KMt?=
 =?us-ascii?Q?/BzDd9S7sxQJtfXaw3n53UtDp6/06ErP4ik4Q5KFgiBcYQBTZR1UOyg0j7z7?=
 =?us-ascii?Q?p2AKGcyGtYRV5f6AIN5+gUe/tW8NuSgZhgKIdlB+5FtcdmXoXbC5zKnK/I9J?=
 =?us-ascii?Q?z3wEeeMYPKZvIeXECVPRdMtDVdpryNfrEfXc0C25sTEGg7r+LlBSb6IfOZH+?=
 =?us-ascii?Q?v0Y1SQvVIkeFGM00MUnvIY9kFtTv6awO1jjcKDj6jejGP4VbGVSTq56gWYse?=
 =?us-ascii?Q?p5Oo46XIV+rmHDgbybRuNphu7LOn7FDXu3Ng6J7y435nUkyUMxeP+mtTgYrd?=
 =?us-ascii?Q?FRA3mxwonYk7lfw0a6sLUgImgO0iPJQeQEnxzpMn92ZRsf2MHCIQN0xFm3Tk?=
 =?us-ascii?Q?DbAImCA3Zkp3mSIp2YHVESMve270ofNflJwkDCI2Qg+nEeAFCM1XZiofQxGJ?=
 =?us-ascii?Q?VDiTKDXwu9t19wplZjoYP+x48P3AazPsQ5NP/D9dT6vuaIc2vpzgbq8Ziylu?=
 =?us-ascii?Q?Oem90eH9QhtpNvBrDYjGs+HR+iidma6rzSaA04EQ00SR9pr7+Vbtk1P0p7nh?=
 =?us-ascii?Q?Empirg45K2+BFqqgY/U919zsaAT55lQgI2KAy6L2qsBFzCTq5MHiAfdqaRIY?=
 =?us-ascii?Q?ejcZHbOL6UD661HzF0obuk/j9iM9o29u3yaGopi6ONjpA+1SqBR+nWPRtYS1?=
 =?us-ascii?Q?8nc7Ek8on7xh9zKorLVtZ+Wrlc7redrcsSmpeiOViIWdJl9vObwB9cwWNQhk?=
 =?us-ascii?Q?jiAjb7QkGSeGesu57AmUcL1++597V4qOVzCuJPk0MOkWaTQlW7jADo1Zfdc9?=
 =?us-ascii?Q?3OHR+9OPUa4mn3VvqjRr+uitaki5iBqPmqGjGBFiiJMsbG/Oz4PjegVaBHCU?=
 =?us-ascii?Q?9fspKUO4S9JX02eFAMjS9H2xgQqBEukOSk13z4Zat2av/7tlt3wYciZeh683?=
 =?us-ascii?Q?SU6Vi+b2xEHWZAwU911+fGf0EWLVS39/AS5pJSY+9tS9Cw62V9tjLk3QLojg?=
 =?us-ascii?Q?PL8Wp7c3Lg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13c07491-ab4c-408b-8174-08da272ce153
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 02:31:33.8580
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BBst7C+Nmv4DnUKKLgGp9cwIQV+AFrCVtiz6sMhlclX6PI7JinolMmY5GkO40brEUpw5CBFQS478l0wGfxH6cQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB3878
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> >>> -----Original Message-----
> >>> From: Zhang, Tianfei <tianfei.zhang@intel.com>
> >>> Sent: Tuesday, April 12, 2022 2:24 PM
> >>> To: Wu, Hao <hao.wu@intel.com>; trix@redhat.com; mdf@kernel.org; Xu,
> >>> Yilun <yilun.xu@intel.com>; linux-fpga@vger.kernel.org;
> >>> gregkh@linuxfoundation.org
> >>> Cc: linux-kernel@vger.kernel.org; Matthew Gerlach
> >>> <matthew.gerlach@linux.intel.com>; Zhang, Tianfei
> >>> <tianfei.zhang@intel.com>
> >>> Subject: [PATCH v2] uio: dfl: add HSSI feature id
> >>>
> >>> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> >>>
> >>> Add the feature id of the OFS HSSI (High Speed Serial Interface)
> >>
> >> We still don't see any description on what OFS is here, or will OFS be=
 added to
> >> title as well? we don't expect another submission with the same title =
but for
> XXX
> >> HSSI again.
> >
> > This name of HSSI module in dfl feature id table is : OFS HSSI subsyste=
m.
> >
> > How about this tile:
> > uio: dfl: add OFS HSSI device id
> >
> > Add OFS HSSI (Open FPGA Stack High Speed Serial Interface) device ID in
> uio_dfl driver for Intel PAC N6000 Card.
>=20
> Hi Tianfei,
>=20
> In the Platform Designer tool, this IP block is referred to as the HSSI
> Subsystem.  I think we should use the same name here.  Additionally, this
> subsystem is already in use in multiple cards; so I suggest dropping
> any reference to a particular card.

The only concern is that there are 4 HSSI in the feature id table.=20
Without any prefix, it may confuse people.=20
https://github.com/OPAE/dfl-feature-id

>=20
> Matthew
>=20
> >
> >>
> >>> subsystem to table of ids supported by the uio_dfl driver. HSSI
> >>> subsystem consists of harden/soft Ethernet MAC to support various
> >>> ethernet usages and PCS/FEC/PMA direct modes for non-ethernet usages.
> >>>
> >>> We leverage the uio_dfl driver to access the HSSI subsystem on user
> >>> space, because the HSSI subsystem was designed for specific purposes
> >>> and does not fit into the standard MAC and net kernel subsystems.
> >>>
> >>> The Feature ID table of DFL can be found:
> >>> https://github.com/OPAE/dfl-feature-id
> >>
> >> Why you put it here? even this link there is no more descriptions to
> understand
> >> what it is. Or can be removed here.
> >
> > Yes, I agree, I will remove it.
> >>
> >>>
> >>> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> >>> Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
> >>> ---
> >>> v2: add HSSI introduction and the git repo of Feature ID table.
> >>> ---
> >>>  drivers/uio/uio_dfl.c | 2 ++
> >>>  1 file changed, 2 insertions(+)
> >>>
> >>> diff --git a/drivers/uio/uio_dfl.c b/drivers/uio/uio_dfl.c index
> >>> 89c0fc7b0cbc..660e1d0bf6b9 100644
> >>> --- a/drivers/uio/uio_dfl.c
> >>> +++ b/drivers/uio/uio_dfl.c
> >>> @@ -45,9 +45,11 @@ static int uio_dfl_probe(struct dfl_device *ddev)
> >>> }
> >>>
> >>>  #define FME_FEATURE_ID_ETH_GROUP	0x10
> >>> +#define FME_FEATURE_ID_OFS_HSSI		0x15
> >>>
> >>>  static const struct dfl_device_id uio_dfl_ids[] =3D {
> >>>  	{ FME_ID, FME_FEATURE_ID_ETH_GROUP },
> >>> +	{ FME_ID, FME_FEATURE_ID_OFS_HSSI },
> >>>  	{ }
> >>>  };
> >>>  MODULE_DEVICE_TABLE(dfl, uio_dfl_ids);
> >>> --
> >>> 2.26.2
> >
> >
