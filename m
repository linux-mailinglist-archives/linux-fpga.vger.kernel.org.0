Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6236423C8F3
	for <lists+linux-fpga@lfdr.de>; Wed,  5 Aug 2020 11:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbgHEJPK (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 5 Aug 2020 05:15:10 -0400
Received: from mga17.intel.com ([192.55.52.151]:35414 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728677AbgHEJNr (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 5 Aug 2020 05:13:47 -0400
IronPort-SDR: Xt/dDT4sjlwDTtXCuHI9D3UokNoZYNi7IFD6j0xtC1Hr5pa9KxfaUHtF0zDGwwnUmueXLFQcLR
 RdWkqR3f9vcg==
X-IronPort-AV: E=McAfee;i="6000,8403,9703"; a="132574549"
X-IronPort-AV: E=Sophos;i="5.75,436,1589266800"; 
   d="scan'208";a="132574549"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2020 02:13:47 -0700
IronPort-SDR: V6U/5SN4492DaeBg1wOdzZtdesbnd7RdPylFknAMEzKmW9oC318nCOwrpxrhZjjNhCkM1skSRr
 RLRLow1+SNhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,436,1589266800"; 
   d="scan'208";a="315683191"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP; 05 Aug 2020 02:13:47 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 5 Aug 2020 02:13:46 -0700
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 5 Aug 2020 02:13:46 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 5 Aug 2020 02:13:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lsjhHjtbP/13jAYNyrBGwvNBTUgN0dwpIFVZ0uhtQWvesdSMo0MTmh1si1p5MTmVZlQkXJSTwUsaSSXFGMJ1tXSqErnv+4Ezay4bE4y25u4QuHBEV2iqwml6slkY5VNsKElRtnPXgq+hXoapUCtwbUI7n3+Jn0XIy/2/9TpNonoH2cuKBkguMgoQdc3pJgInfbNHZcaQeVUsVOc6AJau1lWzweM55XAU+e2NHxLWr0rziP4ZaqACPKuFWcautd6wY64znUDSwtOqaNK4tTLQQLbkndsvPuvN15pYmsCfUueOBhW/Bp9Orsb70nkXJfHnTJdtuWU0qEwPQmP4a1t5Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CphVXTqFpWsrP4hjpY5R5g+wlI4kCZd5b4ZiUC3z3n4=;
 b=VB2BAm8XhpAddNcFWjgRs1nH/cwmWA+o5kyZzx2dWzGcXuLL6qFq8SPTBTeddriMUk+C/bjqoD3lR0tqH9rWBv0046r7MWIpglxAhgnrsxhnA6EgGT3jLtmDyjEnvikYD5HlEO5qfKEi/yttm1QUgOagSKOOeQxp9h/h7AA7+R5BZYMChBB093d+f20zI2oW9D23F/PR6nSpbc7RNoM+KJxCHoLJoHY+woHHcf+El2Gk15qsoCaB+G3W44pL/0/MQPvV/3cmkaTJ7LQmvN1jp8s1j9jCqVOd/KyZBFZu4hVVPZDDfpclRZ+CUxlXmeyNl9GdEe4+2fSXPHX7zvug9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CphVXTqFpWsrP4hjpY5R5g+wlI4kCZd5b4ZiUC3z3n4=;
 b=n4L27uZqGAu2QD7v33FdeN+mzctCF4NAessxfotugb4U4v6Ber6fT05yZUrelsSgs7DrMHER9vTaEuZYBRDw3Pbd5PVmpDh6lBetDzLJA6/iJxHBoOrxWE6NPxlQmz/PsV8FobwFXNbzrd6DXDi6zbDsr3XrrJpAAZzFXVjGoEU=
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM6PR11MB3322.namprd11.prod.outlook.com (2603:10b6:5:55::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.17; Wed, 5 Aug
 2020 09:13:44 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::c1c1:6930:f17d:a80a]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::c1c1:6930:f17d:a80a%4]) with mapi id 15.20.3239.022; Wed, 5 Aug 2020
 09:13:44 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     "Xu, Yilun" <yilun.xu@intel.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "trix@redhat.com" <trix@redhat.com>,
        "lgoncalv@redhat.com" <lgoncalv@redhat.com>,
        "Xu, Yilun" <yilun.xu@intel.com>
Subject: RE: [PATCH v3 1/4] fpga: dfl: change data type of feature id to u16
Thread-Topic: [PATCH v3 1/4] fpga: dfl: change data type of feature id to u16
Thread-Index: AQHWai4tuZLWw9qNcUyLNI3Z6SZQ1akpPMlw
Date:   Wed, 5 Aug 2020 09:13:44 +0000
Message-ID: <DM6PR11MB3819752BB8E7437CC6E20284854B0@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <1596524715-18038-1-git-send-email-yilun.xu@intel.com>
 <1596524715-18038-2-git-send-email-yilun.xu@intel.com>
In-Reply-To: <1596524715-18038-2-git-send-email-yilun.xu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.2.0.6
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.46.36]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 12af20be-0f48-402b-dfb4-08d8391fda68
x-ms-traffictypediagnostic: DM6PR11MB3322:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB33222FAFC396CD226E404B98854B0@DM6PR11MB3322.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KJw33si7QX4nHzVOxXhdZDpqkPzt+A/uf1bbY68M+oZuqXuuZcD75Vpg5TQjhLWeGj6wbjqbzTGw0F+oKSrCKS6SQilCUQVVnM/CR++mTfQwbdZLozdQfVspk4aIWH0I9x33r9wbOnS+wbrRa4n+DaKP577g8gnQIkJkrbmZOLSN1DhS8eH8FINDuCGxRK6KIuVaA+dBbcFCnLqySnrDi/+ao3+Bf9768XMH0Pkl2iOEsiEbl7XkZa9vk0dEQoBaNO5ijpKLJS6ik+8s15T2CnYqY5exZBBPsSTEKqXia9sTwMzDNqf8JMoH6fdP4x08TLO/ivDbAdloma7MXv8ZkQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(39860400002)(346002)(366004)(136003)(376002)(186003)(55016002)(8936002)(316002)(66946007)(54906003)(52536014)(76116006)(110136005)(66476007)(86362001)(8676002)(71200400001)(33656002)(478600001)(107886003)(64756008)(4326008)(9686003)(5660300002)(26005)(66446008)(66556008)(2906002)(6506007)(4744005)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: OMvMLigKNAWf3AM1FX+vwqElTb0Ez00QAmxcDn96XfBIJbUnO0vSbujkjU/10zFzqPgjdpKZKvibCgF0c5Li8Jk9DsDWiKb8bBwSVCeZab8SgIt28HROIzuR1wNHIJenbgdcAJIv78uSwAIa4NSG4q4OZLndVnAZrpHBmPnEiTh/PSY4WkAZWC8KbS4gmgpCI8j1nJOFfHCb5+GygQpjJVKU7dEMrOGakf7gDPJF0HI5sl8ananqVUI2MzwbG/pN0QKFcEGzQ9hSh8vHC/R9VsPdtbASRZzbcoDosf6Sm0CG6sTMt+EkfzEEI0d2dkjteqGyysmRnLl5VY3N93uwyp6Dis8d7V9t/gHxIp1nSmNCklRAa/uDQJKgG3hrBI6JVQTeYWe6i1Q6d6kp8nXLVPHucSIHj7qnox8qjLpsfHve5Jy32v9sCScf/VU/6SUbJ7r1x6fCCldgH9erlVOyVxvz7iKHz2RtiYWEpK4BBkbuqRmWp76Z/tXDHfISmExc9mjDk9LQqPZ8Bm0KJBnxLMSUIRKZjyM7xg4Uyp03qmklZrvTpYi/BrHl5gNk+C8cV7PVaVew/ZMgge3oZWQe3TASStLuI+ecxQ2Frd+1n+icJ6u+VV05f62L6egjJNU9umvfOXE5R4iG8PLGeVGsmg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12af20be-0f48-402b-dfb4-08d8391fda68
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2020 09:13:44.2501
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /oQ2X+GnLKLBx0tYunSqKcvBpCgMJ7FJ9+m/AbbrfcGE1dOBfvj8mG3SPF81LThDRQi9K49Eeh8U/KqGg48BTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3322
X-OriginatorOrg: intel.com
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> Subject: [PATCH v3 1/4] fpga: dfl: change data type of feature id to u16
>=20
> The feature id is stored in a 12 bit field in DFH. So a u16 variable is
> enough for feature id.
>=20
> This patch changes all feature id related places to fit u16.
>=20
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Reviewed-by: Tom Rix <trix@redhat.com>

Acked-by: Wu Hao <hao.wu@intel.com>

Thanks
Hao

