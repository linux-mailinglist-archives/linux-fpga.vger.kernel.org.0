Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB15951FAF4
	for <lists+linux-fpga@lfdr.de>; Mon,  9 May 2022 13:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbiEILIk (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 9 May 2022 07:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232034AbiEILIe (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 9 May 2022 07:08:34 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D7A2AC7;
        Mon,  9 May 2022 04:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1652094273; x=1683630273;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=XdYabM9i4OKCPbcSvEymT6dG1qwngVwWRZbABfDR/7I=;
  b=s8r0P9f6beF9BgHbHpV7h1Yukm/6Mwa2wRkpdd2fIAXknhEpfihx2RBr
   UQOBuBefh20EuQSWgZsWM9qbWs99ylFq4+dpq8dZOAtCSedRLTs/Pkv30
   grR6g2JUb8Yi+p53+hxun5wWDMDW/UXfEjwm7mJiyt3D6Vuc/RsyYlNF7
   +LUBuYsEBfhfMXp0DczfXPdmjRwnFM8f4dk8wUEJ8XkizBh+Z2ivKFWeN
   v1vxwiyZGb0HjOVA4fl+4WYChGEJkS9l+mA8O14EPI2t0dTfT7f8QG4a+
   jpagahOhyy73DGcFoNpNdVVgetFqxnNX0Jmm+6flsR9jmr0J8zNknAA4E
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,211,1647327600"; 
   d="scan'208";a="155271194"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 May 2022 04:04:31 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 9 May 2022 04:04:30 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Mon, 9 May 2022 04:04:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hqLR9xlQLr2huwr/KiBGYCaqm2O1o5pxGlX/XqD3z6KRLeRS390/FymDZUkbFuko6vlolaCCcnZ1W5WTtNOonF0c6n/wjPkvBLtQhFfwBv+9l0EScnbj9ZNS+PD9ZiSGtkCmNZ6yYqTIEMR0jByA6d1oD2Xdh8FpzVVpooGtUAA9WOcV9uz04iI/SBeby61EzoGSdTOB12Kz3VgT9ohtnFRuYLE7sNU3QoK5UxW3tgWQVB4EyDx9dJhC+AzdpuaJJPrY3oBhDxO7MAFfLWiM73V8HTCwPPy4Nr/7OUikb5Ncr8k0mPvEmbx7bAtl9slQVy+blQMKnl3EuGqM2S7paw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XdYabM9i4OKCPbcSvEymT6dG1qwngVwWRZbABfDR/7I=;
 b=Jk5gkSaUhKlN07CRMT5pFXoW9Nvpv4218tUQ7tr7mHCcIRucf0jr5Jtm5ccEJ2pcqT2kKEiGm4LMZqaeila9Dizlw5oL1f4jmOAkjTgP6lf35lzMj0GiQIH4m8JVWGg7nuhSpwc+sJBU4ZwBzp2nW1yxm6zF+TFc50oJIC+sw0pmkCS6L9EhDxjrufCQ0sc/SwhQlV4YChq4pSu0kIjxEfeTgo5BpQG8kQwJXa/mdhL62NdDK6RSk9rSAECpi/IpAyjdoiX9qSzGP0CVvz+XE2g+ejzghpzaMeoN7aBZoU2vb+kkdM3HuYLkrnvha8/Ahid5hiDesCK6ZFDvdxBgnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XdYabM9i4OKCPbcSvEymT6dG1qwngVwWRZbABfDR/7I=;
 b=YKM+53KnXrlwI5aj28vx/l+HsgJKp3ZFD1M+hf6yWInprjrGjBVDpX4LLJ6vA0Cep7VRe7si5FcqowE0oeVSn1NEw41BxhnOxVXYU3BDCrj1DDnTPnjrCqkkY6Y2jO0DnKl86xKmVK/eVksfU+eY1XsJC6BdB9jUOWX0ZBi70sU=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:95::7)
 by MW4PR11MB5823.namprd11.prod.outlook.com (2603:10b6:303:186::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Mon, 9 May
 2022 11:04:26 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::fcd4:8f8a:f0e9:8b18]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::fcd4:8f8a:f0e9:8b18%9]) with mapi id 15.20.5206.025; Mon, 9 May 2022
 11:04:26 +0000
