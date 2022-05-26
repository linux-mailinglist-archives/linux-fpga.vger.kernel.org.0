Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31684535579
	for <lists+linux-fpga@lfdr.de>; Thu, 26 May 2022 23:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240553AbiEZV1h (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 26 May 2022 17:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiEZV1g (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 26 May 2022 17:27:36 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB338ABF49;
        Thu, 26 May 2022 14:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653600454; x=1685136454;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4DuKeA3s/jzgFjymtbw7eFFaNX4xkVage28n4f4jWDc=;
  b=AK0CrbbAuX193o1Sf/XBp4wsCzVulWntagNWWaMPbJW+KaWkX2JGV7h1
   bRKsv6Lj4Ol4a/Y5E0MpA4kZ71VTt0XYCDHMFIQJRUwZ+lpLhhPdPYvYl
   QS5d1NtkcZDYyYuDBHPl9JslqpnwHwpFBJwOfmQcciT2ODZ78WENtuWpq
   4Hh/2RH4dIlUCTddh+TzJg7TOktg1tJWpYbQZ9dQlAbt7cibjK6601r52
   rHtwSW7drMggRMVC+jRdVto+Ap7nqar1BAAWOzVz+j7RBztfLmkBd/Jjm
   xSARtE4zdMqx+4JxZhaJj2ezLmUl7comp2xGf/thvtOB+XcZS/OM9uT6f
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10359"; a="360681581"
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; 
   d="scan'208";a="360681581"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2022 14:27:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; 
   d="scan'208";a="574110326"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga007.jf.intel.com with ESMTP; 26 May 2022 14:27:33 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 26 May 2022 14:27:33 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 26 May 2022 14:27:33 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.106)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 26 May 2022 14:27:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SZKiJDqZjrOa2V7uFzEhq4hA6mhz9Z48jHfoZByZBiVisW1ARYydU42hG2G5Y92xBdQ7wAmpHsREhu19KAVn8L/HDbpbeGrr8ks36D5ANYCMBzJqwJafHMqmwxVcPvAn2BaROLRLAI/MBzxw3enCv/mv3NNnmu76SbZq06/yfaxE/QrDO/lG2UI56Y5eiLvT/2eSjygediTd8uIknCaG+nU6xc/Pi0e7qDUYgxKVMX2exlBV6lboC7bq49mH22iMJoukl7S7oFDR/l/rSZahT6cSiSWiqBrK1fZmUbh9lk3K6PTckTFEeae+OyPM7HZptaAiyszvs539rtLo3SIGVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T7vEGbqgjYgHdOSWt4VupjXK3QkLhNRTAGl50B+yC7s=;
 b=NOLsSohvgE/lfJM2xKaRMAZJDRLZthttBnT4A4reEhMt+QEIx1wbBdlZFK8pZ59vf5HgMcNt1XbMqzPEM/MFoAry1tYjLamebhrj8FJhkz5uiLFQqfDts/6ISQNQXNQplN9FSNNOk0Xw1LZnL34gIwL5kbeiXzvs+ZyHSzQX5Z4v71+Ny7KmGHhsOAS6Z7z1Mfxexn57Gxd0mmhVTFPtnntnkq61q0LR+eqKI4tSBPVm4Q863BLzpTU4abiMrv/zCCisbvHI7xfCIPjB0G2T9VbJFSylvlDzzdCFO1QxIpf+fZiETa6nC2ZpvH2G0vouZBdAoDwnXqeTKSX9sgB47w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM5PR11MB1899.namprd11.prod.outlook.com (2603:10b6:3:10b::14)
 by CO1PR11MB4996.namprd11.prod.outlook.com (2603:10b6:303:90::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Thu, 26 May
 2022 21:27:30 +0000
Received: from DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::b9cb:2e5f:f3ef:f397]) by DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::b9cb:2e5f:f3ef:f397%6]) with mapi id 15.20.5273.023; Thu, 26 May 2022
 21:27:29 +0000
Message-ID: <4cd795ae-1648-9f0c-7b1c-68f761e83d79@intel.com>
Date:   Thu, 26 May 2022 14:27:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.8.1
Subject: Re: [PATCH v21 5/5] fpga: m10bmc-sec: add max10 secure update
 functions
Content-Language: en-US
To:     Xu Yilun <yilun.xu@intel.com>
CC:     <mdf@kernel.org>, <hao.wu@intel.com>, <lee.jones@linaro.org>,
        <linux-fpga@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <trix@redhat.com>, <marpagan@redhat.com>, <lgoncalv@redhat.com>,
        <matthew.gerlach@linux.intel.com>,
        <basheer.ahmed.muddebihal@intel.com>, <tianfei.zhang@intel.com>
References: <20220521003607.737734-1-russell.h.weight@intel.com>
 <20220521003607.737734-6-russell.h.weight@intel.com>
 <20220526074856.GA148394@yilunxu-OptiPlex-7050>
