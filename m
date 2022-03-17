Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84FD04DC0D7
	for <lists+linux-fpga@lfdr.de>; Thu, 17 Mar 2022 09:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbiCQITP (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 17 Mar 2022 04:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiCQITO (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 17 Mar 2022 04:19:14 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F6014B868;
        Thu, 17 Mar 2022 01:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647505077; x=1679041077;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qfSMV2kq/FqfIYN/mAoPwOKTmBixOFbC5aFg73INTQk=;
  b=E2CaabUcow3Yig73hEyRMaOFsrGWlTmXqLD2eBqtKiJ2mWiOyGutkt9I
   zjEspG88FOZSGLMDGOvjqmHKbfnsoeb12Xs+xv+Ut/fAluAbBA8JvCUKU
   2s4gv8YBOjvVBTlp7rKtD+EZMnyuzs9vwaqZpUANV+ivJXLTNsd79RR+l
   SpzYVcMH1hZvBuQ5jmLxTTRkReiE24/wFDQnp3lWKfCK3rwFyxIuqnQEG
   7Ykrrqb+vItW22hNkvEC24qsFxYXjzDxLP5sUUWenJAu8SsvQctwRVVCd
   n38wsyiCj1riMjVygmKs/JjxwuXPrTg4xXprblRuYlaY4hsE8FFeoFqkF
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="237419956"
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="237419956"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 01:17:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="498749609"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga003.jf.intel.com with ESMTP; 17 Mar 2022 01:17:56 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 17 Mar 2022 01:17:55 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 17 Mar 2022 01:17:55 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Thu, 17 Mar 2022 01:17:55 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Thu, 17 Mar 2022 01:17:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EUSgpJbNBe4l5oWTBveYit6g9hu4oMGnECYU+OXIV7Z67WQdmLupfUqmEQdtrhIUSGxkek2tbr7nMkglqVK4zFpTbqcfqSTUf6o/FlElJ9dMJ2LbK5/i+v4jYGI+mcwi+LmDktvymhFA+xwS5R0NUtByqCZbHnO1531WzxEIC6eKi54EHn4mYmvjScIsMleGOLRn98cJT2mDpK4GVw89Kc0MCtJsPNRoLFfcKQGRPhTNuyQTBSBiuxTqVyUsxEFI9MF0fe9TTAhIQk1HqUzCnJHabNCOwa27zmHD9TFBfRDDJT4zmoTNqxohVS9py/NOlCBxhmuIv8/9tYcXgNKDRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1bfwXI/+KeAo22rbJixDa7xQS9kq/yQCyektgwHQJ8k=;
 b=nZTn2Ru19zS2uVMANJqIKMklKTg6L8KiS5h8JbE52BzvAuuCicWu6eBc7QR7sbCZGVelucNesdw0iHj0UgtYzo+F/jfrCLU+AC6WLB7oscrsz4qNcCl4Y4nvjURZ58BkeeDXI7+Lr4PXfkQIAOGsAA0h9CzKKkJ/gM0NwIBBTz4/CMmSI1Jd4n1ykzPqybEsf7+Q2zquSFTzY0x9Zutuuv+PzcoHlSYxJVR/05BFJmSxDcJXLf6asEunax48EpJtbRgbzhDcyFsHUDwyiLo212JQyib+6FUsBd+BlolkRVfdLzpSsmobf+SSzaKHekrLMWkLdoS6mDvDG6Ga3WK/aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM6PR11MB4153.namprd11.prod.outlook.com (2603:10b6:5:19f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Thu, 17 Mar
 2022 08:17:52 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::d9ee:5bb8:1828:222d]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::d9ee:5bb8:1828:222d%7]) with mapi id 15.20.5081.017; Thu, 17 Mar 2022
 08:17:52 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     "Zhang, Tianfei" <tianfei.zhang@intel.com>,
        "trix@redhat.com" <trix@redhat.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "Xu, Yilun" <yilun.xu@intel.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>
