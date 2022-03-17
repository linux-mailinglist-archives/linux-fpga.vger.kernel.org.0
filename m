Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43FD24DC03C
	for <lists+linux-fpga@lfdr.de>; Thu, 17 Mar 2022 08:35:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbiCQHf0 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 17 Mar 2022 03:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbiCQHfY (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 17 Mar 2022 03:35:24 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD16F8455;
        Thu, 17 Mar 2022 00:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647502448; x=1679038448;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kslqP82opOYUjwSmN0dayOFq80Y0G+Wty4ijFXFxKLw=;
  b=Qh8eIQSpbQ57IHT2fgESeZRn+MkhsqQhpE685P7B8QLqShc6IAj3eOhQ
   XWpvV+trSQJd9+WtjYIgk/F9uHVjlS88yfpZBYdQtv4ch/y6joa/r718i
   VXyY/4WnWiSYLCQWOPzYA5BjzdWpQJArrkStnTw08KakS28FgnaefFrRO
   FS0ujs/qdOQvmd5O4bDPKQDr1iV4zoEpFed173dXDCOUDbM0QJPOPg1PQ
   nrbehSWlwpm6mPAKxOJbmz51vy+qrDxygPsRhZlUAU7AJT/Sut9q1Ml1H
   Wf4HQDTODVOXxVB1cS9emkN+/89hnUCUQLzeRHc0wlr9ebRgO36JvClok
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="255635708"
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="255635708"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 00:34:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="498739426"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP; 17 Mar 2022 00:34:08 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 17 Mar 2022 00:34:07 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 17 Mar 2022 00:34:07 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Thu, 17 Mar 2022 00:34:07 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.47) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Thu, 17 Mar 2022 00:34:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aHHcO/5lV88z5qeGFnCQaIjVfZmhJynjMkzc1NADXqneq08hRegSXVBpKLUc4a/6JjMK+HX6xAHbaHQqIlpVzYjp5yBWl7yOcF6rERC1XrJm+veQxnQVYtXInV54HeEqm1kJx5VYyllUVkBOeTcnHpj+R2dQDY9xNQM0FXndG/Ur98hTDuVeefOPgBfFdNpWS8eDexQiR7iwzrOa8kzaQN5skc3kyI7UXFtSF13ZNUibCMwLYpo3lz9eExclxUj6jtGJ7cH8j/Mr+JjQB82MV2U0v32kLEW3ehE3IzPGzYNMK+8QuqNrOQo0BjDSHqttJDQ56kUbyCACFLKQeb/j4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C4Pm8cceRICP79DNO6CqDERFJld5ijm+nB2QnVmVb0U=;
 b=Z/WJFWDbPX1LX0+2NAjr+B5ElbdYjVzbqEEtmEXx9BVCn+8Rjyp5/5+HTRoybPifAFdH9xijgLzSHghTZBKG+9CE9SZQDc27BynXLfIgIeH8Ud03TyqTEXZr7Uj7whv61Vl6dctezW6DEjdtknQnnCdVteZqT6nQ1gO1E/JQyyhb5+IsW5iyMiIPXZuqyqpX1wee9HVhNxiRLfWLfAbZIuP6niWj4O/HBXbtjberqTqbADHj9Ud5GVcWrEORZ0FWMT606nBwNf+V/WJbSpAEvmpg3d4OHE2Vok+f/TrAbvclrfkDBJCAoMvtJCzAkcbxMcVEKbaTNNBjI89PIUpTww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5483.namprd11.prod.outlook.com (2603:10b6:408:104::10)
 by MN2PR11MB4414.namprd11.prod.outlook.com (2603:10b6:208:17b::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Thu, 17 Mar
 2022 07:34:04 +0000
Received: from BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::8c4b:e24c:c69f:7809]) by BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::8c4b:e24c:c69f:7809%5]) with mapi id 15.20.5081.017; Thu, 17 Mar 2022
 07:34:04 +0000
From:   "Zhang, Tianfei" <tianfei.zhang@intel.com>
To:     "Wu, Hao" <hao.wu@intel.com>, "trix@redhat.com" <trix@redhat.com>,
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
Thread-Index: AQHYOQUcVwr1NO7I9EaBR7STlp8buqzC1K+AgABHRmA=
Date:   Thu, 17 Mar 2022 07:34:04 +0000
Message-ID: <BN9PR11MB54839B3ABC5844DF45602995E3129@BN9PR11MB5483.namprd11.prod.outlook.com>
References: <20220316070814.1916017-1-tianfei.zhang@intel.com>
 <20220316070814.1916017-2-tianfei.zhang@intel.com>
 <BYAPR11MB3816EAB6CC0047B2DBB5086685129@BYAPR11MB3816.namprd11.prod.outlook.com>
