Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 729AE504B12
	for <lists+linux-fpga@lfdr.de>; Mon, 18 Apr 2022 04:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbiDRCi5 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 17 Apr 2022 22:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235884AbiDRCiz (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 17 Apr 2022 22:38:55 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7573B186CE
        for <linux-fpga@vger.kernel.org>; Sun, 17 Apr 2022 19:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650249375; x=1681785375;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Jwfuf1ncNbs3OVwwnUuLN2dSQdjlXD3/TRE/23ITRrE=;
  b=fhTymGs40hsR6SFSaVdo4tVWurfXuodSbJos5uZEQPRxagOoPARZl4Hb
   oafWPbZN99i1k5cj6xxvx01scModQcNfYIG0m7y/99g1J8d8GqovB/eJd
   /OXvhR/kBfNF7cjKR998UaCFPrWazTuRIIiZiuCbSVRTVwHupUdSVdKrZ
   lHeZRxv9c2Cp4zuYw5wQ/Zbp80vyTwkv5WyJblYvZJLfviBQtplSvai/O
   YhrtAEELz87RjlWRpMa9IJ05QwaJX1byBPgUX52Bi7arPDYxtjcNxQ5Qd
   XCXPqBJdj0EIU6R2NjxoXCTgQpXfjWhWMJIWTckZOkFcmQTbLoMhu9mtx
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10320"; a="262898113"
X-IronPort-AV: E=Sophos;i="5.90,267,1643702400"; 
   d="scan'208";a="262898113"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2022 19:36:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,267,1643702400"; 
   d="scan'208";a="859627903"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP; 17 Apr 2022 19:36:14 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sun, 17 Apr 2022 19:36:14 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sun, 17 Apr 2022 19:36:13 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Sun, 17 Apr 2022 19:36:13 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Sun, 17 Apr 2022 19:36:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZfUbcW+AKQK0cSkkVLZPaFt4KlA0uMvO0XVPhVCx9PTln4M7Gz4O6dlJxEUoZ8jRNEV+XDdf78OJnWsr62T4Sm9J+UDMJqmldU0/a1UeUplHde1Cq4SBebqxiGNGwFA4IkDEvgd6I9HVrW5FvBsAajfjoEg0UMXAOexxuwE7BalVrRagmUpJjqQjqHJVIkKZC+XSFQ4H81RD2cvX+q20FH/HQoo91OWvZ/SwktdVKttNsUEJY6yomcwBSYfV41FiGbjmIbeIQ+jtsFE3R1EBpwyFM+7YU0trSJ6P0Izsl8/KJCUxoEa0ifV/YLdcT+8fMUVQ/TU3OV96gmpKAGrn2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PMCRvWv+mXgEGuqbC7+c/paDRp++ZSixNcnERkhdn9o=;
 b=mGUj26Ft1PvXtKmKIuG1iPsEjOGjgF8wnCtLdgfpakUUfVjK5CjlQuBuvrPy29mTpxwoUxRfSYTTJx06cvTATXdOytsrm3+sTDgHDhKJ2U2GG8Cf2GEgJDXfOQGcI0m5HyPvbSCLk1imlidH53V91+6j8oAcCHGKk3IaMwDDmI4I5wpSo06CI4fKeSwkba6SkDy6JKHA8sApKzRP4fk9tvXlKmitn3onuethTyT+Te8FZu8jNTcgm7d6o1XHZmvDMU4K1e7qWv2B+sMsh8uW8t/tRAwQW/4bdCwqVIcHG5kL5hY6yR+mxfNW585L7nkekB9i6o45CLRW+8uH7uybDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5483.namprd11.prod.outlook.com (2603:10b6:408:104::10)
 by DM6PR11MB4284.namprd11.prod.outlook.com (2603:10b6:5:205::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Mon, 18 Apr
 2022 02:36:05 +0000
Received: from BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::c076:6436:db8e:ee22]) by BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::c076:6436:db8e:ee22%9]) with mapi id 15.20.5164.025; Mon, 18 Apr 2022
 02:36:05 +0000