CC:     "corbet@lwn.net" <corbet@lwn.net>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: RE: [PATCH v6 1/6] fpga: dfl: Allow ports without local bar space.
Thread-Topic: [PATCH v6 1/6] fpga: dfl: Allow ports without local bar space.
Thread-Index: AQHYOQUc6KfnoIn0pECU3HlxJyPskazC0EmAgABgbgCAAAKekA==
Date:   Thu, 17 Mar 2022 08:17:51 +0000
Message-ID: <DM6PR11MB381901ED86051F8D3117799A85129@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <20220316070814.1916017-1-tianfei.zhang@intel.com>
 <20220316070814.1916017-2-tianfei.zhang@intel.com>
 <BYAPR11MB3816EAB6CC0047B2DBB5086685129@BYAPR11MB3816.namprd11.prod.outlook.com>
 <BN9PR11MB54839B3ABC5844DF45602995E3129@BN9PR11MB5483.namprd11.prod.outlook.com>
In-Reply-To: <BN9PR11MB54839B3ABC5844DF45602995E3129@BN9PR11MB5483.namprd11.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: 8d294cc8-1a17-4c62-eb71-08da07eea1a0
x-ms-traffictypediagnostic: DM6PR11MB4153:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <DM6PR11MB4153D1A2CA71B8C5151F357A85129@DM6PR11MB4153.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 95LJ6ZH89qKjW4KUU/ujoFy1GWm630i8iwp7vfOa3kbKz24njd+vhn0yNkB7fev0MAVJqXFLsjt3xE8FpA8ePxODxWPsxhkbuWm6CVq7SlBOsnGcDaY1zYoGS5oGZWm/IIBq1lmvUNVQPz7u1uufQD35e5GOGn/mVMerhG9CuyP0FrTIjN0DKBGOcvSEDxl3y3Izvvuz2Osj+TVY2MNNPV9G/AhEB9XTy08aBDeMef3IIpgifR08c7rDe4WFpo6FopnvCzaFbnS4A/atZAVaba7FsXjA7qqgk/L4pZFdYUBl5bDqiOJkooNFFLWnpTeWZtS5xyrdfxBXtfvQuZptWvcAMKYOgfRhJSVmWztzyn6JL/kYCSli0XsoU44RbMjKRsizdxZHHdd7rsGObkhc2EXL8hJx+1tBVeVs/RietZMpS/8cTxLW+vozmM7rv4Izlj8XmSUFGbusxli76B6EZcXDsUyEytLfQRnw4UhX7pkw0okhwBK+AA500otNSDNy3BhIKYoklSXRLThDHn1ukFT1ATg+BMrUiyDLIBwjSGVCtzCyQaZD4DAnSwi3wqr10phK2O0LvR11DqDFoafvMBaw+DyoglCIkImkSrUhHqZVVKs90IQ9e1lZ5oOZCRTezWQI2JYsV/+y3rwzbtqD2IJ+Q1weSlTM38n6scfMzPHZ1cD9PynkJUYP4tCHCq65iB8mYqtltLZCE8dGybcini1b8Pw4jmfJ8rFAgG1X+a8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(71200400001)(9686003)(55016003)(110136005)(54906003)(53546011)(7696005)(6506007)(33656002)(316002)(8676002)(66476007)(4326008)(66556008)(66446008)(76116006)(64756008)(66946007)(83380400001)(8936002)(38100700002)(2906002)(52536014)(186003)(26005)(921005)(122000001)(38070700005)(5660300002)(82960400001)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gj54rCJw+xPS0rWBzQotKHKYNeDq86CeWlaHIME2o6wet70S1JHrwdiv6Ddv?=
 =?us-ascii?Q?bsfUWaHqb7cp9vCuNqgpe04PNnvZ8jNd2GVF3N/mwdcPnTSXw6Tb6ShEfhvu?=
 =?us-ascii?Q?lX5gVAB/tuXo8hlIDVdx6DRjOFMdoLs1IazQCDMXTp72nUjRb+YtnqB/n3Px?=
 =?us-ascii?Q?dsHc7BkBmTe/zCpWIkNCHlAgc3kWGvnYLRFrMD48HFupHHAR0OdOJzvr+mHu?=
 =?us-ascii?Q?8D5vLe9+avBEVFwzYs/oWHjpl/CwV0+yW4N2wDz+9ZAR/EmVPgH2uvqQTfuL?=
 =?us-ascii?Q?qSn7pstupY5FsHoRRS7JMZbiB5PPh/yBwmDBDXaPyX2YI6AqEFeQOUaM+/m0?=
 =?us-ascii?Q?I3txOyBddD7A+gJiaZ8tvev2vR1C4Obw76qHx+1kEsm0UplT1ZeaoXcjXkYs?=
 =?us-ascii?Q?ARlr0nASHK6pATSMtmBQOb4ud4na7UlE2u8qA2GijQvFOD26mNsygQf3kSjT?=
 =?us-ascii?Q?0gdvQuvki27RSRp34jN90TX5bWQ9ZJtJ5CIdjt6Dik49lMXR3eCXKVuswQJE?=
 =?us-ascii?Q?WYftM3hc7hdDPSokVLhUQGyre3C7KTaEcKkuUaUK8wrEtCc+PY2GcidHM4Qj?=
 =?us-ascii?Q?zy8GvuJNuiC0vfM3f8rjrAT6A2gc3JLzTlDTc/UjWQ+VIq7vWEZAeCtaXETq?=
 =?us-ascii?Q?t6PhvRfHjkFMRNmFYQiyiduGbdwz8ctOkHzERjEpxyznr7Afc+1zu7gIisA0?=
 =?us-ascii?Q?Qkz21wYYHemsI25dF9UjtXt7G+qS0ifU8oQahSYQQt6R6lq23B9pb5N0L7j/?=
 =?us-ascii?Q?6P8u/IadsgHQwS7KM0iGuDPZpjulZLoieqzd/gBl1K89afmBAATTQX8cMzvO?=
 =?us-ascii?Q?CAYJG7PEJfYOG7ewpR88+kL6PdyfRW1o5BryQuvbI+MGpmwqmdOPtc+Txn9u?=
 =?us-ascii?Q?L8tZZ8fT0hPvHptlntYUx8s6HAnIhftnMAAZOl9k/nCD2qTch4OEHHD29HlI?=
 =?us-ascii?Q?GLRuD9JSwmr+d8FH6XC9LPmaI44JXhb8xXi3Ayu9/zpsvkKCHx5Uvsp84EDH?=
 =?us-ascii?Q?imEJ3bJNtolWruYMZvCFP9LnXyCNJixkUJ0gMssioRI+SA86GJKqyRRHBN4P?=
 =?us-ascii?Q?p5ZaKkshwcCUIf0zYv40UUXU8vB0RyUXX3rzJwXFTPV5FXtKjFRQ/+HfHruc?=
 =?us-ascii?Q?IpRI76uDyoPsVRA4SjuQq+PCaRDxlsDPaEjRv/gqfEjH66f8gEU9qEfK5P3M?=
 =?us-ascii?Q?fY3H/jUIXnKGzXUI40/HCfk25lsfAl9QwkhTGaxXGpC5dzkEZq3iXd/gQh4Y?=
 =?us-ascii?Q?eZck+z0yJd9rJl4XdrdfUn788WTGe3tLZE/gg9le0Keag+X1HebhTceuXCqq?=
 =?us-ascii?Q?vkNZKK/6a+GJwM+Je/Ma7lps2x9pXRZ9dIsQL/HJq7FvVkMe5W79oDIbXDsM?=
 =?us-ascii?Q?KzlAyX5jfI/66+ZTck08xL+f7Ign3ePC8xDp6pEo4BOIEjmS0TilBRZcqEYg?=
 =?us-ascii?Q?KAgDkmZAJ3o=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d294cc8-1a17-4c62-eb71-08da07eea1a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2022 08:17:52.0229
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NdP5dKfiie5CFh9bO+Hb33Yv2WLKZeg+Z6bjxzWKquMkvvxjRmgwHOLFg3fl3BjCc4Pm+8/7kXo2NhbkIh+QqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4153
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> > -----Original Message-----
> > From: Wu, Hao <hao.wu@intel.com>
> > Sent: Thursday, March 17, 2022 10:05 AM
> > To: Zhang, Tianfei <tianfei.zhang@intel.com>; trix@redhat.com;
> > mdf@kernel.org; Xu, Yilun <yilun.xu@intel.com>; linux-fpga@vger.kernel.=
org;
> > linux-doc@vger.kernel.org; linux-kernel@vger.kernel.org;
> > rdunlap@infradead.org
> > Cc: corbet@lwn.net; Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > Subject: RE: [PATCH v6 1/6] fpga: dfl: Allow ports without local bar sp=
ace.
> >
> > > -----Original Message-----
> > > From: Zhang, Tianfei <tianfei.zhang@intel.com>
> > > Sent: Wednesday, March 16, 2022 3:08 PM
> > > To: Wu, Hao <hao.wu@intel.com>; trix@redhat.com; mdf@kernel.org; Xu,
> > > Yilun <yilun.xu@intel.com>; linux-fpga@vger.kernel.org;
> > > linux-doc@vger.kernel.org; linux-kernel@vger.kernel.org;
> > > rdunlap@infradead.org
> > > Cc: corbet@lwn.net; Matthew Gerlach <matthew.gerlach@linux.intel.com>=
;
> > > Zhang, Tianfei <tianfei.zhang@intel.com>
> > > Subject: [PATCH v6 1/6] fpga: dfl: Allow ports without local bar spac=
e.
> > >
> > > From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > >
> > > In OFS, each PR slot (AFU) has one port device which include Port
> > > control, Port user clock control and Port errors. In legacy model, th=
e
> > > AFU MMIO space was connected with Port device, so from port device
> > > point of view, there is a bar space associated with this port device.
> > > But in "Multiple VFs per PR slot" model, the AFU MMIO space was not
> > > connected with Port device. The BarID (3bits field) in PORTn_OFFSET
> > > register indicates which PCI bar space associated with this port
> > > device, the value 0b111 (FME_HDR_NO_PORT_BAR) means that no PCI bar
> > > for this port device.
> >
> > The commit message is not matching the change, it's not related to AFU.=
..
> >
> > Current usage (FME DFL and PORT DFL are not linked together)
>=20
> This usage is only on Intel PAC N3000 and N5000 card.
> In my understand, the space of Port can put into any PCI bar space.
> In the previous use case, the space of port was located on Bar 2.
> For OFS, it allows the port without specific bar space.