In-Reply-To: <BYAPR11MB3816EAB6CC0047B2DBB5086685129@BYAPR11MB3816.namprd11.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: 1852c1fd-5458-413b-4307-08da07e8833a
x-ms-traffictypediagnostic: MN2PR11MB4414:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <MN2PR11MB44149C4F07EE650410A2C84AE3129@MN2PR11MB4414.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fIlroCAQe52x+3ccIFvYRAFNwtHEeCh+3T84hcgcdpelWccTweECJ9BnPhv1YOFR1q8akjg1GVjRVRcLA6nsonYPNBDDk8AF16B/jKdK00WxoeAb6JEW2Om+HLXRI9E+zArtX+McCL6xslJ1CnGISacw0BC0UoZgYIfaiMg86TiMnqMusiApIRl6zuPJc62phTXJQRgZtmCWr/V8w1OUG8U6obkuvhKOXrvb6FGAJXrNf2dGD2emdHhQw35TuTqRpxTXT1c+laEA4TsmFBw3j9M1CuRlW6+AC+UqfuAONm/P1GoRkjfcqRMOceJ69AqBJDK3/yLTw2KlyZrcLie4lJJbKuX3kFtJdl1pAxV499gIH3ySUlFyD0HWNQO3XZXiDu+6JJA3mGfyw9d5beATkmJBuqS5Qin+5zZoi8u+hItsSIEDs8bKy4qnkCxuYwI8eRb2WwtRimPHyXXeRp8pQm9O+qsdDVXqvlK/UR2oEserZiv1qbqoKsaJJGq2XGHGgR64wYgVSriZJjJpQ/364W2o9/rx46ZbYx+XOQMYpkmGNgGd4PftehdMQfnR7v7nTN5sr2ZSZaxT3dbbJIq5ayDGncwdrAixuRUDEQcPDsAdtdTDNlZ2fOsPvlXhO4dJDeeuc2bOKlX6PqrPGFcVa8qIBJL3oNHh9cVkeW+8eAzt3Id7xcHJmI8hWCEFwDm/+knYzl3kHBQMNGbN38x7BQXiyHtveSAL1nz3DbWbW9Y=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5483.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(26005)(83380400001)(186003)(9686003)(7696005)(6506007)(316002)(5660300002)(53546011)(71200400001)(54906003)(76116006)(66946007)(66556008)(38070700005)(122000001)(82960400001)(33656002)(66476007)(110136005)(8676002)(921005)(66446008)(64756008)(52536014)(55016003)(508600001)(2906002)(38100700002)(4326008)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2SB0Vb49tvoKN6nP6jquW2kAisiDjR5QmVe8yWKd0rrKK3QgJ+9cl/Uuqwkl?=
 =?us-ascii?Q?Dyd1FXdGGPpnCpFZQCtCUw1LKSRLTMFPHsIwmbwNJaRFzzsDod7IluKxTCIl?=
 =?us-ascii?Q?Wrzm0oqL4szcPrkBBXtVD/VtwyesIZg0txtEBfrS56TdQ0SZ2L+RdHU77T3d?=
 =?us-ascii?Q?PGCDjr32LGboz8j6ys/pCoYLqS3Ds3tchU3DipMxgHxHFgNCDCUS2UNTnvrL?=
 =?us-ascii?Q?a5yB4o8sS48Tf4ut64nUbPF5KdTurYsr8rTjgh50KaWsHl/2nX3shchJ1Ply?=
 =?us-ascii?Q?JfUQfngyE7NIxnIEgV6Xo8VN7YtM3lmRaKLz4pa8RxyrWs5zN/eUZpy11Wo9?=
 =?us-ascii?Q?m6he53mlgVOaN9yxtYSlfRETzMsYYlvbadgEYmEA4WNXmYPeqhefUEd+bg27?=
 =?us-ascii?Q?FmiRlUZZzGor6TEQwgmoR77WNhEbe7NqpOcv3gwpbUVuqYIoXmg8yimFzeS6?=
 =?us-ascii?Q?1cf6q4CI4A7FpjBWOqpHGRvBbdIy6Fq7LNEGr8PThwPhR/gCESphIZtEshan?=
 =?us-ascii?Q?a8cw98S1Sj+Pc4wBi1BiYzgjG465XV213I/8S8DEXVinevy/FVeZvrqiTZml?=
 =?us-ascii?Q?4FS6TNV5c6UXJ1Nr4s0zNEuzg9bm4rjHufeVhH+e2h7/l33Jbg0VJe7hBUHz?=
 =?us-ascii?Q?nPW6MTN3w2aijgKPW51L6ahr6TaG16nrSMYgQ4+/P3OBYnClZQsS9lTLlFFh?=
 =?us-ascii?Q?cYyXggPOsvhUlnCiWdaCs2R4/B3O1dfS0hCLr/SVv46yDn3MR+I7DBKWjBGd?=
 =?us-ascii?Q?kRAh+Xxm9YgiAgyjQTf2dYgVwfpGbgyrfWMmTZobFsVxkecOpSqF+RP9F8u6?=
 =?us-ascii?Q?hsSPse9vNnPkpmeQDSnoEPazAJ7NPNKQLJtHxco6Z9/AJM9VVdCe+J0uftAK?=
 =?us-ascii?Q?IogCjfQjgDfZAIWD+v3p7uDivQnHiUIAwTpnMJg7fNcFLJegKT/NFjcLvklp?=
 =?us-ascii?Q?I5RuahrXCzuU56uzJh8BojlWmH2w5FEBP1bggzaXgBSN8zJ55SyzTWTZ40gG?=
 =?us-ascii?Q?GimHZT0sqMDQRrMeYKKyHiFZpkQ0XUujqUmxujFyl0rrcKryyII0MA4p8UOE?=
 =?us-ascii?Q?mktv75fR32ouVQv14ZYZRImB19xYafbLz6Gq51+4Pm7N3oNtgUF2bSFTzr+g?=
 =?us-ascii?Q?l4WBmhkN0x2lFQIWc6k9l2Jh0GVUzx9W8jQsXDtFwgmTX8Y4FddGxiPGVIbJ?=
 =?us-ascii?Q?XHBjaJP0leramCmmEXT2fVDaj+mPeWsqFEqw35Wpamb2pENZ/aoVO3MvqCt5?=
 =?us-ascii?Q?3bdCLvgbnNyZ6UVMCENVAO8NAep+beY+liwKYJ9jNJoKtFcYZs0m+ERyvSnY?=
 =?us-ascii?Q?Czp37ph9ZqlpKFPUH3/YXUa8FZw8f0JbgHS/9Zn2ocwJLaTR0hAqMYRTUZhV?=
 =?us-ascii?Q?L0X9seoWyIfWqyWUnkIPdAOs3IjV5QToUMqTyQGtvN/fkXhwDeP0VYWuWjqE?=
 =?us-ascii?Q?E+DGHWaXmc6QGONAJkjMv8CxhzzOLzqP?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5483.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1852c1fd-5458-413b-4307-08da07e8833a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2022 07:34:04.0225
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7E7moZdU+4o3fCDw+6xsiLAtACA58QuhjPyU9654FkKYPzNQFWVkzlEOK8K1Ay2jmTaWNBxzLuGEbVykF6rI4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4414
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


