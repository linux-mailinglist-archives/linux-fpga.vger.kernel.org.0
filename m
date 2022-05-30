Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64AD153859A
	for <lists+linux-fpga@lfdr.de>; Mon, 30 May 2022 17:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236943AbiE3Pzc (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 30 May 2022 11:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242692AbiE3Py5 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 30 May 2022 11:54:57 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE80F5048;
        Mon, 30 May 2022 08:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1653924988; x=1685460988;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=HcFxn+vh+cmUjWWwr2Zk0DPAAWCPisQJqCD+Ci/qs9s=;
  b=zcNnQiqA2CkYT8/8VROfHVSrJ6Xp2q9J0JtuGGYyb8LTieWQAZ/nKaEO
   g7Snhqy1VVkO6LrChq0XEfjOyNGi6d/xxekUCL3V0VpcQ26A3mG47wL26
   wew1FHv1sd2Re7PqMb+JDYiZZq7zcpAoQhNG+lwN7gdh6iQHJxlj8tbu+
   294Ofv8M5E9MJVWYWl3ME4d4IOkWN6ToRe+nq8xI7EJ0P4WfZaSvQZjjj
   QQ9gf9P3wQPtlZJcnNc97V+yC2FT2ozv1BJpVyZsG6aaAPNTBg8Snq4GD
   l8yk3xTaHknoMH4KJcWCFAYQ7WawPEevOP63ug3lfeNAg8DcK34HQxZif
   w==;
X-IronPort-AV: E=Sophos;i="5.91,263,1647327600"; 
   d="scan'208";a="175709862"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 May 2022 08:36:26 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 30 May 2022 08:36:28 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Mon, 30 May 2022 08:36:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QvXuFr+wUZIqCdFmqvgesJkxbV9jmf3OTcmnPmaXFJ346/5zmFoyLwEfeaUtD7ZoObnh89OP+6rgmfQWuDA3pkxNmD9QR2Y5KYnRCg2lBwJJVphmiLwB5dVW9xeryJVqdZjV76kPxSO0DV2yMxphlHknWe1jkbOroZcBmxqu7SNkzu7s4txZjc1mw/Fkhjd1pFQ8uF9Eb8HlF7UO2t87tS0CBA75bx/dQl+D/eGhMg72GbLOmrYVC5CBA8/743x7Q5gilei3V/8BBM3pxgg1IIbniQBIxZlYTWgRERrn1kkE3UqVfpiobpsBwvmUq68Sb7gyg1wl0F8PPeXsMlLI9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HcFxn+vh+cmUjWWwr2Zk0DPAAWCPisQJqCD+Ci/qs9s=;
 b=ftX2SI4VkdQ/+lEUeVBQ2zMAeViYHPJKzA+2FdByOytTyPO0dgZyMNgcItXlik9m1PyAMrjaFM5G1WXNsdJto1Ygr5JVMZcs/vHawY25PqP6RIrXk+1vVqkcvhuSNA69j1svG2LeEfLLd+QMkuFKv7f2qchoDG4WcJkDZe/bbBy/ucdvVkRkKOsL3BwPfh/t9MiMs28mW+JqGbfsZBYKrhapCzXTvLPVN3bK5Yhngnpqs15JDuh4yqZlDQXk0lmGNLOSXOtcR3AcJRyXaVC4yIOGKtQ0pPu9Mu/hZuhxNGxmY76hnAgNTVVEcgdJxQtcBAWT7vM/J+6EqrUFvxtctA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HcFxn+vh+cmUjWWwr2Zk0DPAAWCPisQJqCD+Ci/qs9s=;
 b=FyzjjpLiDe6F6HvNF5QB56+nyhdkx8gesVyDHsqF/5UgVhs8a8uygUqi7EjHK9yWiv/tXUnIWlSVHD5tVn4CXzrzjBhESCoMV5kqdAKzmHVwT/7KGuIakPMhjlwnkhC6x2WFmHAKsDgaStiFIF8pxIqZ8TPkxT5zsCJR8VCcRog=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by DM4PR11MB5359.namprd11.prod.outlook.com (2603:10b6:5:396::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Mon, 30 May
 2022 15:36:27 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa%6]) with mapi id 15.20.5293.019; Mon, 30 May 2022
 15:36:27 +0000
