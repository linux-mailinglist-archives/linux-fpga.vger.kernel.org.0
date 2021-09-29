Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 481B841BC09
	for <lists+linux-fpga@lfdr.de>; Wed, 29 Sep 2021 03:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243495AbhI2BGj (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 28 Sep 2021 21:06:39 -0400
Received: from mga09.intel.com ([134.134.136.24]:65361 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243507AbhI2BGi (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 28 Sep 2021 21:06:38 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10121"; a="224874816"
X-IronPort-AV: E=Sophos;i="5.85,330,1624345200"; 
   d="scan'208";a="224874816"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2021 18:04:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,330,1624345200"; 
   d="scan'208";a="519518523"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP; 28 Sep 2021 18:04:57 -0700
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 28 Sep 2021 18:04:57 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Tue, 28 Sep 2021 18:04:57 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Tue, 28 Sep 2021 18:04:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g+0ms7lFVqta+d4WE13v71bHCXgEyZHlC/878fpFEYNFYSaLxXwoyI1b/xI0Bd+uGEfMf06Sg0nftFe6UThMJ79J0G57CI7uT1VFgU87ZeqedRDXY9GO3SZXWBoXd8lqzb7Uq48kTeFuyduTsWsmI7s0Ps0f9IKzQbP8o5LFlkFfa2exrKlNTXSaFjMbwZqlfP6mjnqWfwHKr49CWda6LngSg+ZPTdaJ3xjwrWycnq0d/sAmrroJa2cy/vszwVTkSTtjXdGPJ9CAJKupDE55RE5CBguSxlRn+g8dvGHkKK4WXfxtGPk70GJOemgznLV7qD99d5J6LuIbpsuySykMVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=NEffVyp5WWWClibKETbCebszWbqTvhtKla+EKTXnBX4=;
 b=Ltgy7S6o3g/XhHGqNIWOaOkJVsPmZoD6jXt0whh53uQUaYBcgKdMulzCba07chsO+NE32d54WigBCpgs6pfaIMBV7bySf60uyT9afHMJcmiiTCATXpo/+xdfFpicygY7KU69gq6Vp5KYIjB6VDL6Tl2pvwIvHg5N55H64xzWZlJPvGCIu+pEwILPHX9HVa/eIvlIITiUfVTRrfDlFiURDk1OBQorK9NTrEhXl8AgSipaO372QMsa0LcO1U8bb4AORF8U2F9tNhQkOD2LZr+gcwdc9XDkkNkxqJRtycVbhc5Kbd0dPKaoLAGOVWYjXdmB7SHms9dpHbz7fEFGbTB0Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NEffVyp5WWWClibKETbCebszWbqTvhtKla+EKTXnBX4=;
 b=j3PybQ/o0HaSIfnpyLXFbsDmPxm9Ov2oKiuJCNAQ4joocA3dXPYgOYiwvqeQSwCIQz9GkaTQ980OvDH5Z+Wx/l5vr9iQ7whd1k4YReduuZ5Bjmz2i+a7yna964z6xoMr+jBPVcYMtxnbHbLAzLlJne6CL86GJqwsNRzEQmiG9Co=
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM6PR11MB2571.namprd11.prod.outlook.com (2603:10b6:5:c7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Wed, 29 Sep
 2021 01:04:54 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::ed01:8536:290d:caf5]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::ed01:8536:290d:caf5%3]) with mapi id 15.20.4544.022; Wed, 29 Sep 2021
 01:04:54 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     "Xu, Yilun" <yilun.xu@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Moritz Fischer <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "moritzf@google.com" <moritzf@google.com>
Subject: RE: [PATCH 1/2] MAINTAINERS: Add Hao and Yilun as maintainers
Thread-Topic: [PATCH 1/2] MAINTAINERS: Add Hao and Yilun as maintainers
Thread-Index: AQHXtMvH96oPEu2k7kuQ6W6ChNQEMau6MePg
Date:   Wed, 29 Sep 2021 01:04:54 +0000
Message-ID: <DM6PR11MB38198AC7508C50D208281A0685A99@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <20210928150227.22275-1-mdf@kernel.org>
 <YVM0p3xrck0zriHd@kroah.com> <20210929004235.GC6179@yilunxu-OptiPlex-7050>
In-Reply-To: <20210929004235.GC6179@yilunxu-OptiPlex-7050>
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
x-ms-office365-filtering-correlation-id: 69beb592-031d-4c46-87ed-08d982e525e3
x-ms-traffictypediagnostic: DM6PR11MB2571:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB257101B60864A2EA6632DEED85A99@DM6PR11MB2571.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vIrmftfdSwLzOFr9bNTt/wHEbcLZgXvIKVh0dLE6daiXkfQHsS5Xe2D6oZqbkReAZKaN6DcEKCDEvEfjLW/GobtdbK/q6ixaaP6ncUsvOY3uTyAUqk2wAapghyBHbbA4fO0VrMVxA3369UG3XLpjGTefPu66qj47KZUYQ4LFxO1PCin5VT6LeeNr3+ee9A3rQgsG5fm1H1V9I4vHtvwBPJuvwOp2wcdpuAVVlaU83zMpeaOIOwheZzBaZ4zYEfqaHEW2gVDFwOjlysJTH2lBZxPbwMCa68J0riPxuuw9COHV2oFdES1frwyFwHz9rfQctG1ijtmN0/Cl3xHRwiksOaoiIovmycijYzoG3+BUwDCVqUdCrYhyFoOvioBIarAq8ijpHA1hDJxjMoiAvumy8pLaUTqTmEFQbhXoVrTd/zxtx0WuznrCI1Xcqgd4qCyb4rWP9/sbLiVbXqoRVvBl6FV88WHyhw1nUboc4uaGBdibC0rbnqz4Fl8EobGsCqbvAh0JUNjgmrjTd73phuBkYkw+wJPT3Mx1eSMDi1OzNxUgEL4Q9WE16ETiR0yeba9Q2SC1ZthKdKEG0w2f+MyKxMWRAqKH7y6rCW8RotIza0RAPsdyghJLIhlqWlNoO2JmSb7UcFky5R51feQmoGqJthUS+cjEfdORqztoqujZv7d2AbChuG5gCkyGf6CVtfCfQqJBlw689M1sReVNUJVVdA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(71200400001)(26005)(9686003)(508600001)(110136005)(8936002)(186003)(33656002)(54906003)(7696005)(316002)(2906002)(83380400001)(66446008)(86362001)(66556008)(66476007)(64756008)(4326008)(76116006)(38070700005)(66946007)(122000001)(52536014)(38100700002)(6506007)(5660300002)(4744005)(8676002)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7fcm9oDGZVcpHIqLR0R3AQeEOG4GwQglH9nry+WgCxdS7Xoylt9T4OhdTX2J?=
 =?us-ascii?Q?0b8unVOfe484B2EoKHeWDz2E66AOg0U0UzDkrPRexDbZq8qPmlfRpOsRBbVc?=
 =?us-ascii?Q?G371ENhrGEkrGGhca/4Cwz5kaBun3zGxhQ+mwDbUTNzq9TFcZdXjzqxKUzqV?=
 =?us-ascii?Q?4myA4ROyQrMNuwfgG+EXV+sg9LHHhL31LqAi1Qo30j6islUy7HIdjQPpTJGd?=
 =?us-ascii?Q?N5/fdfm+nWnaLd2d+cay+Pmilf0YjjlzO6LHSpV/2EL7O/wWbrErdj5Z1Knx?=
 =?us-ascii?Q?mtP5DKtUkXCQg4bkkwSI5UWfYv4GzW+JyrWXfxt9QaP6TAHSz8QdFGREVR2u?=
 =?us-ascii?Q?oYdAQxNE/P8Y4pIkZXFktBE40Ic+0dX1c8Pu+V4uqaEC9bN5DXA8WmiA+T3a?=
 =?us-ascii?Q?A7jLCPBpfBR+BHIfcX07zjoi8613EuRdAUEygXdM0EsEP6niVYCi5E/mnqun?=
 =?us-ascii?Q?PHOSgu/FLzKerTFwFyFPbvF8kwmEymEOwgBiRc9nIks+JQAp1Y7xiKGpKb5d?=
 =?us-ascii?Q?QZ3ftvogkLLcXGMGN2bNeSDPWJHhIPShdRmAG5Bt+1k30jsUhYVuWj1OYifA?=
 =?us-ascii?Q?uPKogDSwvQardrDE8AndLcg6vGMb8hffNdXtAjPaq9cQg/dWogNS5RgqERJH?=
 =?us-ascii?Q?cZksiYMj8+QqYpP/pQqFcwEbirJsmbnKCB/COlv78iun4Hx6SI5SyULMKDZJ?=
 =?us-ascii?Q?3yZMfl3LV6VpKPZRJ1GL+29Yd55AquPeSHa/9JV+Emc5yyLTZ78k/e0hY/Pa?=
 =?us-ascii?Q?w0aPek+0W6Wx13H5B54nKNSCCB9zSIFqYXXPtX7NxfHzyhP3DRle5K4FS8dy?=
 =?us-ascii?Q?iVdACBZ0LWdYUc5RhQ5U9n6oJMpGyi0OdrC1S6Drlc94mz5N01eDhL5879QL?=
 =?us-ascii?Q?QqnEgXm531Xk3go5BFtFrlhhphEXQPmvqbeBbPckhHsqcLoPBc/Ff6Phx0Kg?=
 =?us-ascii?Q?sTy3k4GK3M2Junwjis9q5m+5NjhqZMStQdf7JdvfKKad76KiIC9ZEeFnugeP?=
 =?us-ascii?Q?lgx70VxsaEYH1AZycXbQwqZXoqSi24nmoVZyB+xYDruQk4/pmo/3ZdO4KKbZ?=
 =?us-ascii?Q?Mt9acUE3YmkMP1p4XdPSe0yJtP3c/n19kmnldIYyX4CQBwPSPsKs0KTDo9xY?=
 =?us-ascii?Q?j0m//Hb1dsGK4eE2dSWe5rf49FLBCqFJIcfemaHn/odDN1oYuA3pbnnmYz5H?=
 =?us-ascii?Q?fV57gIQmdFQT6CTZGdnLs+9W2D5asa2ZWuNgB9NJwYtWiYzL4ppSEUOzNVFT?=
 =?us-ascii?Q?xtZBOdoeOkvH79pXD4u8mjxXDOOBJb1sAE+N68oy4O9CFPfaWiO32DIDbMTB?=
 =?us-ascii?Q?Zulx9HCYoC84WM//1JcbdBtt?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69beb592-031d-4c46-87ed-08d982e525e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2021 01:04:54.3176
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: If1c8V/zfchgIxpLuM7bfjrzVsSwNPtOBnH6vF0Ond7Aa3Ln01C0vgFw9a6kzo1Yfh3mFQH6FmxOPU/JRLrDjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2571
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> On Tue, Sep 28, 2021 at 05:28:39PM +0200, Greg Kroah-Hartman wrote:
> > On Tue, Sep 28, 2021 at 08:02:25AM -0700, Moritz Fischer wrote:
> > > Hao and Yilun have agreed to help out with maintenance.
> > > Both have been active in the Linux FPGA community for a long time
> > > and we need backups for vacation and load-balancing.
> > >
> > > Cc: Xu Yilun <yilun.xu@intel.com>
> > > Cc: Wu Hao <hao.wu@intel.com>
> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >
> > I need an ack from the two new people here in order to take this :)
>=20
> Acked-by: Xu Yilun <yilun.xu@intel.com>

Acked-by: Wu Hao <hao.wu@intel.com>

Thanks
Hao

>=20
> Thanks,
> Yilun
>=20
> >
> > thanks,
> >
> > greg k-h