From:   <Conor.Dooley@microchip.com>
To:     <i.bornyakov@metrotek.ru>
CC:     <mdf@kernel.org>, <hao.wu@intel.com>, <yilun.xu@intel.com>,
        <trix@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux-fpga@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <system@metrotek.ru>, <robh@kernel.org>
Subject: Re: [PATCH v11 3/3] dt-bindings: fpga: add binding doc for
 microchip-spi fpga mgr
Thread-Topic: [PATCH v11 3/3] dt-bindings: fpga: add binding doc for
 microchip-spi fpga mgr
Thread-Index: AQHYYekg9yR0xB36oU63bWZfc6n4yK0WZSyA
Date:   Mon, 9 May 2022 11:04:26 +0000
Message-ID: <38a6ffc1-6e28-8720-d165-9abad323a04f@microchip.com>
References: <20220507074304.11144-1-i.bornyakov@metrotek.ru>
 <20220507074304.11144-4-i.bornyakov@metrotek.ru>
In-Reply-To: <20220507074304.11144-4-i.bornyakov@metrotek.ru>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 12592c75-72f4-4211-4a65-08da31abae6d
x-ms-traffictypediagnostic: MW4PR11MB5823:EE_
x-microsoft-antispam-prvs: <MW4PR11MB5823C10F79A321EA9731852A98C69@MW4PR11MB5823.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E5WubN0M/US0YaN9tq+ojRwmR8i/xWztQCNu07Ml/Nw4Gd8TNAXaXyJFMgej9M5bARlImjrtxOCsQFNGgi4Cng/XAGcQ3kxFSwHDrsu94xlK5H2UVppge12r7CIkxhrvqK37zoR/p1Ui8BdZ4gC0GuunPL3253UTdZFlULL/tXY12g60bj/iPG5KXm5q5i+25lcrPc4D4+J8Klz7CavH6QD9XNlMxoESTZNCik9lXWDN+amdWpxdPFRPXhQ1qYAuYav8Cub31uuut675Rc/etVbJvhMQMPu+uooJFW9dRBdGwCrL5EGIdf/0IQlr5WlU8xylEdhF2EEMjbcQvhyhIEDTF+EB7OPfeG9FUnJiSHUDi0aAVBNpiv1++6YY5Z5dlmSpFjppJSvMVRxgBXjLhuTCiG2CyUOSMuWmBO96IzsbTbAwmWaryuKrFuchtoP3fMUumWSu4vau6zYmz+q6dWUgyx8XteC8pFBSkS7j6RemTpn3J/YS/AzZrc3dmtzRC77bvX4SnRmlA36wPdI8QCxESTQp784ZocUi3vGqkiHIyPtmfW+jTRwuTB7NqCXMpkFRxe++Rn3SY2M8OFV5RwLddqH7uQmS0lenDINdnC71x3VCi7TzvpATogOlkirv6JloKaXbko+e2JZOFfQdq4ns9id5UFb//qDItpCrpPf8S36YIEdfBDKZXLcwUI5e7/q2gJ19VzW8GroEgwEuJmUygx//HQJSAxeR4cUvgNfs6fsfpP/3wUfvLc/YU1WhmioeNQ3KX1xnzZrsgW2CPqqn2zTIQyhucYNwDijtR2c4iut+9dJkHCaa8oo6W7nQpjsn76/gLouvb0UO2q3wlEiPMQSDjBW06IbnLm87XvrPzD5KTgEjbLsPg0dacDni8ciR3Pqi6yCBSW8WwXGLHw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(91956017)(8676002)(2906002)(66446008)(4326008)(66476007)(76116006)(66946007)(66556008)(64756008)(5660300002)(7416002)(8936002)(38070700005)(38100700002)(122000001)(26005)(6512007)(31696002)(186003)(2616005)(53546011)(6506007)(6916009)(316002)(54906003)(966005)(6486002)(508600001)(36756003)(71200400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U3c3Yy93SDVsM05QTUdtRmJYMC9aZW0vR2xuNDNZMXJWeHpEckVBaFE4VEl1?=
 =?utf-8?B?V0Z5UFhXOEk0SUpwUEVpUkVrTEtZbkhEbUplZkFtN2RpQ3QxZUJSZ1dyKzRU?=
 =?utf-8?B?UEpmWmNlamFUaSt5WkYvTWVnbnBITTZ5Z1B3blN6WlFWVEdnN2Rsb3QxdWVR?=
 =?utf-8?B?NlQ1ZlV1US9oc3prdEVjazdvZTU5cU5NR0RaNVoxcjlYZlZ3MzBhZzllR2NU?=
 =?utf-8?B?ZjBnTFJReEJZY09iYnkzNzBCL0RmUVhHYS90TXdUVnEvanVtRlZJbmpGc1Fq?=
 =?utf-8?B?VE9BdE9FbVZLd1NVNklENjJUY0lseEVjVS9LK1BwNjM2dWU0Z3ZGTThzYjFW?=
 =?utf-8?B?Z3VvaWZVeGhRY1c2L1FaNDdPd2tkWm9IMXo4MU4zR1VQYW5md01RWTZwaUJs?=
 =?utf-8?B?dVd3c1EraHJZLytFV2VHeWNUK0VLb0Z1Wk9iRFI5NXJPUnU0Wkd6dVlRSjVv?=
 =?utf-8?B?OFM2Um03elA4ZzVkeU83MmVpMmFXRHZwbDhrcFRQQTcydkxvRmI5L0NtOXZF?=
 =?utf-8?B?ZEtMVFo5elV5ekZJbUVJREd0ZkJ6Kzc4ei9Jbm1wbC9OdjhTTnpOYmpHcnpY?=
 =?utf-8?B?eUlYdHZseGhJclYvY1dqby9NKzlWM2lSWEZoWVVTUmk0REVVUlZpSCswckpU?=
 =?utf-8?B?ZVlpNER3OVErSXpyWlIwdTNvREhOT0lhUEdoU2JDZ2lUU0FuaE5ROUZwbHFj?=
 =?utf-8?B?NWNJb1BmLzlKRm92YVR6T3VUMkhTU29Qa0xTYXk4Si9GWlR0aENDQm54UFA4?=
 =?utf-8?B?NVBwRnZvWVlqM2VER0tNSDN0azhNNm9SbnNwc3dIN0xPWm5WSDN2TGNiUXJV?=
 =?utf-8?B?NG9xeThYYVl1ZVdqTUZ5cXMwYnd3UGt1VmVjZThCYURlWStUKzNSMFBCdTBa?=
 =?utf-8?B?RTU5VEdtUkJMOENDYURlRjVzcUxzbGhQOTljUUJPOTNsblJEbWF2Z2FnVWhs?=
 =?utf-8?B?SWxXUytFMmhnMlArSmZienVHTW1OWTY0cTFlKzhhK2tab2tzdnBsS2hhOFRr?=
 =?utf-8?B?UytVT3ZlNHA4L3F4RkRvazRCSGJIVEIzQ2V6WGk1MndidUNFTytGM3R5ZWxt?=
 =?utf-8?B?L1lGRHU5enF4TjRSRVlzaHJTeVBycDR5Zmg1cml2WmFFVTgxeUpVSVhvUTVH?=
 =?utf-8?B?S1hic1hPWFh5ckRlY0hxYXE2WWZRNURseXJ6UFhiSW1BbDI5Qit5dWJySUFo?=
 =?utf-8?B?TXdGZXlEbkpIWHZCei90Q1hCS01mUlVoRkUyU2FpbVpHQzVwM3h4MG00SFNk?=
 =?utf-8?B?bENMWHhUUXVqOG5obnlYZU5VclRzYzlXSzE1WTM1UEdRZUg3RHZWcHpMS0NT?=
 =?utf-8?B?ZDdlQ0tYOExudDE4MnRPRWpWbTdyUFF4TGZ0dGJTTGg1SU01ME1OSDg0SWx3?=
 =?utf-8?B?NUVxYVZlNjg3ekJnbVVLTkNPRHJZRnhvVEw2VSsrOHByZXZSaXNUQ3dGQXZR?=
 =?utf-8?B?bUJDaUNoUFkwMnowa2VFMUg4WUc4dXB5UDFsOWQ2MWtic3c2cmszb0VkRnUv?=
 =?utf-8?B?SGZMWm1JKzBDb09rMUdHNWM5a0VIc0txdE1hZWxhMGJFS1ZKS3MwajI4cURM?=
 =?utf-8?B?ckp4cjJXaVFGN2FpS21OSVRsVGVYSW5udHorTHNBbG93WjVXNHdJWGxQM1ZF?=
 =?utf-8?B?STVEcGlVbFcycDZTSHM4N1dNaGUzUUJ2V1ZsVGZ5dFcrR0k1N1NWUDdJVlBr?=
 =?utf-8?B?UFZ3N0xvMzBkRExmOHdKV2FxVHgyMGNtRFB0aDdCWmRxN0JIWG01MFA4aDRX?=
 =?utf-8?B?U09pZHR6b1gydVRINWVESjVwYjVoeTdDdVhBL3RkdFQ0WkRoQjhtcytqcERP?=
 =?utf-8?B?V3Jta0NsTVhwSFErSXJrQkVvLzFsM0Z5T0hLRmxYcFg4ejc3WGhUZ1M4RlFt?=
 =?utf-8?B?SzZlcHJEOHhqRkwrSCtUeDB2T21ZQitpamUvcjB6ekk4ZEg5VnlqT0JwaEt4?=
 =?utf-8?B?dldGeHQ1Nlh6QWMrdFBjVHhrVXJuWHJKVU9mTXVYYlAraFhUSnQxbDcwc09y?=
 =?utf-8?B?SmxjaU5jWnpCU3hNbnE1Y21abW1zRUNTYnp2dlBhQUtDYjZMWUNYc2dWWDB1?=
 =?utf-8?B?cXR5R3B1QTh2aTNyMGtFNXhHVlUvMVBNMG5KNHc2dDRMYzJ1ckVVcUtMS0hI?=
 =?utf-8?B?aHZsNEFjeHd6aVd2YzVNNmFYdXZiL2oxaHJQWko2eTJaWWJKODhvOHNBUC93?=
 =?utf-8?B?VGg2NVZrVEZxbzZTMHZuSnB2VWhPaElTbHhraFJQQWxHVGNQY3pMMy8xZGZ6?=
 =?utf-8?B?ZWNLM05TeFVkWXdUVHNQTW1YU3pMTGREaDc0QUthUk9MVHd3MU83MUdtMEgz?=
 =?utf-8?B?VU5iV1F0c2ZOVmRMUDRVcndIMExmWFZNUnB0eXVEN2NKOGtYRmJ0QT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <36E51B03F24F854AA646453F0E0E142F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12592c75-72f4-4211-4a65-08da31abae6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2022 11:04:26.1444
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HJNmKcspCEMWHFif93QyoxGB2oefqavgLwKOgobf8EGu15JwKawnfeBpsSRqrpsAbdrbP3zKnlz5ajqEBoYkuwfhUpJ3tj5vof9pJMbJQJE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5823
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