From:   <Conor.Dooley@microchip.com>
To:     <i.bornyakov@metrotek.ru>
CC:     <mdf@kernel.org>, <hao.wu@intel.com>, <yilun.xu@intel.com>,
        <trix@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux-fpga@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <system@metrotek.ru>
Subject: Re: [PATCH v13 2/3] fpga: microchip-spi: add Microchip MPF FPGA
 manager
Thread-Topic: [PATCH v13 2/3] fpga: microchip-spi: add Microchip MPF FPGA
 manager
Thread-Index: AQHYcS+MqDCo1uYFDUerOTfzxMPcoq03TEoAgAAM4ICAACZ+gIAAAH0AgAATiYA=
Date:   Mon, 30 May 2022 15:36:27 +0000
Message-ID: <15ded39c-869b-e098-35a9-d5c7cce31dd9@microchip.com>
References: <20220526181344.2088-1-i.bornyakov@metrotek.ru>
 <20220526181344.2088-3-i.bornyakov@metrotek.ru>
 <f655cf2f-555c-6480-a461-bcddb9e510f3@microchip.com>
 <20220530120701.sedwn3qeohlnj52e@x260>
 <95c44458-aeff-e356-1e32-c8f735570c3a@microchip.com>
 <20220530142632.3a6wgxbpwjd6a6kh@x260>
