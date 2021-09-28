Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF34941A746
	for <lists+linux-fpga@lfdr.de>; Tue, 28 Sep 2021 07:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235111AbhI1Fw6 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 28 Sep 2021 01:52:58 -0400
Received: from mga02.intel.com ([134.134.136.20]:49252 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234207AbhI1Fw5 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 28 Sep 2021 01:52:57 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10120"; a="211873744"
X-IronPort-AV: E=Sophos;i="5.85,328,1624345200"; 
   d="scan'208";a="211873744"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2021 22:51:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,328,1624345200"; 
   d="scan'208";a="654993938"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga005.jf.intel.com with ESMTP; 27 Sep 2021 22:51:18 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Mon, 27 Sep 2021 22:51:17 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Mon, 27 Sep 2021 22:51:17 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.46) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Mon, 27 Sep 2021 22:51:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b86YD4PLbp9kKbSgPCafHm3fpsD6TJFohsMnq8Mk7VRQ55uKzPwKOyqbethc1JG3DulcHgG1hlbLYSxV18ltdM+teDH9lM7ZUoYL01s8zPXwr+LwCB/wzP9mE8L/886sjUVPzq1lqRUpurTNgnVbUoxEXYnT6Uq9rBsDC/u8/v2bpD93AFxbdXOePtMRT8kaFQBWWSeSzo1sCGtpmxnxM67NU0eC+EJVJ68jhMyLwWuZWHvoveXsmbLk7eX+1nNXEa8ip0dsyolMLZgdlavXRWAuxxqGqR+czeyBuPG7BbhzDAPyS/K9R/KcAQPeUjOoCiKYwJ7SEZ2bRNiyI06dhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ICc84RcG06/V77A25HKGU+AdRo1n7PSyyH3DrlUt+Uw=;
 b=FHXRUj7zrLpPwSG76T4F1rdHGkeR/NmS+k0ts9oUQr8WZgdgz+nLqnsODk4TWHuFHI4Rjz5CgIsvK2rEOnYx8HjbVClIb9G3y+q1qqNIlbM/5kcIIhCJRRaf/dtubfqTZGBqV6R60Nqpw9bYd0bus0rm2rO5gLPdfBnKxg5jDeFo1m57xNceVHGwdEn4IdiRjqt8+RMlq+YP3JrL0jAKS/9skvYUETYoG9bni46PQ9saS03Ma6owh2eZzhEq4y3q5uH/iNwVtCcpIO7xr6pZo/c5mmaSufEp0SYJHKBDFFjaXKOsBZewfDn491xcCZFhM5WjAsI0sCtM5IY5LnCqmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ICc84RcG06/V77A25HKGU+AdRo1n7PSyyH3DrlUt+Uw=;
 b=tyvNNFKygDPlofjUPF7vWpF+vSLZf2aIoMx3ODICotTdWldnrCgLFaCWhN78ntDSjSb8hAbZczvHzSEYSmJNCErP018sY3w0hor5OJytCKBBBVfIWkk2Y0R6EtY5R8AtixnAWjkF3KCBysA3zcFtrOxptSTACcjwlyAQXBo2MWU=
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM4PR11MB5358.namprd11.prod.outlook.com (2603:10b6:5:395::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Tue, 28 Sep
 2021 05:51:15 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::ed01:8536:290d:caf5]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::ed01:8536:290d:caf5%3]) with mapi id 15.20.4544.021; Tue, 28 Sep 2021
 05:51:15 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     "Xu, Yilun" <yilun.xu@intel.com>, Moritz Fischer <mdf@kernel.org>
CC:     "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: RE: Maintenance of Linux FPGA
Thread-Topic: Maintenance of Linux FPGA
Thread-Index: AQHXsjyxWI92NXXQJke10PZtKEX98au1zsOAgAMi8HA=
Date:   Tue, 28 Sep 2021 05:51:14 +0000
Message-ID: <DM6PR11MB3819F88491118D3F6E22D35C85A89@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <YU9s27qwyzmeONiq@epycbox.lan>
 <20210926054449.GD806603@yilunxu-OptiPlex-7050>