> -----Original Message-----
> From: Wu, Hao <hao.wu@intel.com>
> Sent: Thursday, March 17, 2022 10:05 AM
> To: Zhang, Tianfei <tianfei.zhang@intel.com>; trix@redhat.com;
> mdf@kernel.org; Xu, Yilun <yilun.xu@intel.com>; linux-fpga@vger.kernel.or=
g;
> linux-doc@vger.kernel.org; linux-kernel@vger.kernel.org;
> rdunlap@infradead.org
> Cc: corbet@lwn.net; Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Subject: RE: [PATCH v6 1/6] fpga: dfl: Allow ports without local bar spac=
e.
>=20
> > -----Original Message-----
> > From: Zhang, Tianfei <tianfei.zhang@intel.com>
> > Sent: Wednesday, March 16, 2022 3:08 PM
> > To: Wu, Hao <hao.wu@intel.com>; trix@redhat.com; mdf@kernel.org; Xu,
> > Yilun <yilun.xu@intel.com>; linux-fpga@vger.kernel.org;
> > linux-doc@vger.kernel.org; linux-kernel@vger.kernel.org;
> > rdunlap@infradead.org
> > Cc: corbet@lwn.net; Matthew Gerlach <matthew.gerlach@linux.intel.com>;
> > Zhang, Tianfei <tianfei.zhang@intel.com>
> > Subject: [PATCH v6 1/6] fpga: dfl: Allow ports without local bar space.
> >
> > From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> >
> > In OFS, each PR slot (AFU) has one port device which include Port
> > control, Port user clock control and Port errors. In legacy model, the
> > AFU MMIO space was connected with Port device, so from port device
> > point of view, there is a bar space associated with this port device.
> > But in "Multiple VFs per PR slot" model, the AFU MMIO space was not
> > connected with Port device. The BarID (3bits field) in PORTn_OFFSET
> > register indicates which PCI bar space associated with this port
> > device, the value 0b111 (FME_HDR_NO_PORT_BAR) means that no PCI bar
> > for this port device.
>=20
> The commit message is not matching the change, it's not related to AFU...
>=20
> Current usage (FME DFL and PORT DFL are not linked together)