In-Reply-To: <20220530142632.3a6wgxbpwjd6a6kh@x260>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c4f98e88-22ee-4cae-b81c-08da4252293d
x-ms-traffictypediagnostic: DM4PR11MB5359:EE_
x-microsoft-antispam-prvs: <DM4PR11MB5359CDCF56DE85013F75AE8998DD9@DM4PR11MB5359.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OugrrwTVL63V2j2e99qpX+aqJ2f3s7Z007QEmZSBCBJU9ghftRgAAGGYgeHHuxtNzfouyaPuizDo1ZoH5jft/G1sQaXeps36L3V/Z4tPijKx/xPS/bRgfserMI4+XNUQL8trWmnzOlYEJ8UlPNH/AfoicsctF5FJtIlQcw/uwdpUjPS+MsyJ3xdSjGlnfRDNszXUsDpSpUm6ZIX219o8eZx/p0UQuFa4UKQwCzJJsKsUvK/LRoYkGq9KFupaToTQnRgwLDzVzgnNPPWTxIHha7nQ1vJIOKn8OG2v84DdfeMUSv/S/O64Pw+x1azvnwDxroCXcal2S+DQpSB73i3F3M9dFJhrp75w3/l6+ihYP2jMgXsP2/Wsv+Ozh1B3ZGZmVaIq4SEAtW4nC2qmwqfZX81QJC649ZUR1xD+dK/JnQZS9dkI8U9uZYPqi7Zc9A5+AzWcAcwLGKAuCnrg1DM5iCY25k+p+4v7DWLz39XhvRRqpiXrUtEJP56qfHRV9NYQQV3YhckfXfJXVEmcajM1MQQUd64tPo0Nmao0Qg5QDMtAlxIPhe74bRuoJ1UENKtGf+htRkEc0qXpuOXUVZ1OB8cv5XqLw8iMHOq2FFJt2gFjeHF89hOlTbNsHhMqaHqlaryfDkCKEyNJLwlPcNyF2q+0dVXdRFZniUeWbdQFdfxLiE9iaZv7P9jEK2LS9id29jLJ6vuPSWXvWjWrVVaseG0scA6fwSI82cFUUaGjvlh7hjBVh16+mZuLmpHmoJrvHLTMj66UXgfkkmoOq3ATWNBFiGALCaBq+HIVlB1Zfi8a4Pq2Ek8ZZVJ36uoI3/ptfqFBbOMBTpqN7vjZMLMKl2oNqNlW7bwLNEoYQQTw9y6gljpveY8NeSZHu+cqZdW3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(53546011)(6506007)(38070700005)(31686004)(36756003)(316002)(54906003)(6916009)(2906002)(508600001)(186003)(966005)(6486002)(8936002)(31696002)(86362001)(66476007)(66556008)(4326008)(8676002)(64756008)(66446008)(5660300002)(7416002)(66946007)(71200400001)(91956017)(76116006)(6512007)(38100700002)(122000001)(26005)(45980500001)(15519875007)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WDMvL2lyQWh6RlVVa1N6NGlDMC9QSGJsc2RzakZhUW9DRlhiTTcxdDFINTdL?=
 =?utf-8?B?MkNjSTZSUXlnMlpzOER1OWxuRzNvWSttTjlOOEZuZjFwbm1kOS9HVExtWVRO?=
 =?utf-8?B?Y1NhVm5kU092NnJndE85ZzUrWGVUa2pXRHBJbW5QZnRKcnc4ckJTYVNrcmV4?=
 =?utf-8?B?TURBUzEyekRPTDU5MmVJcStpOVhjZVpKbUdVbWplUjVXNDZiWXdkNEdHc2R0?=
 =?utf-8?B?OFRXaGkrelhpdDZRZWpYOGlJSnNJTi9LVkR5ejVEaG9lSVRkQjh6eWNodElI?=
 =?utf-8?B?N0ZkY0NEa3UxVVBsN0xoa2dHV0p2WUx4Q1lsbUZOQjBRNGVISTJmdkxqRTN3?=
 =?utf-8?B?WUZNMGdvZUVEWnVnYjBVR2kxNVdyN2hxdzkxTmFlRE11VVRRZDJWQW9pOC9s?=
 =?utf-8?B?RXFWclE0ZW1ZallZZzNEZHFqN3prQzN1VkFxSkJWOWdJR0sxWm9qVEFWSlNN?=
 =?utf-8?B?WDhnK0RYU0ZYU1FURnlvL2w3ajVWYzlDdU1FVWxuNUpYWXkrK2QyWFlHQmZO?=
 =?utf-8?B?NEZxVGFrZTN3RWRPbFJGOEpnMExDTkROSVVDZk9FVlcwbE5tcEVyZXBoZmJE?=
 =?utf-8?B?eWxCNFRya2s1M0p0N3RScWJkZ2k4dSt0YlJCR29HOFE4LzNoVThCU2pzd1Zu?=
 =?utf-8?B?cVh6SVhWbTRsNEoxcUVJNXozcWo1YW1GNDViNDNDQVE4NkJ6SzY2aGF1dTNo?=
 =?utf-8?B?OXBud1dndll3bDVRNnZkenJYaWNIdnNvLzc2aStIVlVoZm9IeFRiNVAxNkxz?=
 =?utf-8?B?UndDZlRVenZSNnduY1dPZ3hSRkpjL1Y3Q1lpTWJPemtGeDR1emg5WStIc2VQ?=
 =?utf-8?B?S3I3RkptWStTTDV6QXcxQjhtelpLelVrR1NzTm9IRDlVeVVmQjhCdjdhRzFJ?=
 =?utf-8?B?cW9FbEFMYUx1dGluZHlUSVVkT2ZzdmRNNGJSekpCQWV1MFROMldYbVdwY3Z3?=
 =?utf-8?B?ZUVTZGhoV2V1M0V6N1dzak5wZkNZcnhiY3dIVjRFWHovTWl6ZXpCY3Y1djV1?=
 =?utf-8?B?eWFBYXZ4cXlvcElHeVUrTVRTa3lSTWFKbDJRVXB6M1I4VTcvNzNhKzBxV1ov?=
 =?utf-8?B?dFhzeXh5OXVMdUxiVTYvSFJOZnh6ZmZzQWNWMlM1RTBwcHJ5cWJJQ3BsM3o4?=
 =?utf-8?B?dS9EbzlacUI1Um9IVG1LckNGWkdwM3hkclptSzNxZHhXYUc1dE8vNy91WldC?=
 =?utf-8?B?T2gxRGtEVm44UnlKTmxvanlTUnFEb3I5d0xaVzEwWGo5TFBjMDNBUG80WGd0?=
 =?utf-8?B?TFJ2R3JhUEdPNDAyS0I4Z2lNY3pzNDd1aWxDY0Q0TDYwMEJTcUNNWWtETWo0?=
 =?utf-8?B?M3NidFBobmh2WjZOVG91OTgwS010MkxsTmVVbmVqWUpkejZpT0U2Uk5ZRjNZ?=
 =?utf-8?B?Nlo2RXhSWGtYK2hxWCtyc2RBWWE3Tzc4dmc1WEZZTjh2MU5hUTRSR1d2UkxW?=
 =?utf-8?B?SG9FUGV2T1NKZXF6WUFUNHREMGVpU3duS0VORmhxMlhtbEpJTXhGMVFOT2tE?=
 =?utf-8?B?Wk5VcUduUXVTa3RJTGJZcTA3NUUzYllVNmtSdWlkQkxDYVB3S0VSbklwWkRU?=
 =?utf-8?B?RE5HN3VDYU0wQk9mc2xNMkNvY1g4c3ErbVlqQVM0TUVGTWFFZHZRa3dKVGZP?=
 =?utf-8?B?UGpNeG12NHVmeUx1THVQMExncWdDYWZnSnNqdjBhWnNBdFhYdFBlL3R3ZGwy?=
 =?utf-8?B?R2hLQ1I3UW43VFU3NVNEeVMyd1g5TEJ4SXFxbWVQbzV1QmV2TS9XSCtnaDJJ?=
 =?utf-8?B?RHFscE1PTEFXTUNkQmtQQnVXenZVSEFsOEphZnR1Y1JxMlUrN1U4a0g0SS9R?=
 =?utf-8?B?SkRoR084L0xlbTJqMEs5ajhTL0tRMnk4bDdvaHlScEswRUx0SFMzWDNqanoy?=
 =?utf-8?B?SWY5VUZNR3V0RElMUW1LeHJ0ZnRXUDI0ZmM0d2J6ZUx4UnhwOVcyRmlWQ1lt?=
 =?utf-8?B?NHRyaTVmaTJteS9OdFFXSGNJd1dhYk9RR2NibmpwSzAvSk91aS9lYVBTZytS?=
 =?utf-8?B?WmM2MzJTdkduUlo0cW1WZlIvWDdJZS8yUnhVU0ZHRzNRcDc3OUcxenJlbUtZ?=
 =?utf-8?B?R1lReEY0ODZidVF0RW5UUm9jbWtnc2E5c0U0UzNNeVM1MUJ5cWcyZ0hQMTNi?=
 =?utf-8?B?T3I0RENzc0Z0Wk9WQjByVUo3akVzb0tqV0FpZVhxT25tYmxnMCtiRHhybC9j?=
 =?utf-8?B?dW9jNHNBSzQwRkMzSG9ZY2NCcnJmbDQrdGx2T0NJZUhHdkt1cUVmc2pBcVRE?=
 =?utf-8?B?eUpxbm1BT0d5SVFNVVd4RTNZUEx4OWlWYzNjdGZaRDg3N2U4RVBLaHk5SWNv?=
 =?utf-8?B?L0owSW9BcjBCM1J2RXM1SjZtM1oweHduRzJidVdPdU9KMCtLNmlLVWFOWUY1?=
 =?utf-8?Q?9h/wan9Lcu5zQSbU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <93E2CAA03C36054E91CB807C7B2C35AE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4f98e88-22ee-4cae-b81c-08da4252293d
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2022 15:36:27.2852
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mdw9drgBixN2j8mlKQt3R6pt1vfaAqMMK0vtlHs1iPOPXCkN0C1SVz2TGK469rnvamOUqcghYezlj2LC5k/Q9agFgxviIX6pJcfTC3CaG3g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5359
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

