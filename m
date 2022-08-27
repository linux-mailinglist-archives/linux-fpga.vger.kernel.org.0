Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9BAF5A3829
	for <lists+linux-fpga@lfdr.de>; Sat, 27 Aug 2022 16:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbiH0Oqs (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 27 Aug 2022 10:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiH0Oqq (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 27 Aug 2022 10:46:46 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B4C52A71F
        for <linux-fpga@vger.kernel.org>; Sat, 27 Aug 2022 07:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661611606; x=1693147606;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Jbw4OpMTySxfQES4FtDl6Q2u6HobmCZ71pPPillOylY=;
  b=a0tyEjzUeXYEWK7Yzhw5uqdSRh7/ViMtmcjhm1kR8jiB/uT/5qTWzesv
   7JiucnuRVEDoPbd/c1yPXjpsFlNnr61mHVyMQnOS40YL6EhGU6cLH7CeV
   Pl794gJAZ5FD3zF/9lkk9Cy5ZLmlncsdMLBtSXsgsl9tvyXmg6fo1bn6o
   TeAgR16ZkrvJTBBqE9ojSAOoqboM0oCqZqRx7i4n1tQ0109LDA+b9CNgm
   V0/suaUgRTknNcWqNG87X4fhNl/rx3o3ItQGvAjwWvRXGgYpiVhAGo5JS
   r402k0zxQFscWMokdaS7wQbiprM7xbQsd93C4EGPUKBMMF5yySbyVa2wG
   A==;
X-IronPort-AV: E=Sophos;i="5.93,267,1654585200"; 
   d="scan'208";a="171244367"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Aug 2022 07:46:44 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Sat, 27 Aug 2022 07:46:42 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Sat, 27 Aug 2022 07:46:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S7WacjBogjcqVuVdBo4qe9ay8M4v4IOZE8Su+UucTI+BEzjDwBBCHbAM2fJ5c7zYrOHnuzikgPIxhEo7I4D37MD6sdHGRlmZ402PGENPiwwrwcCdYzFE0zBbcMWhEnNOIqnDtM/VVup8gVd7riuDP8Fn18D5hAdKCFJDsll9/FWa96grnu1fz8JBlM+tWBpkiWGJ/HlX6taUd7Jemu3VJjH6UHSiq2m610mBItUXCXdObgVst9fFFgrut4MtO/9Xo/I4mQbVnhr/xzXrCAiAQO/hJTBQ/bE53X0ZTEXki171e2+vXEk+XrWQN/FV6jd3Pctd4cBNi/OfRLT5QHTyig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jbw4OpMTySxfQES4FtDl6Q2u6HobmCZ71pPPillOylY=;
 b=jHzy+qyitxX/nwm3VpvrZ9qpWBhySrEmrX8Feaj5QWpLAIFl/avS5CDZw0msCDQSXxuvmmK6Fvg/zr7NM9TxCuDu7kxsdex2cYyMfSDCO+LzLreKGh7fCSp9/DWpw3YZIlD43MJizpNLRo68tKeWH09VUY4737/06BCN5Nzf0X07x5Z3nK/QcVdOeI7ub6UUjPwHDUmUZF9T5JTuj0JtsyWw3DDGUugwrvUQOzXOB3+uyM8KDxmFF7gJiYBiGxc1zqYX1uJbS/W0URej7slAUjln83rI89jYdWitEsMb5xX5MNfgiwgsASNYDdZ2rx7Jam7/rgvV0OBql/IZDDFgQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jbw4OpMTySxfQES4FtDl6Q2u6HobmCZ71pPPillOylY=;
 b=SKihCjpDdyB5Y3JgjKWp8YZDLqq+TT5X/t/3YtBzGj6iTArioQOuvHLg0Cdb0xIhgcLzJ2M/q/0BfGQJI8ttPCZH9MUP8eywG8kIGtvFeTYi/KYiCdQo2Vv+OFggJcICcRo6qCHhSNrWfvONoCG2tOFDpLRf94KKnxYSD65jYQE=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by CY5PR11MB6367.namprd11.prod.outlook.com (2603:10b6:930:39::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Sat, 27 Aug
 2022 14:46:37 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%9]) with mapi id 15.20.5566.019; Sat, 27 Aug 2022
 14:46:37 +0000
From:   <Conor.Dooley@microchip.com>
To:     <yilun.xu@intel.com>, <dengshaomin@cdjrlc.com>
CC:     <mdf@kernel.org>, <hao.wu@intel.com>, <linux-fpga@vger.kernel.org>,
        <trix@redhat.com>
Subject: Re: [PATCH] fpga: stratix10-soc: Fix comments typo
Thread-Topic: [PATCH] fpga: stratix10-soc: Fix comments typo
Thread-Index: AQHYuJFnexcyDXt9SUu0fdR4l+dodK3Cz8aAgAAGtYA=
Date:   Sat, 27 Aug 2022 14:46:37 +0000
Message-ID: <f6a0b8a7-99cc-0974-564c-f2a215b5fc26@microchip.com>
References: <20220825144155.2345-1-dengshaomin@cdjrlc.com>
 <YwoorTXmTwOFfIwz@yilunxu-OptiPlex-7050>
In-Reply-To: <YwoorTXmTwOFfIwz@yilunxu-OptiPlex-7050>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 80c52a47-ab5c-4905-87a2-08da883af214
x-ms-traffictypediagnostic: CY5PR11MB6367:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ib19ObcJ3b8kARbjnP2De59q+ekRtG4lT6I/xb+E3PBxjL6czv3zqsEDk1+DlGJg8hUVcjXvEULE8IIXP53G7LM+nJGGcyzkClutVYsP214QKonZz73xLCi+/sSTcfv6TAqPbQYvW9hJwKF8cHo5g3iDAWJEyFJeEgYCGPBsWEia7h7zyGEayu5z7l5RtvTpqeJMYgYtoy7Q44PZkz6ipTwyVZkVqfaLT9kkKYKtBvoEEBDj5KbHVDyixMpdoS+OcuFAPClDgXQNYmhEQXkFprHCuEeNmALQw6c0eJ1po6ZmSzHkBMQKHpjf+Imn3ls6MdE04Q844aeM9ozdwlc4+hVbRCKvYqCQXKbi/wxD6hbxsClQjUzj6voZ2oh1qVl1J1GvbpeTLSDCksQAJUrNEWymyEZD4cYx2fuwewIkMLMuLxYGdsE/zBSLIPtTTUDLMFiYZRcM3Vpuik7sZDdSeoEDz+LjBaImmZyjZ4IDoad3ZS19Xp9T+8IxtqauDc5glV9QTDfSn64N/AVx2Q9bqPyM/RLMUxuRe6ArEE1Vm6R/XW8AOyl1kdup7hbjOfiRvi82NAHDEkPDasxeNYuU7RQJumKSUIKRvx8zRgKzlX9gnuCnI1IDN9ihdZO9bvUJotrXstq1r/SPc3O3Zpsgut4yTZfxEEIK0q1lNTLq5Ox6UumuDQyF9kID3+7X7YeJavTUhrbfaCSMazqaUWAu/ho7mYrpIduqOiVft4EYZVOvpZtm10A7R6gc9tD1nya3871nkte7ksA/vvaIkWf5iRIH4WkYlDc3a0xu3vT4ZPFXfdtE/KLnbKPH/JpEkZAUlXl6vs5GkcrAYxzuILmWCA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(136003)(396003)(366004)(346002)(39860400002)(8936002)(36756003)(31696002)(76116006)(83380400001)(2616005)(6486002)(31686004)(186003)(91956017)(4326008)(8676002)(86362001)(66556008)(66946007)(64756008)(66476007)(66446008)(478600001)(26005)(41300700001)(38070700005)(316002)(110136005)(122000001)(5660300002)(54906003)(53546011)(2906002)(71200400001)(6506007)(38100700002)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K24vNUhrTkJKclpWSE5HNlZ5MDROZTV0TW5VcUNTbVdLZVZGa1VldUViS2Zs?=
 =?utf-8?B?V1Z5a2QwREp6UERKcUVSaXU3TEswaDAyOXhzQ2VLYVptT1RHMTV1NW9sOGxt?=
 =?utf-8?B?MU9hKzdSZ2xiWDFLK3VwbHFJYXE2akNoL0hyemd2TUI3KzFFcVM5bVNORjlM?=
 =?utf-8?B?SUs4UWRXM1FyK0xyZnJudUUvMmZ5cXM5MmZLbmZmd3ZoMTlIbDhNbjQ1VGJE?=
 =?utf-8?B?Yy9FbTRMTWR5MlNmLzFTWXhMN21FRGZXdzhvL0doVEtNVERoWDdtYkY3enpk?=
 =?utf-8?B?ek9OMDV0WUZwcGJyRnVzNk9VSkZkYTlJcEtqUHZiY1A3eDYvbExoUXdodkVa?=
 =?utf-8?B?am5BR0ZxTzE1YzRaU3FCRE4vcWdPRWpENVg2dkV3MXJsTHBLdGwrTUl1eFlv?=
 =?utf-8?B?WVBUcWlHMmU0bjBwemZJSHFrMjFLTlZHVmV2MGhYZDFYT0xXdFYyMXpFVmZF?=
 =?utf-8?B?UU44TUJsVDhGVEJTZHBhaGFHUjRGWndhN3h2Z1JkQjV6VUFsZFY2OElrK3Nt?=
 =?utf-8?B?Tml6OVpJcTlmNHExR2NEQWd0Z1psVmdtZzNDdlNLelkvMlU0OHgyYitYVmw3?=
 =?utf-8?B?SlNUSitsaHBVdnNNblFNdXRLQmR0dUxUSnExV3FacHFUeDNXMzBjL2RjVDZw?=
 =?utf-8?B?MW5hWTJDenY1NmdUeG94NXRGNHNVVE4reXFaa09ldTVGZDlwbDk3VytsQnMw?=
 =?utf-8?B?dDZTUkNHdmhOMS80eXR5OWJ4UzFGSWZ5T0pJUldPTXhXUXBaMDhqekVBRW4v?=
 =?utf-8?B?UjBBYkJ2LzRiT1NQaHdTTFRIVHEzZnlhZjcxZ2xDOWQ3enhTSWVhV3JrMGJr?=
 =?utf-8?B?elRneW1ycXd5TGlnOEFjL1REME8ybTRjckFVN3R0cUNnWjlQd2pTZnl6cVpz?=
 =?utf-8?B?dlFXdGFIaXJyY20zdDNoeEpOa2JYUlZVdElyK29zbjhVYXFXRmYrbW43cTB5?=
 =?utf-8?B?Ukdvb2RRcEVaeE9lOHpuNWc3VitRQXVhb3V0amF5WisySmhlR1lDRTF0TWVy?=
 =?utf-8?B?RldubDRJdy9WdHJta1lWV2RUL1BDY0paZFREcUt0NDNEbTlFOWVQbzNwdG1q?=
 =?utf-8?B?bGU1cCttUHJxeGlYc1M0SXhaQnFPQzNEd3c1UUIwSGZwYzFDWGJYaUFoL3dU?=
 =?utf-8?B?WHViK0FsNnUvTEpFTWhtRldVWjlnY1lMSFBFTUN4VTF3bndUMnVUM3hQT1lM?=
 =?utf-8?B?ZTdub1p4L1JvNUhXaHRENXhTWSs4dFg2Yjd4eUJQVEwxRmhVM2Y3Y2xJU2VF?=
 =?utf-8?B?NGdrVDdvVUNreVAyWjNnM0R2TXp2MFFqZ1lFSHJPSHNCT1ltekdVdnBxNzBU?=
 =?utf-8?B?aURudVhkMHR3b1pKOTNkTTFleUZqeHR1ZGFYOEY2eTJNVDdYUmdLZ2lnMVpS?=
 =?utf-8?B?Rjd2MHV2ZDFFSXB1eHc3WUxIOFcyYTZweGxYaHFIYm1HK3ZyRHZFRU5SQ2xm?=
 =?utf-8?B?RDdwdlJKTWw3Q0paaWFkR1FMR1cwbmVocVU2dFRqdkxhMkJpeGRjdXlNVW9W?=
 =?utf-8?B?L3FWZ2VkalZxazVMZmMwWGlXOHJjY1BGcmNTS004OFVadjh5Z3BQSm9DWE9w?=
 =?utf-8?B?VEc1bEpVVnZwUjl3MmFCbGxTZDJVN2ZmQnhIamVHUW1SclNSU0FnK1MyY2hB?=
 =?utf-8?B?cCtUdTZHOEdKUVZXNVNrd3dnYVltOXFhOHdUdGlSSUdLd3FaSGtjeGdObHpp?=
 =?utf-8?B?MmpZRTF0VFVyZGlLVGxqbWsyOGpsVk5SRzJvbHNZTnN1U3Vtc3NNM1d4eE9r?=
 =?utf-8?B?T0U5S2ZxQklaenRtUy9iY1pPdHlXWlBHSFUzelptTnAybXRSMGxnSG9LMURj?=
 =?utf-8?B?SVpYWWd6SUw1clFKNlQxUGJIVG9NclJodnhrbWpYV3dDVUY0SWloZFpXSmRB?=
 =?utf-8?B?THZvRFZKK3pNYUY1eXhTRVl0S3hmbm9pUk5YMVdBT3JUT0ZOM21wWGRPVU5p?=
 =?utf-8?B?N3lkanU5ckUwcUNhaFNxLzNoSEhNampwZkhnc0d0SUYrSG9uQ256OFprdGJX?=
 =?utf-8?B?VVVFVlRuR3JNclNUeGxlelVnd0p1djh0TURzRUlMSkRYSkJxZVRPaTI1Q1Nj?=
 =?utf-8?B?YlRjL3RhQ2FpZ0dPak5rN1k3UEN6R2FWajJ6eXNrWjZzNFZaM3lIRGlaMVNk?=
 =?utf-8?Q?8XUe2XK8uTbZLsb4tPX1m/GgA?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <78D15199396D8A44A3BAE1B4EC3EB5AB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80c52a47-ab5c-4905-87a2-08da883af214
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2022 14:46:37.6634
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cU5Y3kyVidKaisRB2LeNz1TYDJCTs1FZ0beHHsqoUVg0JNAE0yk8J1pCw7SZw2zjHOrnoOHZ083cd2OtoXMNQ06autwSTjCyi+THcbx7yLc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6367
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

T24gMjcvMDgvMjAyMiAxNToyMiwgWHUgWWlsdW4gd3JvdGU6DQo+IE9uIDIwMjItMDgtMjUgYXQg
MTA6NDE6NTUgLTA0MDAsIFNoYW9taW4gRGVuZyB3cm90ZToNCj4+IERlbGV0ZSB0aGUgcmVwZWF0
ZWQgd29yZCAiaWYiIGluIGNvbW1lbnRzLg0KPiANCj4gUGxlYXNlIGRvbid0IGR1cGxpY2F0ZSBz
aW1pbGFyIHBhdGNoZXMuDQoNCkl0IHByb2JhYmx5IGlzIG5vdCB0aGUgcmlnaHQgZml4IGVpdGhl
ci4uLg0KDQo+IA0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFNoYW9taW4gRGVuZyA8ZGVuZ3NoYW9t
aW5AY2RqcmxjLmNvbT4NCj4+IC0tLQ0KPj4gIGRyaXZlcnMvZnBnYS9zdHJhdGl4MTAtc29jLmMg
fCAyICstDQo+PiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0p
DQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZnBnYS9zdHJhdGl4MTAtc29jLmMgYi9kcml2
ZXJzL2ZwZ2Evc3RyYXRpeDEwLXNvYy5jDQo+PiBpbmRleCAzNTdjZWE1OGVjOTguLmU0ZjJlODNh
NjE1YiAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvZnBnYS9zdHJhdGl4MTAtc29jLmMNCj4+ICsr
KyBiL2RyaXZlcnMvZnBnYS9zdHJhdGl4MTAtc29jLmMNCj4+IEBAIC0yODUsNyArMjg1LDcgQEAg
c3RhdGljIGludCBzMTBfb3BzX3dyaXRlKHN0cnVjdCBmcGdhX21hbmFnZXIgKm1nciwgY29uc3Qg
Y2hhciAqYnVmLA0KPj4gIA0KPj4gIAkvKg0KPj4gIAkgKiBMb29wIHdhaXRpbmcgZm9yIGJ1ZmZl
cnMgdG8gYmUgcmV0dXJuZWQuICBXaGVuIGEgYnVmZmVyIGlzIHJldHVybmVkLA0KPj4gLQkgKiBy
ZXVzZSBpdCB0byBzZW5kIG1vcmUgZGF0YSBvciBmcmVlIGlmIGlmIGFsbCBkYXRhIGhhcyBiZWVu
IHNlbnQuDQo+PiArCSAqIHJldXNlIGl0IHRvIHNlbmQgbW9yZSBkYXRhIG9yIGZyZWUgaWYgYWxs
IGRhdGEgaGFzIGJlZW4gc2VudC4NCg0Kcy9mcmVlIGlmIGlmL2ZyZWUgaXQgaWYNCg0KTm90IHN1
cmUgaWYgdGhlIGNkanJsYyBwZW9wbGUgYXJlIHNjcmlwdGluZyB0aGVzZSBkdXBsaWNhdGUgd29y
ZCByZW1vdmFscw0KYnV0IGlmIHNvLCB0aGV5IHNob3VsZCBjaGVjayB0aGUgb3V0cHV0IGJlZm9y
ZSBzZW5kaW5nIGIvYyB0aGlzIHNlZW1zIHRvDQpoYXBwZW4gYSBsb3QuDQoNClRoYW5rcywNCkNv
bm9yLg0KDQo+PiAgCSAqLw0KPj4gIAl3aGlsZSAoY291bnQgPiAwIHx8IHMxMF9mcmVlX2J1ZmZl
cl9jb3VudChtZ3IpICE9IE5VTV9TVkNfQlVGUykgew0KPj4gIAkJcmVpbml0X2NvbXBsZXRpb24o
JnByaXYtPnN0YXR1c19yZXR1cm5fY29tcGxldGlvbik7DQo+PiAtLSANCj4+IDIuMzUuMQ0KPj4N
Cg==