From:   Russ Weight <russell.h.weight@intel.com>
In-Reply-To: <20220526074856.GA148394@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR02CA0002.namprd02.prod.outlook.com
 (2603:10b6:303:16d::10) To DM5PR11MB1899.namprd11.prod.outlook.com
 (2603:10b6:3:10b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 419c21e5-09e9-401b-ecc3-08da3f5e89c2
X-MS-TrafficTypeDiagnostic: CO1PR11MB4996:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <CO1PR11MB499683ED34DEEC13C1B66AF3C5D99@CO1PR11MB4996.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pzEJx8XKLhulo11iktPc5sxL78qK/d1ATQe+7RgyLnos9zcXY2yZlSt6aOn0sBfpiiJMQdGjYiDSA2RubUfz7o53MBTzXu78KFI+GjTkVagxCi7Ge4LSM47zFvPwXakX5QBrTqHV2E0IZjyEP/8kjiTvPch4mIDKfG1kn9gIhsuSQb3ZbvXH0bFnUV0NW8mO8neEgbocNle1z3RKtNsLlUccgbeloqSslKFioNtv8nrJ1nmqBII7Kg3b2QjMcwcZDpovuc6K0b1VNG5C1HImc9qP8cixjTot/1qHMOOBniDfPZPkZlYUAGLZyZ6ReYzvirkjGwL7nDJbcmhR5TIbUiMb5M4alIHVzDqKSDFq8e+d6r8NwucZ8qGRQyrfUiF50gimtPXbcklXbGaTkFn8HSoFrciKwq9M1+8avSfZTu4/X8oX2QAUuS0fHgLp3TJ+rfM/szCWZgHis/ry1QxBbAKBNhfEjeWmev8p845YB37IEqF5uBahMX76HKqCp6kE/nOSn1CJyhaDBbym5/xZhqwkNr+p7C+Lj9KgRhi3M5ayzYE6f7GWqN1gqQxNRMcJgA9WVPHLUgM/PwgiQKzBw4sPzpG7VnKztyYQRA/71jrHXlDhE40PWWozg2KN53J14tihvE+ibp5ZXKnEAQIO1WSyZLicC2xyXQAMZLoPX9r3R3+8iVld2YfeglV2mF7UPPZZIk8hDi6xpm04fo2rW9jbj3fZM2cKD9UUSr40yJX9xOr2r0h2/JJehuumq7/elPfBuyLBgc9DkMszOUejLi84wtHkekB2RrCpaBVh6/pP6ezt8nCM7bO2FnAjhTDw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1899.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(82960400001)(37006003)(6636002)(36756003)(83380400001)(316002)(2616005)(186003)(26005)(5660300002)(31686004)(508600001)(31696002)(6506007)(53546011)(6512007)(966005)(30864003)(15650500001)(6486002)(8936002)(2906002)(8676002)(66556008)(6862004)(66476007)(4326008)(86362001)(6666004)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXBzK0s3UWdlRE4xRkFCQWpXUXhQbVVueVNSNENuM21jdkE4YnU3S3g4bW9M?=
 =?utf-8?B?SmdSRUllRk9nbDB4UkJjS0g3UnNnL1B1UnBKUlJXb0VSZkZYOFk1eVhtTDZX?=
 =?utf-8?B?ZnFXd3dPWklZbjRIa1dEcFZFVGVsd28ycENPR3ptaEVBTFFmTEtTNGw3cnZa?=
 =?utf-8?B?QWpxTkE4S0ZjY29sYnBodFFpOTFRRzMyN3dhWWtLalhvTE9kWDhHZlBMdUNt?=
 =?utf-8?B?N1VTK2ZKQ0RYcEVsQW5xWEdJWWdCQTZER2tkNzEzU1ZiNy9ldFo2ZGovTDc2?=
 =?utf-8?B?bDQ2Nzk5MlRCeTBYSUVYM1d1WTNleUZjWG1nYkhOZ0twN3RzQmhScDBFeHFO?=
 =?utf-8?B?RTFVbjdQbmc5Tzc5cG1uMEhFTlgwOWhTbmFuUzdGZUo0c0kyb0p1TFFYV1Fj?=
 =?utf-8?B?QXFVUzVsdVJuTktkSFcwbVByR1NLT09aUjRuU3IwL29Ma1BqVzJ6K3BZYjQ0?=
 =?utf-8?B?QzYzanM2T0J6bmwrRDVoUURGYTMrcy8wY2xOYnV1di9OelZBblh5VkQzVTVT?=
 =?utf-8?B?cDhOazErSWlvMFBXQlRhVzA4c0FnNzV3bThiZDhhUGlSS25VOENmMFJveTdG?=
 =?utf-8?B?Vk5xNE1vcmRBVFpHRkJaQzVTQXozb25xYkRiclpmQ2VDRTVIWEc5b3JJWDVs?=
 =?utf-8?B?ZW0rLytmSXpXRUw3WkNQNkNEMWhZa2I1T3o5NGdoMXIwOWxYdURkVTRXYU1I?=
 =?utf-8?B?VTNtNm4zN2Q0UkF4Vlk0aTVmdTI1Z3BHdnpvWWV6RFl4d3dEaUkvUWd5a0Fo?=
 =?utf-8?B?T0pST3o2dWJ4ZTBwTUF2R2JheGNhVVV1MUNMRGdUWDQycjVhdVRkeXlPKzhV?=
 =?utf-8?B?MDFpb2M1cDg0UTRlK1J6RlAyN1c2OEtVYjNCVXpZYWIrQnRuT0h0amZpQXoy?=
 =?utf-8?B?ZkRtUXFqWndsamx6aWNKZStHVnhyQTdaUHVhMmVaUmFwYVFsQS9QcmNGdXVC?=
 =?utf-8?B?UkYvTVlCdWR2b2F5L3VBZDdMaGVabkliRVpTazVoTU9EeXFvQWRaREFVeEJJ?=
 =?utf-8?B?M3JOOXp5a245TnRsWVZTV0hFNVBJRTMwVXQ4RkVVUEpIV090dVBiRFljdm56?=
 =?utf-8?B?L0IrMCtMbG9PY3R0UXhNeHMyVmdxOUtnem91WW5zVUMzUXh3S3FaM3k5b3BP?=
 =?utf-8?B?N2IwdmxjQkg4QmEzZ3lKNVdGbG1qbFFPeXk0b01palNkbFYvWVdrTDBKODVo?=
 =?utf-8?B?K2ZQbW9ycFYyMFFqbEI2Tll5Wk9XclpORzVSNGQ1WUg1ZzlmYjduSHlTSktx?=
 =?utf-8?B?VmZUdm5BVmdrQndqeWtKYTk4OHdNQVA1aHZ6WFAzVnpveEFCam9tU2J1NVZI?=
 =?utf-8?B?VWR6S0tqb1I0b1MySDg1QzZ5VDVFV2VRd0lNcVhpVHpRY2FUVUNtUSs5UCto?=
 =?utf-8?B?WEU5dHVUeUpKaE1TNEdKNGtGZythcXVFb3hyU0dCY2pHQmlLYi9GU28wMVdF?=
 =?utf-8?B?MHpINVJpSVlTekJCU1l0OGlpRGVWUk9PdWNXd2V3QlJnd1NLWHE1NlN4MWEy?=
 =?utf-8?B?SmlOaU5iNFhmVkQyNTQ0NktSaFB0R3JCT2toYWF3WmpCQUd2YnhNQ045VFRs?=
 =?utf-8?B?MHM4YU5tTlJTNG9mM1JEMkU1V2pTaFIvU3lHTWpKOGdKODBwOXorK1gvZ3By?=
 =?utf-8?B?STlvVnlMNUJ6QW5oWlFSMUZOK29XT0NWaUdBbmVxa1prQ2cwMXFxSDRUUGFk?=
 =?utf-8?B?N2NqckxKMEp6MWtnamx1ZDVjZG5sU2w3ZWVHTE14bDl6bTFENXE2MzJFa0ZI?=
 =?utf-8?B?aWhOTG1nSlM3cFVnOWoyM2tERVB6cWY1SG1xVTdUeXIvVmxWLzlSSDdIbDdE?=
 =?utf-8?B?U2R4Y0d5ZlUvaVV3SEkvMFBaLzVFVUJ2NVZNN2NndXpuSldhVnlFNDNTZHhT?=
 =?utf-8?B?aHpjRC8xNWdheGNzeWIvZUl5TkRhd3B3UmdHbHVwVXdSMUlVNHhtNDJMcGRF?=
 =?utf-8?B?Zk9kdU95S2RuWTRKdTgwVHByeTJubDI2bzd3ajFlRHp5MDJONUE2cUJNTkJo?=
 =?utf-8?B?VmRtaU9nWG0wRVIwcDBVQXQyR0J6OHVKakxhcU5iOEhBd1U0WlZWbFFzUGRS?=
 =?utf-8?B?aGd5WXNOVmVnR0Jmc05qY05POG4rVFA0SC80YnNoVzdweWMrMGVhaXJJMUkz?=
 =?utf-8?B?QmUwTFZQVndwTzVvL0diRFJXSnpqUkpXT0k3TkxtcTl2N2ZoWWpybE1qbjY1?=
 =?utf-8?B?cEdFd1d4YzFDYmM0YzVDNGNmVWNvci9QZVY2VjBOVHFCTDU5YmpvNm9tRHhW?=
 =?utf-8?B?bmpTa1F1VEZQZTB6bERaQjRScVdhOHBJVER2QzFWMlh0OTc4cFgwU0VOdEpQ?=
 =?utf-8?B?ZXRCbWpsUDc4bklROEdyYnJUUFBpcFFNa1hQVFBEWUd4aGhGaW1NNWIrWFQw?=
 =?utf-8?Q?slW/GxX+2fjTXE3M=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 419c21e5-09e9-401b-ecc3-08da3f5e89c2
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1899.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2022 21:27:29.8637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iwURIPi8xHuBt2DjhleU+OFWZCpHP3/81uzpJNidlRAGCR86J5oJ5VbA1cyeukhkcuizX5ZNuiIP1E+NOD6RsKcxqknE0deHhHxY5HphEXo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4996
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 5/26/22 00:48, Xu Yilun wrote:
> On Fri, May 20, 2022 at 05:36:07PM -0700, Russ Weight wrote:
>> Create firmware upload ops and call the Firmware Upload support of the
>> Firmware Loader subsystem to enable FPGA image uploads for secure
>> updates of BMC images, FPGA images, etc.
>>
>> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
>> ---
>> v21:
>>   - Update m10bmc_sec_prepare() to ensure that the base address for an
>>     update image is aligned with stride.
>>   - Update m10bmc_sec_write() to handle a block size that is not aligned
>>     with stride by allocating a zero-filled block that is aligned, and
>>     copying the data before calling regmap_bulk_write().
>> v20:
>>   - No change.
>> v19:
>>   - Change "card bmc" naming back to "m10 bmc" naming to be consistent
>>     with the parent driver.
>> v18:
>>   - Moved the firmware_upload_register() function here from an earlier
>>     patch since this is where the required ops are provided.
>>   - Moved the bmc_sec_remove() function here from an earlier patch to
>>     unregister the firmware driver and do cleanup.
>> v17:
>>   - Change "m10bmc" in symbol names to "cardbmc" to reflect the fact that the
>>     future devices will not necessarily use the MAX10.
>>   - Change from image_load class driver to the new firmware_upload 
>>     functionality of the firmware_loader.
>>   - fw_upload_ops functions will return "enum fw_upload_err" data types
>>     instead of integer values.
>> v16:
>>   - Use 0 instead of FPGA_IMAGE_ERR_NONE to indicate success.
>>   - The size alignment check was moved from the FPGA Image Load framework
>>     to the prepare() op.
>>   - Added cancel_request boolean flag to struct m10bmc_sec.
>>   - Moved the RSU cancellation logic from m10bmc_sec_cancel() to a new
>>     rsu_cancel() function.
>>   - The m10bmc_sec_cancel() function ONLY sets the cancel_request flag.
>>     The cancel_request flag is checked at the beginning of the
>>     m10bmc_sec_write() and m10bmc_sec_poll_complete() functions.
>>   - Adapt to changed prototypes for the prepare() and write() ops. The
>>     m10bmc_sec_write_blk() function has been renamed to
>>     m10bmc_sec_write().
>>   - Created a cleanup() op, m10bmc_sec_cleanup(), to attempt to cancel an
>>     ongoing op during when exiting the update process.
>> v15:
>>   - Adapted to changes in the FPGA Image Load framework:
>>     (1) All enum types (progress and errors) are now type u32
>>     (2) m10bmc_sec_write_blk() adds *blk_size and max_size parameters
>>         and uses *blk_size as provided by the caller.
>>     (3) m10bmc_sec_poll_complete() no long checks the driver_unload
>>         flag.
>> v14:
>>   - Changed symbol names to reflect the renaming of the Security Manager
>>     Class driver to FPGA Image Load.
>> v13:
>>   - No change
>> v12:
>>   - Updated Date and KernelVersion fields in ABI documentation
>>   - Removed size parameter from the write_blk() op. m10bmc_sec_write_blk()
>>     no longer has a size parameter, and the block size is determined
>>     in this (the lower-level) driver.
>> v11:
>>   - No change
>> v10:
>>   - No change
>> v9:
>>   - No change
>> v8:
>>   - Previously patch 5/6, otherwise no change
>> v7:
>>   - No change
>> v6:
>>   - Changed (size / stride) calculation to ((size + stride - 1) / stride)
>>     to ensure that the proper count is passed to regmap_bulk_write().
>>   - Removed unnecessary call to rsu_check_complete() in
>>     m10bmc_sec_poll_complete() and changed while loop to
>>     do/while loop.
>> v5:
>>   - No change
>> v4:
>>   - No change
>> v3:
>>   - Changed: iops -> sops, imgr -> smgr, IFPGA_ -> FPGA_, ifpga_ to fpga_
>>   - Changed "MAX10 BMC Secure Engine driver" to "MAX10 BMC Secure Update
>>     driver"
>>   - Removed wrapper functions (m10bmc_raw_*, m10bmc_sys_*). The
>>     underlying functions are now called directly.
>>   - Changed calling functions of functions that return "enum fpga_sec_err"
>>     to check for (ret != FPGA_SEC_ERR_NONE) instead of (ret)
>> v2:
>>   - Reworked the rsu_start_done() function to make it more readable
>>   - Reworked while-loop condition/content in rsu_prog_ready()
>>   - Minor code cleanup per review comments
>>   - Added a comment to the m10bmc_sec_poll_complete() function to
>>     explain the context (could take 30+ minutes to complete).
>>   - Added m10bmc_ prefix to functions in m10bmc_iops structure
>>   - Moved MAX10 BMC address and function definitions to a separate
>>     patch.
>> ---
>>  drivers/fpga/intel-m10-bmc-sec-update.c | 409 ++++++++++++++++++++++++
>>  1 file changed, 409 insertions(+)
>>
>> diff --git a/drivers/fpga/intel-m10-bmc-sec-update.c b/drivers/fpga/intel-m10-bmc-sec-update.c
>> index 65fec2a70901..7c48c47a74a6 100644
>> --- a/drivers/fpga/intel-m10-bmc-sec-update.c
>> +++ b/drivers/fpga/intel-m10-bmc-sec-update.c
>> @@ -17,8 +17,14 @@
>>  struct m10bmc_sec {
>>  	struct device *dev;
>>  	struct intel_m10bmc *m10bmc;
>> +	struct fw_upload *fwl;
>> +	char *fw_name;
>> +	u32 fw_name_id;
>> +	bool cancel_request;
>>  };
>>  
>> +static DEFINE_XARRAY_ALLOC(fw_upload_xa);
>> +
>>  /* Root Entry Hash (REH) support */
>>  #define REH_SHA256_SIZE		32
>>  #define REH_SHA384_SIZE		48
>> @@ -192,10 +198,380 @@ static const struct attribute_group *m10bmc_sec_attr_groups[] = {
>>  	NULL,
>>  };
>>  
>> +static void log_error_regs(struct m10bmc_sec *sec, u32 doorbell)
>> +{
>> +	u32 auth_result;
>> +
>> +	dev_err(sec->dev, "RSU error status: 0x%08x\n", doorbell);
>> +
>> +	if (!m10bmc_sys_read(sec->m10bmc, M10BMC_AUTH_RESULT, &auth_result))
>> +		dev_err(sec->dev, "RSU auth result: 0x%08x\n", auth_result);
>> +}
>> +
>> +static enum fw_upload_err rsu_check_idle(struct m10bmc_sec *sec)
>> +{
>> +	u32 doorbell;
>> +	int ret;
>> +
>> +	ret = m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, &doorbell);
>> +	if (ret)
>> +		return FW_UPLOAD_ERR_RW_ERROR;
>> +
>> +	if (rsu_prog(doorbell) != RSU_PROG_IDLE &&
>> +	    rsu_prog(doorbell) != RSU_PROG_RSU_DONE) {
>> +		log_error_regs(sec, doorbell);
>> +		return FW_UPLOAD_ERR_BUSY;
>> +	}
>> +
>> +	return FW_UPLOAD_ERR_NONE;
>> +}
>> +
>> +static inline bool rsu_start_done(u32 doorbell)
>> +{
>> +	u32 status, progress;
>> +
>> +	if (doorbell & DRBL_RSU_REQUEST)
>> +		return false;
>> +
>> +	status = rsu_stat(doorbell);
>> +	if (status == RSU_STAT_ERASE_FAIL || status == RSU_STAT_WEAROUT)
>> +		return true;
>> +
>> +	progress = rsu_prog(doorbell);
>> +	if (progress != RSU_PROG_IDLE && progress != RSU_PROG_RSU_DONE)
>> +		return true;
>> +
>> +	return false;
>> +}
>> +
>> +static enum fw_upload_err rsu_update_init(struct m10bmc_sec *sec)
>> +{
>> +	u32 doorbell, status;
>> +	int ret;
>> +
>> +	ret = regmap_update_bits(sec->m10bmc->regmap,
>> +				 M10BMC_SYS_BASE + M10BMC_DOORBELL,
>> +				 DRBL_RSU_REQUEST | DRBL_HOST_STATUS,
>> +				 DRBL_RSU_REQUEST |
>> +				 FIELD_PREP(DRBL_HOST_STATUS,
>> +					    HOST_STATUS_IDLE));
>> +	if (ret)
>> +		return FW_UPLOAD_ERR_RW_ERROR;
>> +
>> +	ret = regmap_read_poll_timeout(sec->m10bmc->regmap,
>> +				       M10BMC_SYS_BASE + M10BMC_DOORBELL,
>> +				       doorbell,
>> +				       rsu_start_done(doorbell),
>> +				       NIOS_HANDSHAKE_INTERVAL_US,
>> +				       NIOS_HANDSHAKE_TIMEOUT_US);
>> +
>> +	if (ret == -ETIMEDOUT) {
>> +		log_error_regs(sec, doorbell);
>> +		return FW_UPLOAD_ERR_TIMEOUT;
>> +	} else if (ret) {
>> +		return FW_UPLOAD_ERR_RW_ERROR;
>> +	}
>> +
>> +	status = rsu_stat(doorbell);
>> +	if (status == RSU_STAT_WEAROUT) {
>> +		dev_warn(sec->dev, "Excessive flash update count detected\n");
>> +		return FW_UPLOAD_ERR_WEAROUT;
>> +	} else if (status == RSU_STAT_ERASE_FAIL) {
>> +		log_error_regs(sec, doorbell);
>> +		return FW_UPLOAD_ERR_HW_ERROR;
>> +	}
>> +
>> +	return FW_UPLOAD_ERR_NONE;
>> +}
>> +
>> +static enum fw_upload_err rsu_prog_ready(struct m10bmc_sec *sec)
>> +{
>> +	unsigned long poll_timeout;
>> +	u32 doorbell, progress;
>> +	int ret;
>> +
>> +	ret = m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, &doorbell);
>> +	if (ret)
>> +		return FW_UPLOAD_ERR_RW_ERROR;
>> +
>> +	poll_timeout = jiffies + msecs_to_jiffies(RSU_PREP_TIMEOUT_MS);
>> +	while (rsu_prog(doorbell) == RSU_PROG_PREPARE) {
>> +		msleep(RSU_PREP_INTERVAL_MS);
>> +		if (time_after(jiffies, poll_timeout))
>> +			break;
>> +
>> +		ret = m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, &doorbell);
>> +		if (ret)
>> +			return FW_UPLOAD_ERR_RW_ERROR;
>> +	}
>> +
>> +	progress = rsu_prog(doorbell);
>> +	if (progress == RSU_PROG_PREPARE) {
>> +		log_error_regs(sec, doorbell);
>> +		return FW_UPLOAD_ERR_TIMEOUT;
>> +	} else if (progress != RSU_PROG_READY) {
>> +		log_error_regs(sec, doorbell);
>> +		return FW_UPLOAD_ERR_HW_ERROR;
>> +	}
>> +
>> +	return FW_UPLOAD_ERR_NONE;
>> +}
>> +
>> +static enum fw_upload_err rsu_send_data(struct m10bmc_sec *sec)
>> +{
>> +	u32 doorbell;
>> +	int ret;
>> +
>> +	ret = regmap_update_bits(sec->m10bmc->regmap,
>> +				 M10BMC_SYS_BASE + M10BMC_DOORBELL,
>> +				 DRBL_HOST_STATUS,
>> +				 FIELD_PREP(DRBL_HOST_STATUS,
>> +					    HOST_STATUS_WRITE_DONE));
>> +	if (ret)
>> +		return FW_UPLOAD_ERR_RW_ERROR;
>> +
>> +	ret = regmap_read_poll_timeout(sec->m10bmc->regmap,
>> +				       M10BMC_SYS_BASE + M10BMC_DOORBELL,
>> +				       doorbell,
>> +				       rsu_prog(doorbell) != RSU_PROG_READY,
>> +				       NIOS_HANDSHAKE_INTERVAL_US,
>> +				       NIOS_HANDSHAKE_TIMEOUT_US);
>> +
>> +	if (ret == -ETIMEDOUT) {
>> +		log_error_regs(sec, doorbell);
>> +		return FW_UPLOAD_ERR_TIMEOUT;
>> +	} else if (ret) {
>> +		return FW_UPLOAD_ERR_RW_ERROR;
>> +	}
>> +
>> +	switch (rsu_stat(doorbell)) {
>> +	case RSU_STAT_NORMAL:
>> +	case RSU_STAT_NIOS_OK:
>> +	case RSU_STAT_USER_OK:
>> +	case RSU_STAT_FACTORY_OK:
>> +		break;
>> +	default:
>> +		log_error_regs(sec, doorbell);
>> +		return FW_UPLOAD_ERR_HW_ERROR;
>> +	}
>> +
>> +	return FW_UPLOAD_ERR_NONE;
>> +}
>> +
>> +static int rsu_check_complete(struct m10bmc_sec *sec, u32 *doorbell)
>> +{
>> +	if (m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, doorbell))
>> +		return -EIO;
>> +
>> +	switch (rsu_stat(*doorbell)) {
>> +	case RSU_STAT_NORMAL:
>> +	case RSU_STAT_NIOS_OK:
>> +	case RSU_STAT_USER_OK:
>> +	case RSU_STAT_FACTORY_OK:
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
>> +	switch (rsu_prog(*doorbell)) {
>> +	case RSU_PROG_IDLE:
>> +	case RSU_PROG_RSU_DONE:
>> +		return 0;
>> +	case RSU_PROG_AUTHENTICATING:
>> +	case RSU_PROG_COPYING:
>> +	case RSU_PROG_UPDATE_CANCEL:
>> +	case RSU_PROG_PROGRAM_KEY_HASH:
>> +		return -EAGAIN;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +}
>> +
>> +static enum fw_upload_err rsu_cancel(struct m10bmc_sec *sec)
>> +{
>> +	u32 doorbell;
>> +	int ret;
>> +
>> +	ret = m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, &doorbell);
>> +	if (ret)
>> +		return FW_UPLOAD_ERR_RW_ERROR;
>> +
>> +	if (rsu_prog(doorbell) != RSU_PROG_READY)
>> +		return FW_UPLOAD_ERR_BUSY;
>> +
>> +	ret = regmap_update_bits(sec->m10bmc->regmap,
>> +				 M10BMC_SYS_BASE + M10BMC_DOORBELL,
>> +				 DRBL_HOST_STATUS,
>> +				 FIELD_PREP(DRBL_HOST_STATUS,
>> +					    HOST_STATUS_ABORT_RSU));
>> +	if (ret)
>> +		return FW_UPLOAD_ERR_RW_ERROR;
>> +
>> +	return FW_UPLOAD_ERR_CANCELED;
>> +}
>> +
>> +static enum fw_upload_err m10bmc_sec_prepare(struct fw_upload *fwl,
>> +					     const u8 *data, u32 size)
>> +{
>> +	struct m10bmc_sec *sec = fwl->dd_handle;
>> +	unsigned int stride;
>> +	u32 ret;
>> +
>> +	sec->cancel_request = false;
>> +
>> +	stride = regmap_get_reg_stride(sec->m10bmc->regmap);
>> +	if (!IS_ALIGNED((unsigned long)data, stride)) {
>> +		dev_err(sec->dev,
>> +			"%s address (0x%p) not aligned to stride (0x%x)\n",
>> +			__func__, data, stride);
>> +		return FW_UPLOAD_ERR_RW_ERROR;
>> +	}
> Why the base of the source data should be stride aligned? What prevents
> the driver from reading out the unaligned data?

This check also exists in regmap_bulk_write(), so regmap_bulk_write() would
fail for an unaligned base address with -EINVAL:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/base/regmap/regmap.c#n2274

By checking it here, I am able to print something useful to the kernel log.

>
> And this may be a too strict rule. I'm not sure who should ensure the
> alignment of the firmware data? The firmware upload framework? Or a user
> has no idea about the stride and cannot do the right thing.
The firmware upload framework uses an array of pages to allocate space
for the firmware image, so in its current implementation it will always
be aligned.

Would it be better to use regmap_write() for an unaligned start and
then follow up with regmap_bulk_write()?

>
>> +
>> +	if (!size || size > M10BMC_STAGING_SIZE)
>> +		return FW_UPLOAD_ERR_INVALID_SIZE;
>> +
>> +	ret = rsu_check_idle(sec);
>> +	if (ret != FW_UPLOAD_ERR_NONE)
>> +		return ret;
>> +
>> +	ret = rsu_update_init(sec);
>> +	if (ret != FW_UPLOAD_ERR_NONE)
>> +		return ret;
>> +
>> +	ret = rsu_prog_ready(sec);
>> +	if (ret != FW_UPLOAD_ERR_NONE)
>> +		return ret;
>> +
>> +	if (sec->cancel_request)
>> +		return rsu_cancel(sec);
>> +
>> +	return FW_UPLOAD_ERR_NONE;
>> +}
>> +
>> +#define WRITE_BLOCK_SIZE 0x4000	/* Default write-block size is 0x4000 bytes */
>> +
>> +static enum fw_upload_err m10bmc_sec_write(struct fw_upload *fwl, const u8 *data,
>> +					   u32 offset, u32 size, u32 *written)
>> +{
>> +	struct m10bmc_sec *sec = fwl->dd_handle;
>> +	u32 blk_size, doorbell;
>> +	unsigned int stride;
>> +	u8 *blk_addr;
>> +	int ret;
>> +
>> +	stride = regmap_get_reg_stride(sec->m10bmc->regmap);
>> +	if (sec->cancel_request)
>> +		return rsu_cancel(sec);
>> +
>> +	ret = m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, &doorbell);
>> +	if (ret) {
>> +		return FW_UPLOAD_ERR_RW_ERROR;
>> +	} else if (rsu_prog(doorbell) != RSU_PROG_READY) {
>> +		log_error_regs(sec, doorbell);
>> +		return FW_UPLOAD_ERR_HW_ERROR;
>> +	}
>> +
>> +	WARN_ON_ONCE(WRITE_BLOCK_SIZE % stride);
>> +	blk_size = min_t(u32, WRITE_BLOCK_SIZE, size);
>> +
>> +	/*
>> +	 * If the source data size does not align to stride, then create
>> +	 * a temporary buffer that is aligned, copy the data, and use the
>> +	 * temporary buffer as the source for the write.
>> +	 */
>> +	if (blk_size % stride) {
>> +		blk_addr = kzalloc(blk_size + blk_size % stride, GFP_KERNEL);
>> +		if (!blk_addr)
>> +			return FW_UPLOAD_ERR_RW_ERROR;
>> +		memcpy(blk_addr, data + offset, blk_size);
> You don't have to alloc and copy the whole block, just copy the last unaligned
> bytes to a local variable and regmap_write().
OK - I'll do that. And I'll look at doing something similar for a misaligned start.

Thanks,
- Russ
>
> Others are good to me.
>
> Thanks,
> Yilun
>
>> +	} else {
>> +		blk_addr = (u8 *)data + offset;
>> +	}
>> +
>> +	ret = regmap_bulk_write(sec->m10bmc->regmap,
>> +				M10BMC_STAGING_BASE + offset, blk_addr,
>> +				(blk_size + stride - 1) / stride);
>> +
>> +	if (blk_size % stride)
>> +		kfree(blk_addr);
>> +
>> +	if (ret)
>> +		return FW_UPLOAD_ERR_RW_ERROR;
>> +
>> +	*written = blk_size;
>> +	return FW_UPLOAD_ERR_NONE;
>> +}
>> +
>> +static enum fw_upload_err m10bmc_sec_poll_complete(struct fw_upload *fwl)
>> +{
>> +	struct m10bmc_sec *sec = fwl->dd_handle;
>> +	unsigned long poll_timeout;
>> +	u32 doorbell, result;
>> +	int ret;
>> +
>> +	if (sec->cancel_request)
>> +		return rsu_cancel(sec);
>> +
>> +	result = rsu_send_data(sec);
>> +	if (result != FW_UPLOAD_ERR_NONE)
>> +		return result;
>> +
>> +	poll_timeout = jiffies + msecs_to_jiffies(RSU_COMPLETE_TIMEOUT_MS);
>> +	do {
>> +		msleep(RSU_COMPLETE_INTERVAL_MS);
>> +		ret = rsu_check_complete(sec, &doorbell);
>> +	} while (ret == -EAGAIN && !time_after(jiffies, poll_timeout));
>> +
>> +	if (ret == -EAGAIN) {
>> +		log_error_regs(sec, doorbell);
>> +		return FW_UPLOAD_ERR_TIMEOUT;
>> +	} else if (ret == -EIO) {
>> +		return FW_UPLOAD_ERR_RW_ERROR;
>> +	} else if (ret) {
>> +		log_error_regs(sec, doorbell);
>> +		return FW_UPLOAD_ERR_HW_ERROR;
>> +	}
>> +
>> +	return FW_UPLOAD_ERR_NONE;
>> +}
>> +
>> +/*
>> + * m10bmc_sec_cancel() may be called asynchronously with an on-going update.
>> + * All other functions are called sequentially in a single thread. To avoid
>> + * contention on register accesses, m10bmc_sec_cancel() must only update
>> + * the cancel_request flag. Other functions will check this flag and handle
>> + * the cancel request synchronously.
>> + */
>> +static void m10bmc_sec_cancel(struct fw_upload *fwl)
>> +{
>> +	struct m10bmc_sec *sec = fwl->dd_handle;
>> +
>> +	sec->cancel_request = true;
>> +}
>> +
>> +static void m10bmc_sec_cleanup(struct fw_upload *fwl)
>> +{
>> +	struct m10bmc_sec *sec = fwl->dd_handle;
>> +
>> +	(void)rsu_cancel(sec);
>> +}
>> +
>> +static const struct fw_upload_ops m10bmc_ops = {
>> +	.prepare = m10bmc_sec_prepare,
>> +	.write = m10bmc_sec_write,
>> +	.poll_complete = m10bmc_sec_poll_complete,
>> +	.cancel = m10bmc_sec_cancel,
>> +	.cleanup = m10bmc_sec_cleanup,
>> +};
>> +
>>  #define SEC_UPDATE_LEN_MAX 32
>>  static int m10bmc_sec_probe(struct platform_device *pdev)
>>  {
>> +	char buf[SEC_UPDATE_LEN_MAX];
>>  	struct m10bmc_sec *sec;
>> +	struct fw_upload *fwl;
>> +	unsigned int len;
>> +	int  ret;
>>  
>>  	sec = devm_kzalloc(&pdev->dev, sizeof(*sec), GFP_KERNEL);
>>  	if (!sec)
>> @@ -205,6 +581,38 @@ static int m10bmc_sec_probe(struct platform_device *pdev)
>>  	sec->m10bmc = dev_get_drvdata(pdev->dev.parent);
>>  	dev_set_drvdata(&pdev->dev, sec);
>>  
>> +	ret = xa_alloc(&fw_upload_xa, &sec->fw_name_id, sec,
>> +		       xa_limit_32b, GFP_KERNEL);
>> +	if (ret)
>> +		return ret;
>> +
>> +	len = scnprintf(buf, SEC_UPDATE_LEN_MAX, "secure-update%d",
>> +			sec->fw_name_id);
>> +	sec->fw_name = kmemdup_nul(buf, len, GFP_KERNEL);
>> +	if (!sec->fw_name)
>> +		return -ENOMEM;
>> +
>> +	fwl = firmware_upload_register(THIS_MODULE, sec->dev, sec->fw_name,
>> +				       &m10bmc_ops, sec);
>> +	if (IS_ERR(fwl)) {
>> +		dev_err(sec->dev, "Firmware Upload driver failed to start\n");
>> +		kfree(sec->fw_name);
>> +		xa_erase(&fw_upload_xa, sec->fw_name_id);
>> +		return PTR_ERR(fwl);
>> +	}
>> +
>> +	sec->fwl = fwl;
>> +	return 0;
>> +}
>> +
>> +static int m10bmc_sec_remove(struct platform_device *pdev)
>> +{
>> +	struct m10bmc_sec *sec = dev_get_drvdata(&pdev->dev);
>> +
>> +	firmware_upload_unregister(sec->fwl);
>> +	kfree(sec->fw_name);
>> +	xa_erase(&fw_upload_xa, sec->fw_name_id);
>> +
>>  	return 0;
>>  }
>>  
>> @@ -218,6 +626,7 @@ MODULE_DEVICE_TABLE(platform, intel_m10bmc_sec_ids);
>>  
>>  static struct platform_driver intel_m10bmc_sec_driver = {
>>  	.probe = m10bmc_sec_probe,
>> +	.remove = m10bmc_sec_remove,
>>  	.driver = {
>>  		.name = "intel-m10bmc-sec-update",
>>  		.dev_groups = m10bmc_sec_attr_groups,
>> -- 
>> 2.25.1