T24gMzAvMDUvMjAyMiAxNToyNiwgSXZhbiBCb3JueWFrb3Ygd3JvdGU6DQo+IEVYVEVSTkFMIEVN
QUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtu
b3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gTW9uLCBNYXkgMzAsIDIwMjIgYXQgMDI6
MjY6MThQTSArMDAwMCwgQ29ub3IuRG9vbGV5QG1pY3JvY2hpcC5jb20gd3JvdGU6DQo+PiBPbiAz
MC8wNS8yMDIyIDEzOjA3LCBJdmFuIEJvcm55YWtvdiB3cm90ZToNCj4+PiBFWFRFUk5BTCBFTUFJ
TDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93
IHRoZSBjb250ZW50IGlzIHNhZmUNCj4+Pg0KPj4+IE9uIE1vbiwgTWF5IDMwLCAyMDIyIGF0IDEx
OjIyOjI2QU0gKzAwMDAsIENvbm9yLkRvb2xleUBtaWNyb2NoaXAuY29tIHdyb3RlOg0KPj4+PiBP
biAyNi8wNS8yMDIyIDE5OjEzLCBJdmFuIEJvcm55YWtvdiB3cm90ZToNCj4+Pj4+ICtzdGF0aWMg
aW50IG1wZl9yZWFkX3N0YXR1cyhzdHJ1Y3Qgc3BpX2RldmljZSAqc3BpKQ0KPj4+Pj4gK3sNCj4+
Pj4+ICsgICAgICAgdTggc3RhdHVzID0gMCwgc3RhdHVzX2NvbW1hbmQgPSBNUEZfU1BJX1JFQURf
U1RBVFVTOw0KPj4+Pj4gKyAgICAgICAvKg0KPj4+Pj4gKyAgICAgICAgKiBUd28gaWRlbnRpY2Fs
IFNQSSB0cmFuc2ZlcnMgYXJlIHVzZWQgZm9yIHN0YXR1cyByZWFkaW5nLg0KPj4+Pj4gKyAgICAg
ICAgKiBUaGUgcmVhc29uIGlzIHRoYXQgdGhlIGZpcnN0IG9uZSBjYW4gYmUgaW5hZGVxdWF0ZS4N
Cj4+Pj4+ICsgICAgICAgICogV2UgaWdub3JlIGl0IGNvbXBsZXRlbHkgYW5kIHVzZSB0aGUgc2Vj
b25kIG9uZS4NCj4+Pj4+ICsgICAgICAgICovDQo+Pj4+PiArICAgICAgIHN0cnVjdCBzcGlfdHJh
bnNmZXIgeGZlcnNbXSA9IHsNCj4+Pj4+ICsgICAgICAgICAgICAgICBbMCAuLi4gMV0gPSB7DQo+
Pj4+PiArICAgICAgICAgICAgICAgICAgICAgICAudHhfYnVmID0gJnN0YXR1c19jb21tYW5kLA0K
Pj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgLnJ4X2J1ZiA9ICZzdGF0dXMsDQo+Pj4+PiAr
ICAgICAgICAgICAgICAgICAgICAgICAubGVuID0gMSwNCj4+Pj4+ICsgICAgICAgICAgICAgICAg
ICAgICAgIC5jc19jaGFuZ2UgPSAxLA0KPj4+Pj4gKyAgICAgICAgICAgICAgIH0NCj4+Pj4+ICsg
ICAgICAgfTsNCj4+Pj4NCj4+Pj4gSG1tLCBJIGRvbid0IHRoaW5rIHRoYXQgdGhpcyBpcyBjb3Jy
ZWN0LCBvciBhdCBsZWFzdCBpdCBpcyBub3QNCj4+Pj4gY29ycmVjdCBmcm9tIHRoZSBwb2xhcmZp
cmUgL3NvYy8gcGVyc3BlY3RpdmUuIEkgd2FzIHRvbGQgdGhhdA0KPj4+PiB0aGVyZSB3YXMgbm90
aGluZyBkaWZmZXJlbnQgb3RoZXIgdGhhbiB0aGUgZW52bSBiZXR3ZWVuIHRoZQ0KPj4+PiBwcm9n
cmFtbWluZyBmb3IgYm90aCBkZXZpY2VzIC0gYnV0IHRoaXMgaXMgYW5vdGhlciBzaXR1YXRpb24N
Cj4+Pj4gd2hlcmUgSSBzdGFydCB0byBxdWVzdGlvbiB0aGF0Lg0KPj4+Pg0KPj4+PiBXaGVuIEkg
cnVuIHRoaXMgY29kZSwgSVNDIGVuYWJsZSAvbmV2ZXIvIHBhc3NlcyAtIGZhaWxpbmcgZHVlDQo+
Pj4+IHRvIHRpbWluZyBvdXQuIEkgc2VlIHNvbWV0aGluZyBsaWtlIHRoaXMgcGljdHVyZSBoZXJl
Og0KPj4+PiBodHRwczovL2kuaW1ndXIuY29tL0VLaGQxUzMucG5nDQo+Pj4+IFlvdSBjYW4gc2Vl
IHRoZSAweDBCIElTQyBlbmFibGUgY29taW5nIHRocm91Z2ggJiB0aGVuIGEgc3RhdHVzDQo+Pj4+
IGNoZWNrIGFmdGVyIGl0Lg0KPj4+Pg0KPj4+PiBXaXRoIHRoZSBjdXJyZW50IGNvZGUsIHRoZSB2
YWx1ZSBvZiB0aGUgInN0YXR1cyIgdmFyaWFibGUgd2lsbA0KPj4+PiBiZSAweDAsIGdpdmVuIHlv
dSBhcmUgb3ZlcndyaXRpbmcgdGhlIGZpcnN0IE1JU08gdmFsdWUgd2l0aCB0aGUNCj4+Pj4gc2Vj
b25kLiBBY2NvcmRpbmcgdG8gdGhlIGh3IGd1eXMsIHRoZSBzcGkgaHcgc3RhdHVzICpzaG91bGQq
DQo+Pj4+IG9ubHkgYmUgcmV0dXJuZWQgb24gTUlTTyBpbiB0aGUgZmlyc3QgYnl0ZSBhZnRlciBT
UyBnb2VzIGxvdy4NCj4+Pj4NCj4+Pj4gSWYgdGhpcyBpcyBub3QgdGhlIGNhc2UgZm9yIGEgbm9u
IC1zb2MgcGFydCwgd2hpY2gsIGFzIEkgc2FpZA0KPj4+PiBiZWZvcmUsIEkgZG9uJ3QgaGF2ZSBh
IGJvYXJkIHdpdGggdGhlIFNQSSBwcm9ncmFtbWVyIGV4cG9zZWQNCj4+Pj4gZm9yICYgSSBoYXZl
IGJlZW4gdG9sZCBpcyBub3QgdGhlIGNhc2UgdGhlbiBteSBjb21tZW50cyBjYW4NCj4+Pj4ganVz
dCBiZSBpZ25vcmVkIGVudGlyZWx5ICYgSSdsbCBoYXZlIHNvbWUgaGVhZCBzY3JhdGNoaW5nIHRv
DQo+Pj4+IGRvLi4uDQo+Pj4+DQo+Pj4+IFRoYW5rcywNCj4+Pj4gQ29ub3IuDQo+Pj4+DQo+Pj4N
Cj4+PiBJZiBJIHVuZGVyc3Rvb2QgY29ycmVjdGx5LCBTUyBkb2Vzbid0IGFsdGVyIGJldHdlZW4g
dHdvIHN0YXR1cyByZWFkaW5nDQo+Pj4gdHJhbnNhY3Rpb25zIGRlc3BpdGUgLmNzX2NoYW5nZSA9
IDEuIE1heSBiZSBhZGRpbmcgc29tZSAuY3NfY2hhbmdlX2RlbGF5DQo+Pj4gdG8gc3BpX3RyYW5z
ZmVyIHN0cnVjdCBjYW4gaGVscCB3aXRoIHRoYXQ/DQo+Pg0KPj4gRC1vaCAtIGJ1ZyBpbiB0aGUg
c3BpIGNvbnRyb2xsZXIgZHJpdmVyIDopDQo+IA0KPiBTbywgbm8gYWRkaXRpb25hbCBkZWxheSBp
cyBuZWVkZWQ/DQoNCkNvcnJlY3QsIHByb2dyYW1tZWQgc3VjY2Vzc2Z1bGx5IHdpdGhvdXQgY2hh
bmdpbmcgdGhlIGRlbGF5Lg0KDQo+PiBMR1RNIG5vdywgc3VjY2Vzc2Z1bGx5IHByb2dyYW1tZWQg
bXkgUG9sYXJGaXJlIFNvQyB3aXRoIHYxMi4NCg0KVHlwbywgdGhpcyBzaG91bGQgYmUgdjEzDQoN
Cj4+IEknZCBhbG1vc3Qgc3VnZ2VzdCBhZGRpbmcgYSBjb21wYXRpYmxlIGZvciBpdCB0b28gLSBi
dXQgc2luY2UNCj4+IHRoZSBlbnZtIHByb2dyYW1taW5nIGRvZXNuJ3Qgd29yayBJIGRvbid0IHRo
aW5rIHRoYXQgd291bGQgYmUNCj4+IGNvcnJlY3QuDQo+Pg0KPj4gVGVzdGVkLWJ5OiBDb25vciBE
b29sZXkgPGNvbm9yLmRvb2xleUBtaWNyb2NoaXAuY29tPg0KPj4NCj4+IFdpdGggYSBzbWFsbCBj
b21tZW50IGFib3V0IHdoeSBpdCdzIHVzaW5nIHNwaV9zeW5jX3RyYW5zZmVyKCk6DQo+PiBSZXZp
ZXdlZC1ieTogQ29ub3IgRG9vbGV5IDxjb25vci5kb29sZXlAbWljcm9jaGlwLmNvbT4NCj4+DQo+
IA0KPiBUaGFua3MgZm9yIHlvdXIgYXNzaXN0YW5jZSwgQ29ub3IhDQo+IA0KPj4+DQo+Pj4+PiAr
ICAgICAgIGludCByZXQgPSBzcGlfc3luY190cmFuc2ZlcihzcGksIHhmZXJzLCAyKTsNCj4+Pj4+
ICsNCj4+Pj4+ICsgICAgICAgaWYgKChzdGF0dXMgJiBNUEZfU1RBVFVTX1NQSV9WSU9MQVRJT04p
IHx8DQo+Pj4+PiArICAgICAgICAgICAoc3RhdHVzICYgTVBGX1NUQVRVU19TUElfRVJST1IpKQ0K
Pj4+Pj4gKyAgICAgICAgICAgICAgIHJldCA9IC1FSU87DQo+Pj4+PiArDQo+Pj4+PiArICAgICAg
IHJldHVybiByZXQgPyA6IHN0YXR1czsNCj4+Pj4+ICt9DQo+Pj4NCj4+DQo+IA0KDQo=
