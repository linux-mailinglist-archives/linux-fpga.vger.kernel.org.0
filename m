Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E48F2504A56
	for <lists+linux-fpga@lfdr.de>; Mon, 18 Apr 2022 03:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234777AbiDRBKm (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 17 Apr 2022 21:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233155AbiDRBKl (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 17 Apr 2022 21:10:41 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F1F0B65;
        Sun, 17 Apr 2022 18:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650244084; x=1681780084;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=45cXmXhf986FzibEAibePuWipWPkQvohhk62VoZzN3c=;
  b=X6lR9giPKCceK9dbOGdmKrKjmvil8msKKeKmXSexcAXlixiT5D/08n+z
   5P09hEG1CSDJi34Sb+C5Kug1R82ftgdg3kgGgOBOnczljGOayZb6JkgBP
   N80CI8d1mr6S99i7dLgweIoPO4J5t/qlfPGeUOHGpb74et9OC1okTqI3g
   OcVv3KbC7kHxs5hS5NKTaumpmKoCxo1f0+Y0S1/fCgiH9T0h3d6SOWph/
   vevGFgyZtANrxN78QeVohEfRCO245pUoFd2TvDJEbKCWeb7jXXO0C6t5p
   /HP5kiZ0OoOGsa5Hl5mQs803eeOMPlWu8cI3e8mCQqsjSoXW+TBvIRz4d
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10320"; a="323870395"
X-IronPort-AV: E=Sophos;i="5.90,267,1643702400"; 
   d="scan'208";a="323870395"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2022 18:08:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,267,1643702400"; 
   d="scan'208";a="613434746"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by fmsmga008.fm.intel.com with ESMTP; 17 Apr 2022 18:08:02 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sun, 17 Apr 2022 18:08:02 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Sun, 17 Apr 2022 18:08:02 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Sun, 17 Apr 2022 18:08:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ihfgiw9Hl0UQgVYE6uMNatzrjhI4tUKofPZveGU0ke1ApDfKfhNCUsQRUITzf/7wK+SKDQ2JOZ+ONEiSrRqOghLWAoE3tyy84h1mYB0kgR2o901472CMIky0VzM+PUMi7GQ0j8f35SkmDto38Tu0lkC0jpn2Tasm6sm83DXMIgZxZf+HG46YEzJlaQ1sTvJe3VoPa6MpDjsMGISfNfNod4WfDrWvkpTH/rVjX8gFfZQEONwsx3Jzc3qEZsxQLPMm0fpsnBL73uzjCsYT10TR+8M89mPQ/LULLnnkY9pZA8Mn2Tj5fuHQ8nkRNYLO2g3oqWB9FtyyR5HKSCU3zLd37Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=45cXmXhf986FzibEAibePuWipWPkQvohhk62VoZzN3c=;
 b=E+hHpt7jg6Bua+xIz5PciArms3tyNM8GaH2ZkH8CR/B8Dgg3ek/h/+wf+icJKqHalEUKBr5HI0uj30w+rnhOwoW3sa4r70ed3q4UnsmhwEOPrz2/g7O97Pba3QDYDpXJSxM+I6hO2Lu08vtRqEDiEFCg0wOAeXvVgweXI+5cRdL3DX1LSvi5eEk5/sFfSig0+UNRaiAgLE7MBH2OMR+MLea6NCJ+3wzZNkXikfIEKdmRSt3Smc9M/ArykSZHAWwv15x47amoVOOXMWttiCLnMAZ90Ykwl8wQbiGq58bNWD5+2/iiR8MWEPQL9wWsGBjj1sNRZBt5iTdJZiuLpXUAmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM5PR11MB1804.namprd11.prod.outlook.com (2603:10b6:3:114::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Mon, 18 Apr
 2022 01:08:01 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::9973:b30d:11a6:da91]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::9973:b30d:11a6:da91%7]) with mapi id 15.20.5164.025; Mon, 18 Apr 2022
 01:08:01 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     "matthew.gerlach@linux.intel.com" <matthew.gerlach@linux.intel.com>,
        "Zhang, Tianfei" <tianfei.zhang@intel.com>
CC:     "trix@redhat.com" <trix@redhat.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "Xu, Yilun" <yilun.xu@intel.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "corbet@lwn.net" <corbet@lwn.net>
Subject: RE: [PATCH v6 2/2] Documentation: fpga: dfl: add description of
 feature ids
Thread-Topic: [PATCH v6 2/2] Documentation: fpga: dfl: add description of
 feature ids
Thread-Index: AQHYTodOzOPkZOD/wE23D/lvgzJKsqz04XGg
Date:   Mon, 18 Apr 2022 01:08:00 +0000
Message-ID: <DM6PR11MB3819201FF7ADAEEF1EA31FD285F39@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <20220412061705.53721-1-tianfei.zhang@intel.com>
 <20220412061705.53721-3-tianfei.zhang@intel.com>
 <alpine.DEB.2.22.394.2204120908150.278492@rhweight-WRK1>