In-Reply-To: <20210926054449.GD806603@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.200.16
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 996655f4-e630-4ee0-67f4-08d98243fbe3
x-ms-traffictypediagnostic: DM4PR11MB5358:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM4PR11MB5358482EAC514C5EDE32226585A89@DM4PR11MB5358.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /ZmNCrFM6NCk0GTvz7szneSDQOkpFXX/E3PNRUUGGmj2vmmszvlbSmCcmCw1d9ST0Iqe5XM+6mM/QnK9062WC6YC2QEsWBdSUPq/3jDnVXCLEyyvPdtE5grUMaouGHlHZtr5fVX2337I1jse8HO2mD5R7rmeMAe+rmhzMOiV9shLPBR75sIQ6Yod3GjU5qwdVfUjf3WQwfuXieF13/msww41Q/ZOa36WykUwDQrP1JQL6FZUT/5ZFGjAorayK7aoLn+MEkqyn2dP9ijE/O5jJjHDPZwPhabOX6IWiKIyMxFNehHdO/pNFXOZwVWchglt0NgmIlmBmq6CZbkSjnVpOam6nMW+F2iICA3T3jmKSWwuyaNKatbU1dKFektsvv4QANb02eGtHhSeXggebxfXlS4ICdUsxinPupp9xF1d+XSFdd87Mcl3IbNRm0ApIEHjpWjfFW0GMhlPDOeROXPLThJbkwSjSexJYmi2Rw3R9wKdW6f9kRRyFxC+JOA7UjSGsFJ26FpVMDAl+UjohOUd4wCvXVEX5aILzz4cUIk9UOLqcwby1iVwuoFsC/bPSv1+pnPozJPJyOVoqZaGMZcyT5g5Qi+m3WDlhJTZCpDQhaijfmVSDHZw8zqr3g33xO8vutYm07MdTtqjv0/r+enggLy9Cr2z7m+xyrLTZXeCM/U1IxsKtI+a5T007QCFhS4Hf2L5VVRNVyRbtW5//ZstZg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(122000001)(7696005)(71200400001)(53546011)(6506007)(4326008)(38070700005)(2906002)(83380400001)(3480700007)(52536014)(508600001)(8676002)(5660300002)(33656002)(9686003)(110136005)(186003)(8936002)(76116006)(316002)(86362001)(26005)(66446008)(64756008)(66946007)(66476007)(55016002)(66556008)(54906003)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZlMC20Md+I9XIP0sJ5k5kS7TUvxWiKJKK3DBIeE/x1Xqp1w6sZucXx2iznrR?=
 =?us-ascii?Q?NgHQr6ocTZ8yT6AP1FNLzoAd1/BFiU9divGcFgUENlA6A650qCzSR0UYAzh8?=
 =?us-ascii?Q?EtTdZ3moz17rpw8TeJZX4qD7n5M05vIU9m9bbe6og5JdwdIup2u8f5PIQdkA?=
 =?us-ascii?Q?i+zt+2FYrxIacF/euGqVLZ/4gE/vYDtTJhxemFN5/98mY5OEm9uwrM753cXS?=
 =?us-ascii?Q?tDo6OR0gQSePU+lFLwbdylN5D1+JEEjQBbuVA/Xft89SCk1l2rUmkDeKpyhe?=
 =?us-ascii?Q?zYhuEqKafjju7iDOMUde/L4+0d8x4AaOLbnslbt7ZvTZ483VjK+kVWHuFFKe?=
 =?us-ascii?Q?iDfSvZdqr/jheTZyXYgn5+7uRbvebZcUVvKplB2H18wsXeQVizsVJlpsStKb?=
 =?us-ascii?Q?1vZkb7gc+Ox5ebUSKGzbDA/HURtk3lSLeojJpK0+HuD2yW8SEAF7ScIivaP7?=
 =?us-ascii?Q?tuu1zDltqr5fzw22w0BaC1CnKqMfwC2419VRlYN459PUKfbCUIfB1EhsB1lU?=
 =?us-ascii?Q?LUi/w8Vlsu8iDfvak/Imf2bt53G8aXKaj/t99LNanI5jSGXM/SY/kCE2QZNj?=
 =?us-ascii?Q?eWKfA2INN3NWGowS8OUR2hTgkymd+YPBhvxawD6dtqMZdN0yW3VwFUr1+7V6?=
 =?us-ascii?Q?qeyPtAF9TApak2Hnt0EqPwmnILTjLpw4U4CTcNvIueG1HhyfoSrPiGbrhcJl?=
 =?us-ascii?Q?ElQFgplFbxuN7uy8DDx/XMsY6iecrHR0ff4/3MTttzo0vBAtbhlBVxfmsHEK?=
 =?us-ascii?Q?QAXA3uIwuzBTL8vVIGwmayEFybQ5x/lQS5d2FHhwpas+epRfAIyprBBVTBWQ?=
 =?us-ascii?Q?qEq5iyYKui8L3sOEwWwFNGrekeG+P/u8PNqV+JkzZOyXc/0olNAZqnLpNGXZ?=
 =?us-ascii?Q?Xq5d2np2O3DNVDVA0DmAy+DpRWn+7Q5fue5FIKXbt69QQM431rEmxHR7JT/2?=
 =?us-ascii?Q?F6Z+98By/nt08AinrZ7NmmfdboipVcyTdMPCYpI7DuD3KiG8iTgOOrH31unX?=
 =?us-ascii?Q?M9vfenv4iNwQ4Cbldqpps5H/u58dRDt+32qm0fHoPNiKF5OtfZSsakXHZoCt?=
 =?us-ascii?Q?4NIt1Kv6vmQO22OdJ5DJDZdX0CxFHHjdydkiq80/3R6HsDWRd/ufrgm9RCdI?=
 =?us-ascii?Q?ODMNaigL6Gcfq7bJz1MFHIcZJH/SV5cElZ2XMytcXO9xHbUe4CPVpyBbLUPz?=
 =?us-ascii?Q?9uBoaIv4VmpFdPI4kf2outz0Eh6GqQSxjqs9HtCOnfj/RYTEJ0RbMRemVEel?=
 =?us-ascii?Q?JPhjdUarwVc34K/gKEw4gcdSQ3CTrOhAO3WEoEffKf7nBHf2z8QSh8n4EWSF?=
 =?us-ascii?Q?YD7xFUEkk6LE4yz53MokzZze?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 996655f4-e630-4ee0-67f4-08d98243fbe3
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2021 05:51:14.8710
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pup9WlIG00w5Xg+Pzxy17Z7jHul56lPV59Q5veHTk8yUUlGh9SGjbd4chjd5EGwHL5hu1Pt1M5vNfz9wPd23Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5358
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> -----Original Message-----
> From: Xu, Yilun <yilun.xu@intel.com>
> Sent: Sunday, September 26, 2021 1:45 PM
> To: Moritz Fischer <mdf@kernel.org>
> Cc: linux-fpga@vger.kernel.org; gregkh@linuxfoundation.org; Wu, Hao
> <hao.wu@intel.com>
> Subject: Re: Maintenance of Linux FPGA
>=20
> On Sat, Sep 25, 2021 at 11:39:23AM -0700, Moritz Fischer wrote:
> > Hi all,
> >
> > I lately did not have enough time to dedicate to the Linux FPGA
> > subsystem, concerns were raised around bus-factor and all.
> >
> > Looking at my day-job I don't see this getting better in the short-term
> > so I've decided to get a conversation going on how to structure this
> > better for the benefit of the Linux FPGA subsystem.
> >
> > Maybe a maintainer team approach would address the bus factor and
> > workload concerns better?
> >
> > In terms of people I was thinking about:
> >
> > Hao has done a great job at keeping the DFL part of things going, so I
> > think he'd be a great choice.
> >
> > Yilun has been very helpful with reviews and I think he'd be a good
> > pick, too.
>=20
> It's my pleasure for the nomination and yes I'd like to be one of the
> maintainer team, to be more helpful.

Hi Moritz,

Me too, it's really a great pleasure. Thanks a lot for giving me this
opportunity, I hope I can do more contributions.

Thanks
Hao

>=20
> Thanks,
> Yilun
>=20
> >
> > In terms of how to structure this: I'm not sure just yet, open to input=
.
> >
> > How do other multi-maintainer subsystems operate? Ideas? Suggestions?
> >
> > Let me know what you think,
> >
> > Moritz