I didn't understand what you mean. Without your change, existing
driver supports Port in any BAR indicated by PORTn_OFFSET, it's fine
you put Port to BAR 0, or same BAR as FME. What do you mean by
"port without specific bar space"?

>=20
> >
> > FME DFL
> > PORT DFL (located by FME's PORTn_OFFSET register, BAR + offset)
> >
> > Your proposed new usage is (FME DFL and PORT DFL are linked together)
> >
> > FME DFL -> PORT DFL
> > So FME's PORTn_OFFSET can be marked, then driver could skip it.
> >
> > Is my understanding correct? If yes, please update your title and commi=
t
> > message, and add some comments in code as well.
>=20
> From DLF perspective, I think it is yes.
>=20
> How about the title:  "fpga: dfl: Allow Port and FME's DFL link together"=
 ?

"Allow Port to be linked to FME's DFL" should be better, as we don't
encourage that people to connect FME DFL to Port DFL or any mixed order.

>=20
> I will also add some comments in code.
> Here is the new git commit for this patch, any comments?
>=20
> In previous FPGA platform like Intel PAC N3000 and N5000, The BarID (3bit=
s field)
> in PORTn_OFFSET
> register indicated which PCI bar space was associated with this port devi=
ce. In
> this case, the DFL of Port device
> was located in the specific PCI bar space, and then the FME and Port's DF=
L were
> not linked. But in OFS, we extend
> the usage, it allows the FME and Port's DFL  linked together when there w=
as no
> local PCI bar space specified by
> the Port device. The value 0b111 (FME_HDR_NO_PORT_BAR) of BarID means
> that no specific PCI bar space
> was associated with the port device.

Currently we use PORTn_OFFSET to locate PORT DFLs, and PORT DFLs are not
connected FME DFL. But for some cases (e.g. Intel Open FPGA Stack device),=
=20
PORT DFLs are connected to FME DFL directly, so we don't need to search
PORT DFLs via PORTn_OFFSET again. If BAR value of PORTn_OFFSET is 0x7
(FME_PORT_OFST_BAR_SKIP/INVALID - depends the description added to
DFL spec) then driver will skip searching the DFL for that port.

>=20
> >
> > Again, the change you did in dfl core code, is not only impacting your =
OFS
> > device, but also future DFL devices, it's an extension to DFL.
>=20
> Yes, I agree that is an extended usage.

Please make sure related changes documented in DFL spec as well.

>=20
> >
> > Thanks
> > Hao
> >
> > >
> > > ---
> > > v3: add PCI bar number checking with PCI_STD_NUM_BARS.
> > > v2: use FME_HDR_NO_PORT_BAR instead of PCI_STD_NUM_BARS.
> > >
> > > Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > > Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
> > > ---
> > >  drivers/fpga/dfl-pci.c | 7 +++++++
> > >  drivers/fpga/dfl.h     | 1 +
> > >  2 files changed, 8 insertions(+)
> > >
> > > diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c index
> > > 4d68719e608f..2e9abeca3625 100644
> > > --- a/drivers/fpga/dfl-pci.c
> > > +++ b/drivers/fpga/dfl-pci.c
> > > @@ -258,6 +258,13 @@ static int find_dfls_by_default(struct pci_dev
> *pcidev,
> > >  			 */
> > >  			bar =3D FIELD_GET(FME_PORT_OFST_BAR_ID, v);
> > >  			offset =3D FIELD_GET(FME_PORT_OFST_DFH_OFST, v);
> > > +			if (bar >=3D PCI_STD_NUM_BARS ||
> > > +			    bar =3D=3D FME_HDR_NO_PORT_BAR) {
> > > +				dev_dbg(&pcidev->dev, "skipping port without
> > > local BAR space %d\n",
> > > +					bar);
> > > +				continue;
> > > +			}
> > > +
> > >  			start =3D pci_resource_start(pcidev, bar) + offset;
> > >  			len =3D pci_resource_len(pcidev, bar) - offset;
> > >
> > > diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h index
> > > 53572c7aced0..1fd493e82dd8 100644
> > > --- a/drivers/fpga/dfl.h
> > > +++ b/drivers/fpga/dfl.h
> > > @@ -91,6 +91,7 @@
> > >  #define FME_HDR_PORT_OFST(n)	(0x38 + ((n) * 0x8))
> > >  #define FME_HDR_BITSTREAM_ID	0x60
> > >  #define FME_HDR_BITSTREAM_MD	0x68
> > > +#define FME_HDR_NO_PORT_BAR	7
> > >
> > >  /* FME Fab Capability Register Bitfield */
> > >  #define FME_CAP_FABRIC_VERID	GENMASK_ULL(7, 0)	/* Fabric
> > > version ID */
> > > --
> > > 2.26.2