In-Reply-To: <alpine.DEB.2.22.394.2204120908150.278492@rhweight-WRK1>
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
x-ms-office365-filtering-correlation-id: 00eaecb9-ea7e-438a-43fc-08da20d7e22b
x-ms-traffictypediagnostic: DM5PR11MB1804:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <DM5PR11MB18042B84E3D68020B84A0A2385F39@DM5PR11MB1804.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q18ghwfcRrRRyZ64yDw4lNxT31/jDw0uWdINplnQuaDROw9Ds9rmSX6BAk+SFooJSA+AAnfz1AII40Kpy876MJ5+vq+ZS2zzD9u/Edt3thL+6mvNfxZRSgOqe81/Jr66LzZh3xEhf/ET8Xi7Wa4b+sVmgmOWurFzCERfQt5La/3FnBZFFSd6+MT/zmxeNxAZfDia4pw+A2ujnQYIWxaJo4necdby0Ek/NNK5J959FPD0bnm1b5w2vry8NWcVLwAg1xTLmD0BtP75H0LwXoElFz7j0booHn4QsU1nEwev22NKthQVHl43XomrGod6Dj2D5VLSKiw+aF793lU7UWtO1+B+oYCwFd0/5/DPziL3/50gjYSXW1HTPaRQ9qZEzlryk1kF05GFdKrAzphLb8QUONTQlcPC2CUlykQYgtXZ2jG/zJ9m637oib0pyv2G8/7AazXXFf6OO7LgWhxm2AF9ZwSyPYR2yc/PfK26UIxXVW5Tfxy6C+UVhtO3XKSZQ8WHEmkE7OFxxi2HVUhHLiZJ0LqXOeXQISxFeXTHp6i2rFfA3aPx62imTRfVqqzLN8t12F1dvnXWlcKPsuFQ+039C6K1HYqpwsOt15lW9A6gqOzCMLYZgUWtkRd94gI7zwyEUylpKLA3HvW8AJDuzNNb5eg+c4O8d2ZG8FllJSXrE9f+hA5bSDrR7bQQClCJ/bFxJPsC4d46IcODc2nxzAzt6uIGGldqc2H4pPXrcWfIQW16nuJ7DAxthHeug7Xq4m7iuBnt7BDH76cIhLYpyA5wal6lDhHTDAqLW2nU1k2JNYQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66556008)(8676002)(64756008)(66446008)(66476007)(76116006)(6506007)(4326008)(66946007)(508600001)(110136005)(6636002)(316002)(33656002)(86362001)(82960400001)(122000001)(38070700005)(38100700002)(9686003)(7696005)(83380400001)(54906003)(71200400001)(26005)(8936002)(55016003)(5660300002)(52536014)(186003)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?z7KHQD725e21p3l0uCU+hGp+CpkuKOwZ/Uos56Bs2NIA13UJYQkeMUfp/vbe?=
 =?us-ascii?Q?rlezTrEMHzwF6lC1mQ77JueyKO/Zwan4PjdYxyrlAAfFF9LkGrHtRUCYJ4uP?=
 =?us-ascii?Q?XsgZA7jR2aelYAkkhgXNdIayox1dtiZ5AaT9gNMxI53RbPc7UDNupi/0Oehf?=
 =?us-ascii?Q?41WCOMyS8oISE+oGfIPflkDDmg2rdL0nr/8s/u5RT7mP/jFadQqPG8B9/ImB?=
 =?us-ascii?Q?5+MdvKESpDsuXSNOafq5c1XB8Znj/HY/xQTIPkBu3pA0tNAGcLMmufKkpe5I?=
 =?us-ascii?Q?WCA+aE6805xksLMudZoMOfQAmsxRoZhZ8/HHbDLJ+epOPdky8d8mjquUOpbM?=
 =?us-ascii?Q?RsVXFUNhu6QIekmYQmYN556+8l/STvRL22yowUtx+0mpZOGR60+sdeim1pMJ?=
 =?us-ascii?Q?I7vUsJwRGLoBDSZ4GRYUgH1zuCAwZ1ei3PEriJ9TBatJDrSvZ86WhMIHfEJl?=
 =?us-ascii?Q?lhRnocyFMB7Jv5SVk+1plyM320jwEJ679di0t7Mms1R9wV2duVxn/3Ws3Aud?=
 =?us-ascii?Q?5v2iEVG8XC+OF2SoVTOY8HunUvirvIlLjQcuwgqHAcqc2Kwtc7Mrvr/3vffT?=
 =?us-ascii?Q?BBokLteSiCvMcFaxd4k0L9b9EYT56pUYIf9uWDonQLqICQtuI87vFu6XzZLr?=
 =?us-ascii?Q?PZNkpqvrzrXq0/Ia4qf2hMDaGiCuCmghJ3PoW3MIDmX1E99TkgN6XFS1zeXV?=
 =?us-ascii?Q?1DRKR+VlNBcKKh5qcDqth3CTgG/tMR79Op2bLzmzTJ6hCYweYOiWCIq/W0Q1?=
 =?us-ascii?Q?6ldXwsCs5w8NN94fzPcBMiJMuVZUIT7nwy8iVi1dO9yAKt0z3Ff3DVopOVar?=
 =?us-ascii?Q?AFp4cyoDg9XyD1ZNkLtRVzFjwSA9dwk6tRhXc8TSJ1xvqcPnh8TE1i+uxEZe?=
 =?us-ascii?Q?cSizIlpLE3k+7Kha+OP7XXb9RZgIrainjbf4TebYSo99Ag29cM0Aq1wk7pXm?=
 =?us-ascii?Q?FqRcJNtpQRl15On3gX6EWG41NaFwAzNZCCQdjIEd+0Rk01gXzUufvB/2hCtD?=
 =?us-ascii?Q?G/X4W0ARWdPgPcWrf/C2Iccc7b8MGlK7dz7iRBwcGQGolS2+3uEHWSxS2Iz5?=
 =?us-ascii?Q?ZhyVipoQjbMG1Lh9MKnnZZfY6xQB4rrzaxP0I8bG1qs5II3uV8p7K5z6AIAn?=
 =?us-ascii?Q?TcY8h+UgKuFrAdHytiqGoo5ifcMkxevIzVKx9uDuQgqt4cB+UE4yq97k/irk?=
 =?us-ascii?Q?cYxLs8BNL+A+HI6Zeyi1R3p+NWgArTpvihe17oAlaJzKyBglgw44Z9233Cmx?=
 =?us-ascii?Q?3AkWBK64b/eQtDHpE9EZDeSN3ey97jyC83JeE/9BSo1t1XrdP5n/WB4fFAfh?=
 =?us-ascii?Q?nlHeVn97l1ZHSYBPrRiUomxmXmKeoWfkx3dKqU/6OHprg8+TL0qiRVK8smU8?=
 =?us-ascii?Q?S59dUQ4hn4aWr+C519V21o1UhSD7WbVwVYamCb1e2Ane1k7tRP1a7HsJgl8V?=
 =?us-ascii?Q?et8XELjHSEawNU8Bcqev9qlKkkxplE7Yk47AyU0KTZ8x8Zri/8sBztDjUEfG?=
 =?us-ascii?Q?TLCcqN5R0Afs19ufuR1JrFCF2xjL+umwDkt27IYtYGwlXW6KXdWgUb0ymKMJ?=
 =?us-ascii?Q?VJGAJq2wYtytqRFJ/ctu/0fdUNxwOjxXMOHMdV1dtNBoiTQ69tB6xP+FftHP?=
 =?us-ascii?Q?auVAE0apaZ53xr9dEpM9npFGtyZJHg17D0OBKqlNvHdkJxEymiE70pr8A2z8?=
 =?us-ascii?Q?v4TQ6kOD1qcA08LOl/hxBcf6YIU8tOM7Rwn6lasoUgCYpLokQRgY6kHy6nCS?=
 =?us-ascii?Q?J6ND/rGDQA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00eaecb9-ea7e-438a-43fc-08da20d7e22b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2022 01:08:00.9796
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q2oUobKaE0lJ1OpqZusMfsbif09og5lOi5dZklDjNzvdiJCLdTLuSWyVtrZ3MiSv/zROumKHQV0eugTsKLWrCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1804
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> On Tue, 12 Apr 2022, Tianfei Zhang wrote:
>=20
> > From: Tianfei zhang <tianfei.zhang@intel.com>
> >
> > This patch adds the description of feature id table in documentation.

Please fix the title and commit message per your current modification as we=
ll.

> >
> > Signed-off-by: Tianfei zhang <tianfei.zhang@intel.com>
>=20
> Hi Tianfei,
>=20
> Reviewed-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > ---
> > v6: fix documentation from Hao's comment.
> > v5: fix documentation from Matthew's comment.
> > ---
> > Documentation/fpga/dfl.rst | 5 +++++
> > 1 file changed, 5 insertions(+)
> >
> > diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
> > index ef9eec71f6f3..15b670926084 100644
> > --- a/Documentation/fpga/dfl.rst
> > +++ b/Documentation/fpga/dfl.rst
> > @@ -502,6 +502,11 @@ Developer only needs to provide a sub feature driv=
er
> with matched feature id.
> > FME Partial Reconfiguration Sub Feature driver (see drivers/fpga/dfl-fm=
e-pr.c)
> > could be a reference.
> >
> > +Please refer to below link to existing feature id table and guide for =
new
> feature
> > +ids application.
> > +https://github.com/OPAE/dfl-feature-id
> > +
> > +
> > Location of DFLs on a PCI Device
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > The original method for finding a DFL on a PCI device assumed the start=
 of the
> > --
> > 2.26.2
> >
> >