From:   "Zhang, Tianfei" <tianfei.zhang@intel.com>
To:     "Wu, Hao" <hao.wu@intel.com>, "Xu, Yilun" <yilun.xu@intel.com>
CC:     "trix@redhat.com" <trix@redhat.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: RE: [PATCH v1] fpga: dfl: Allow Port to be linked to FME's DFL
Thread-Topic: [PATCH v1] fpga: dfl: Allow Port to be linked to FME's DFL
Thread-Index: AQHYTxeAK+xZBhNuiEywd4yPTwpOoKzyvPYAgAIoY8CAAArksIAAC4iw
Date:   Mon, 18 Apr 2022 02:36:05 +0000
Message-ID: <BN9PR11MB5483045FE99FBC714CABA72CE3F39@BN9PR11MB5483.namprd11.prod.outlook.com>
References: <20220413091519.317735-1-tianfei.zhang@intel.com>
 <20220416161814.GC301222@yilunxu-OptiPlex-7050>
 <BN9PR11MB548365366CA105E3D05E1A06E3F39@BN9PR11MB5483.namprd11.prod.outlook.com>
 <DM6PR11MB3819CCEB3AD0E0214252044685F39@DM6PR11MB3819.namprd11.prod.outlook.com>
In-Reply-To: <DM6PR11MB3819CCEB3AD0E0214252044685F39@DM6PR11MB3819.namprd11.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: c969ad3c-f5cf-498d-454d-08da20e43006
x-ms-traffictypediagnostic: DM6PR11MB4284:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <DM6PR11MB4284F7A80D6AD5D0CB26B8EFE3F39@DM6PR11MB4284.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /Yc8RPfvys1AiD04eO1jjo5vdYOxf4Bf+gRphUku+mMG+5iFovI35k0DsyXJzOZ9K8qwQbeqJ0sX0s7WZvJo/LLXvW5buDaA7sL2j0o0LcHsO5VphlaF/Ote0WxToAj6hDi3LEBkyBoiuSX8CuK3q8hchsgcybAUmjI1BDr0BZZV5NY3enonFc5MQQEJUbLNYFH0QRA/G8m4V9NSyamNH+0bSKfOFK1Yet/n3qvPiZvvCxOa8WP0JUeFbkpEazgYIyBy+rSZjis3xkLOdrbMK21SaSYdKCL2JkMR0wuZAZ8m0aDM52MSsREasHniuO9zkLw/dTyEqPyYejxFh9PbcsO36RzqN831l7AoDAftiA27aqogCGNFPHivOIKiUwdpowZtCY+hLr6gD3o7Z3fejAAPyyu5yqBl8wlg4OVowjf28J9Bi8gAZDlvv6NAGGlyXiGRUeX3wLhl0kplSi8noDu8Wdg2EgpiFfhfMD3h8WMSNGt85BSBC77agi+R5RIH8uF7q2ZU//ZCubkTHT+4CE8wouj7n+08aAAP/28Swa2aSiOTvmLy7xrf17JUetCDAsZm/qjk6Z4tueUjpFWKE1wmtEClVeCB/NxJ/oTOCYu7b0zvwmLPcKXcB56G56zSagYo1MQKLFRz2b/kp/Ph9vzNiqNLSosR3Z072YL5MQO+VVhZ5z2sWi4Y2zELmNo4VrECZpghnBGGlYRYqwMbTjbrovpFSKJtB8YURTTBFylzf6pq5805Swh8Qe4Q0B5phkhP/ByMxINgyEyeXfMxNijagTHvOLv1Uyst1+Z3i5A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5483.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(64756008)(52536014)(8676002)(66476007)(66556008)(508600001)(122000001)(66446008)(33656002)(2906002)(7696005)(9686003)(53546011)(8936002)(6506007)(966005)(54906003)(110136005)(66946007)(76116006)(6636002)(5660300002)(86362001)(83380400001)(71200400001)(82960400001)(38100700002)(316002)(38070700005)(55016003)(26005)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Adc6mT6K0P/G2qluNb4Hk1mtOWY45q3NnqctfUP36kOoAAjfI2dM0OdaMj4O?=
 =?us-ascii?Q?Rnw/Ji1p2INJkR58t5wWBLwjj8MuaePyQ7Mz15T7KKGgD4wH9dy4OfwpQcCy?=
 =?us-ascii?Q?jr0YceCmtCUo3EVNH0Byv5s/cTFBp6x8YgCgsmh9dzDlYS3Cyf4IBZms/sja?=
 =?us-ascii?Q?HOagVUJ4B0A8TfobMF6p+pqfH/vGYHLbCXDTcFkgdQh4aVLnu2uhCSzTQFL8?=
 =?us-ascii?Q?qP3L1DkuzoVsNZWd17NXRaVk2vDuk0RQ6GFtK4osB4AngF8LSlbHPpcIZFbV?=
 =?us-ascii?Q?6taG3uGx/88EeXtoUMbR0Q2NB+rMugiaS+colA7RGvbeTdSY1mXZqyliWf4z?=
 =?us-ascii?Q?iYso1XBEgSdMupNRVOdVP4W+zCScsPdnxZ0cNfjBmcdvzGZ7DWWu8At7LI/N?=
 =?us-ascii?Q?Q4ZKRWqtmz4TmasgrXSTbx91a3mQZ8JBv2KjDwsb6HyMwBSxuOqf2y8Xhgsu?=
 =?us-ascii?Q?EkW8yNDjFIEXnUWofrSVjHmop8cX/A3Hu4XzQIEcBw6N5If2hzZ6YikDstdP?=
 =?us-ascii?Q?xk38I6ywsjZrItBwe4e/H8ciNy1KcUNbJ2NL5MTUF50xER3jCNT1a3KNZfYS?=
 =?us-ascii?Q?Ne/xzIW3dcEb0JZ9dLUlTOQbouQxcAKYP0vjVKd+FEXsROQZI6RgnNXbIjzt?=
 =?us-ascii?Q?lCIHiMLhyCRCFheRuywNgjQTnSTpgqvPpXKBlNXipvEv/w+kSmeUrksjmV+0?=
 =?us-ascii?Q?J4VRTmh3UE7v712AntK1s1k28sC8U1UmJmEIuNYSuF6OuZptfbFwtFyUILk7?=
 =?us-ascii?Q?HycIMjrsyCtDB5v6Ir5/awjlpRJq3vmh0rTrn1j+Tds4I6G5UjK5RfqDqo0V?=
 =?us-ascii?Q?zfAqltbGSi/BsGdMY35XE+GOAbW5Tr+Hy82m3/sWfPBIKYbDNQDPw18gZ8Nc?=
 =?us-ascii?Q?KM91OO6uivxAITaVYya/vd/J5VRZCMhE8L9t7iuIlVzvOcaC9d36BuhHcqYM?=
 =?us-ascii?Q?yHt2sQah+VVWXn2XNwkrO6zakTf86J2DhEi7Y2v2eym9feTewJ9JbAaNbVlI?=
 =?us-ascii?Q?qBNqk3015A7HOUfI6gb5hWDxYbmsgRluhRVbGFs4XK+cj9egUGDeF2ANO+1Z?=
 =?us-ascii?Q?OMJLaMR9diNsvSqMGd6DIXUIp8WDbZvqz1jdLKDiaeizomiEPwT07DkZFMEa?=
 =?us-ascii?Q?CIeI1D8arbMFV+4BLFXnF4zYe1kavmGe9hyVK1c0zI1xghNryUfPcy6TVD2D?=
 =?us-ascii?Q?6FcsjQkTxZI8ZlZochWhYyv3pr5rq31OhN3AyOi/b5XP7LpVfAZyC+KwAVmj?=
 =?us-ascii?Q?pbFXN6XbX38xYAdxfmVxCrAl3T8CTKQSWO54u20Ty1k0QEkDntGu6aa67PSX?=
 =?us-ascii?Q?UknrCPXjaQysTYQbXaV3SNbHENajjTN+8+4nCpNf2iY+LQzE6PRzUzNXV3cT?=
 =?us-ascii?Q?3Vfe0mpuWIVBU9NXIiuYiJjG05zZW6tInnYkIyl5ZSMULYj0qxIbTzH1NioA?=
 =?us-ascii?Q?HJwgWPRTqAt4CA9Na0UW04PvF+2KcFTMDt80rO8TizSeKkW+H6K2paaw8887?=
 =?us-ascii?Q?WRJpDhvBpzSn5MSh0I/rNPZJ2vhts3Ai2HAoVnD6j5qfIR87eEm33h1e5WUg?=
 =?us-ascii?Q?I3AeuIQNx33EAbVoqTZAj194InuxYe9rjt5bn2ke+cF7Z7FL49v1h85bq3Ed?=
 =?us-ascii?Q?5NZUGIIukWjZuZO9b7o9R0etKGjGSMDUwd2mLLcRGOuo8bFfzOW5suBbW9Mr?=
 =?us-ascii?Q?w3SM2Df0WJx9oq5wCEuTMeAadqusT4FSSjZXmuA6A5S3EtMJerM3AblZ3XGE?=
 =?us-ascii?Q?S3d4szrPjQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5483.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c969ad3c-f5cf-498d-454d-08da20e43006
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2022 02:36:05.5602
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eEFQ2wLLCn3zMpYUzxZbN5sVKZszOH29fytpViSX9VcPqkMNFXP6ZMNQx46kvPKPbZVuycsxpUufJ7SB2GLYEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4284
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
> From: Wu, Hao <hao.wu@intel.com>
> Sent: Monday, April 18, 2022 9:56 AM
> To: Zhang, Tianfei <tianfei.zhang@intel.com>; Xu, Yilun <yilun.xu@intel.c=
om>
> Cc: trix@redhat.com; mdf@kernel.org; linux-fpga@vger.kernel.org; Matthew
> Gerlach <matthew.gerlach@linux.intel.com>
> Subject: RE: [PATCH v1] fpga: dfl: Allow Port to be linked to FME's DFL
>=20
> > > -----Original Message-----
> > > From: Xu, Yilun <yilun.xu@intel.com>
> > > Sent: Sunday, April 17, 2022 12:18 AM
> > > To: Zhang, Tianfei <tianfei.zhang@intel.com>
> > > Cc: Wu, Hao <hao.wu@intel.com>; trix@redhat.com; mdf@kernel.org;
> > > linux- fpga@vger.kernel.org; Matthew Gerlach
> > > <matthew.gerlach@linux.intel.com>
> > > Subject: Re: [PATCH v1] fpga: dfl: Allow Port to be linked to FME's
> > > DFL
> > >
> > > On Wed, Apr 13, 2022 at 05:15:19AM -0400, Tianfei Zhang wrote:
> > > > From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > > >
> > > > Currently we use PORTn_OFFSET to locate PORT DFLs, and PORT DFLs
> > > > are not connected FME DFL. But for some cases (e.g. Intel Open
> > > > FPGA Stack device), PORT DFLs are connected to FME DFL directly,
> > > > so we don't need to search PORT DFLs via PORTn_OFFSET again. If
> > > > BAR value of PORTn_OFFSET is 0x7
> > > > (FME_PORT_OFST_BAR_SKIP) then driver will skip searching the DFL
> > > > for that port.
> > > >
> > > > Link:
> > > > https://lore.kernel.org/linux-fpga/20220316070814.1916017-2-tianfe
> > > > i.zh
> > > > ang@intel.com/
> > > > Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > > > Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
> > > > ---
> > > >  drivers/fpga/dfl-pci.c | 7 +++++++
> > > >  drivers/fpga/dfl.h     | 1 +
> > > >  2 files changed, 8 insertions(+)
> > > >
> > > > diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c index
> > > > 717ac9715970..6347f31058f0 100644
> > > > --- a/drivers/fpga/dfl-pci.c
> > > > +++ b/drivers/fpga/dfl-pci.c
> > > > @@ -259,6 +259,13 @@ static int find_dfls_by_default(struct
> > > > pci_dev
> > *pcidev,
> > > >  			 */
> > > >  			bar =3D FIELD_GET(FME_PORT_OFST_BAR_ID, v);
> > > >  			offset =3D FIELD_GET(FME_PORT_OFST_DFH_OFST, v);
> > > > +			if (bar >=3D PCI_STD_NUM_BARS ||
> > > > +			    bar =3D=3D FME_PORT_OFST_BAR_SKIP) {
> > >
> > > Seems the second judgement will never be triggered?
> >
> > The value is overlap, but there are different meaning, " bar >=3D
> > PCI_STD_NUM_BARS" means that the bar was invalid during the PCIe spec,
> > "bar =3D=3D FME_PORT_OFST_BAR_SKIP" means that the HW tell us that the =
SW
> > should skip searching the DFL for the port.
>=20
> So first case is a HW bug we should return error, and second case is a va=
lid case
> to skip searching DFL, right?

Yes, if "bar >=3D PCI_STD_NUM_BARS" return error is better.

>=20
> >
> > >
> > > Thanks
> > > Yilun
> > >
> > > > +				dev_dbg(&pcidev->dev, "skipping search DFL
> > > for port %d on BAR %d\n",
> > > > +					i, bar);
> > > > +				continue;
> > > > +			}
> > > > +
> > > >  			start =3D pci_resource_start(pcidev, bar) + offset;
> > > >  			len =3D pci_resource_len(pcidev, bar) - offset;
> > > >
> > > > diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h index
> > > > 53572c7aced0..e0f0abfbeb8c 100644
> > > > --- a/drivers/fpga/dfl.h
> > > > +++ b/drivers/fpga/dfl.h
> > > > @@ -91,6 +91,7 @@
> > > >  #define FME_HDR_PORT_OFST(n)	(0x38 + ((n) * 0x8))
> > > >  #define FME_HDR_BITSTREAM_ID	0x60
> > > >  #define FME_HDR_BITSTREAM_MD	0x68
> > > > +#define FME_PORT_OFST_BAR_SKIP	7
> > > >
> > > >  /* FME Fab Capability Register Bitfield */
> > > >  #define FME_CAP_FABRIC_VERID	GENMASK_ULL(7, 0)	/* Fabric
> > > version ID */
> > > > --
> > > > 2.26.2