SGV5IEl2YW4sDQpPbmUgY29tbWVudCBoZXJlLg0KVGhhbmtzLA0KQ29ub3IuDQoNCk9uIDA3LzA1
LzIwMjIgMDg6NDMsIEl2YW4gQm9ybnlha292IHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJTDogRG8g
bm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBj
b250ZW50IGlzIHNhZmUNCj4gDQo+IEFkZCBEZXZpY2UgVHJlZSBCaW5kaW5nIGRvYyBmb3IgTWlj
cm9jaGlwIFBvbGFyZmlyZSBGUEdBIE1hbmFnZXIgdXNpbmcNCj4gc2xhdmUgU1BJIHRvIGxvYWQg
LmRhdCBmb3JtYXR0ZWQgYml0c3RyZWFtIGltYWdlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSXZh
biBCb3JueWFrb3YgPGkuYm9ybnlha292QG1ldHJvdGVrLnJ1Pg0KPiBSZXZpZXdlZC1ieTogUm9i
IEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz4NCj4gLS0tDQo+ICAgLi4uL2ZwZ2EvbWljcm9jaGlw
LG1wZi1zcGktZnBnYS1tZ3IueWFtbCAgICAgIHwgNDQgKysrKysrKysrKysrKysrKysrKw0KPiAg
IDEgZmlsZSBjaGFuZ2VkLCA0NCBpbnNlcnRpb25zKCspDQo+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0
IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9mcGdhL21pY3JvY2hpcCxtcGYtc3Bp
LWZwZ2EtbWdyLnlhbWwNCj4gDQo+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvZnBnYS9taWNyb2NoaXAsbXBmLXNwaS1mcGdhLW1nci55YW1sIGIvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2ZwZ2EvbWljcm9jaGlwLG1wZi1zcGktZnBnYS1t
Z3IueWFtbA0KPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiBpbmRleCAwMDAwMDAwMDAwMDAuLmFl
ZTQ1Y2IxNTU5Mg0KPiAtLS0gL2Rldi9udWxsDQo+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9mcGdhL21pY3JvY2hpcCxtcGYtc3BpLWZwZ2EtbWdyLnlhbWwNCj4gQEAg
LTAsMCArMSw0NCBAQA0KPiArIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogKEdQTC0yLjAtb25s
eSBPUiBCU0QtMi1DbGF1c2UpDQo+ICslWUFNTCAxLjINCj4gKy0tLQ0KPiArJGlkOiBodHRwOi8v
ZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9mcGdhL21pY3JvY2hpcCxtcGYtc3BpLWZwZ2EtbWdyLnlh
bWwjDQo+ICskc2NoZW1hOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvbWV0YS1zY2hlbWFzL2NvcmUu
eWFtbCMNCj4gKw0KPiArdGl0bGU6IE1pY3JvY2hpcCBQb2xhcmZpcmUgRlBHQSBtYW5hZ2VyLg0K
PiArDQo+ICttYWludGFpbmVyczoNCj4gKyAgLSBJdmFuIEJvcm55YWtvdiA8aS5ib3JueWFrb3ZA
bWV0cm90ZWsucnU+DQo+ICsNCj4gK2Rlc2NyaXB0aW9uOg0KPiArICBEZXZpY2UgVHJlZSBCaW5k
aW5ncyBmb3IgTWljcm9jaGlwIFBvbGFyZmlyZSBGUEdBIE1hbmFnZXIgdXNpbmcgc2xhdmUgU1BJ
IHRvDQo+ICsgIGxvYWQgdGhlIGJpdHN0cmVhbSBpbiAuZGF0IGZvcm1hdC4NCg0KSSd2ZSBzZWVu
IEtyenlzenRvZiBzYXkgYSBidW5jaCBvZiB0aW1lcyB0byByZW1vdmUgIkRldmljZSBUcmVlIEJp
bmRpbmdzIiBmcm9tIGhlcmUuDQoNCisNCj4gK3Byb3BlcnRpZXM6DQo+ICsgIGNvbXBhdGlibGU6
DQo+ICsgICAgZW51bToNCj4gKyAgICAgIC0gbWljcm9jaGlwLG1wZi1zcGktZnBnYS1tZ3INCj4g
Kw0KPiArICByZWc6DQo+ICsgICAgZGVzY3JpcHRpb246IFNQSSBjaGlwIHNlbGVjdA0KPiArICAg
IG1heEl0ZW1zOiAxDQo+ICsNCj4gKyAgc3BpLW1heC1mcmVxdWVuY3k6IHRydWUNCj4gKw0KPiAr
cmVxdWlyZWQ6DQo+ICsgIC0gY29tcGF0aWJsZQ0KPiArICAtIHJlZw0KPiArDQo+ICthZGRpdGlv
bmFsUHJvcGVydGllczogZmFsc2UNCj4gKw0KPiArZXhhbXBsZXM6DQo+ICsgIC0gfA0KPiArICAg
IHNwaSB7DQo+ICsgICAgICAgICAgICAjYWRkcmVzcy1jZWxscyA9IDwxPjsNCj4gKyAgICAgICAg
ICAgICNzaXplLWNlbGxzID0gPDA+Ow0KPiArDQo+ICsgICAgICAgICAgICBmcGdhX21nckAwIHsN
Cj4gKyAgICAgICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJtaWNyb2NoaXAsbXBmLXNwaS1m
cGdhLW1nciI7DQo+ICsgICAgICAgICAgICAgICAgICAgIHNwaS1tYXgtZnJlcXVlbmN5ID0gPDIw
MDAwMDAwPjsNCj4gKyAgICAgICAgICAgICAgICAgICAgcmVnID0gPDA+Ow0KPiArICAgICAgICAg
ICAgfTsNCj4gKyAgICB9Ow0KPiAtLQ0KPiAyLjM1LjENCj4gDQo+IA0KDQo=