This usage is only on Intel PAC N3000 and N5000 card.=20
In my understand, the space of Port can put into any PCI bar space.=20
In the previous use case, the space of port was located on Bar 2.
For OFS, it allows the port without specific bar space.

>=20
> FME DFL
> PORT DFL (located by FME's PORTn_OFFSET register, BAR + offset)
>=20
> Your proposed new usage is (FME DFL and PORT DFL are linked together)
>=20
> FME DFL -> PORT DFL
> So FME's PORTn_OFFSET can be marked, then driver could skip it.
>=20
> Is my understanding correct? If yes, please update your title and commit
> message, and add some comments in code as well.

From DLF perspective, I think it is yes.

How about the title:  "fpga: dfl: Allow Port and FME's DFL link together" ?

I will also add some comments in code.
Here is the new git commit for this patch, any comments?=20

In previous FPGA platform like Intel PAC N3000 and N5000, The BarID (3bits =
field) in PORTn_OFFSET
register indicated which PCI bar space was associated with this port device=
. In this case, the DFL of Port device
was located in the specific PCI bar space, and then the FME and Port's DFL =
were not linked. But in OFS, we extend
the usage, it allows the FME and Port's DFL  linked together when there was=
 no local PCI bar space specified by=20
the Port device. The value 0b111 (FME_HDR_NO_PORT_BAR) of BarID means that =
no specific PCI bar space=20
was associated with the port device.

>=20
> Again, the change you did in dfl core code, is not only impacting your OF=
S
> device, but also future DFL devices, it's an extension to DFL.

Yes, I agree that is an extended usage.

>=20
> Thanks
> Hao
>=20
> >
> > ---
> > v3: add PCI bar number checking with PCI_STD_NUM_BARS.
> > v2: use FME_HDR_NO_PORT_BAR instead of PCI_STD_NUM_BARS.
> >
> > Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
> > ---
> >  drivers/fpga/dfl-pci.c | 7 +++++++
> >  drivers/fpga/dfl.h     | 1 +
> >  2 files changed, 8 insertions(+)
> >
> > diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c index
> > 4d68719e608f..2e9abeca3625 100644
> > --- a/drivers/fpga/dfl-pci.c
> > +++ b/drivers/fpga/dfl-pci.c
> > @@ -258,6 +258,13 @@ static int find_dfls_by_default(struct pci_dev *pc=
idev,
> >  			 */
> >  			bar =3D FIELD_GET(FME_PORT_OFST_BAR_ID, v);
> >  			offset =3D FIELD_GET(FME_PORT_OFST_DFH_OFST, v);
> > +			if (bar >=3D PCI_STD_NUM_BARS ||
> > +			    bar =3D=3D FME_HDR_NO_PORT_BAR) {
> > +				dev_dbg(&pcidev->dev, "skipping port without
> > local BAR space %d\n",
> > +					bar);
> > +				continue;
> > +			}
> > +
> >  			start =3D pci_resource_start(pcidev, bar) + offset;
> >  			len =3D pci_resource_len(pcidev, bar) - offset;
> >
> > diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h index
> > 53572c7aced0..1fd493e82dd8 100644
> > --- a/drivers/fpga/dfl.h
> > +++ b/drivers/fpga/dfl.h
> > @@ -91,6 +91,7 @@
> >  #define FME_HDR_PORT_OFST(n)	(0x38 + ((n) * 0x8))
> >  #define FME_HDR_BITSTREAM_ID	0x60
> >  #define FME_HDR_BITSTREAM_MD	0x68
> > +#define FME_HDR_NO_PORT_BAR	7
> >
> >  /* FME Fab Capability Register Bitfield */
> >  #define FME_CAP_FABRIC_VERID	GENMASK_ULL(7, 0)	/* Fabric
> > version ID */
> > --
> > 2.26.2

