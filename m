Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEE8152A7E4
	for <lists+linux-fpga@lfdr.de>; Tue, 17 May 2022 18:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350869AbiEQQ0s (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 17 May 2022 12:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242407AbiEQQ0r (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 17 May 2022 12:26:47 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D32F527B14;
        Tue, 17 May 2022 09:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652804806; x=1684340806;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CqsOO/dfsnAfrEFVHCOdeykabBFlYEsR9S5YaFPAtvU=;
  b=dngVPld0Hp0I1uoI0sO37OuZSygaB+DGHaN2PoHNEIh65juFJjmuxWAu
   rNGiCcobzdBSGXbmKR4ltU8p28nA5p/5eUusLz7wXzjefpRxD8WnIMOjJ
   iUjY6XMPn4JShqG8SrcqXtBo5brcYUecqnxcf2+RhILXqURYnad/SsQkc
   EaeJThkbHQm/VAf/e9XFJ1pHvQ1aZyWaTb9/mv3cBEV9CSnPmcBMBwreo
   Wk5zu/iFNpDMp2hsJ4usplZA1TnOcdKzbD/bNNpSVGV7MArXGqoPKHppQ
   9lv9n3QZ2pw15kdXWexyz/fC5HyPNGdkYCQwBg7rkBcP0tYgBAABdAbmb
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="270062054"
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="270062054"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 09:26:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="544979466"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga006.jf.intel.com with ESMTP; 17 May 2022 09:26:46 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 17 May 2022 09:26:45 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 17 May 2022 09:26:45 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 17 May 2022 09:26:45 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 17 May 2022 09:26:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LeC3jTyE1ySafufMZ1iVeBTn1s+mnocOkqjyQDqq4lMoZAmZVDn0/Fif0Omt584GhTwMSD62UyqeX4puL5KYQVXwxncxTGPbkTEQ5qutiHUzmY2wcB6fqpA6ZysfC9hOLaMPJHddcka9rZ7J691mc5kQX56OlilHyGAlWR1Pi62kfcG2xtGHbvhwK8CXB5Src20ObLcA3Zj8QecgciUcC7BfUSphQQW96064h4b9xcDvmAMU1ilmMqiqXH1LifspklC13UZfBQNLYNJMshsZSa9RU3lIsdhtpRy4uAHy5KgXllqA9P1vN1zjNnCet5REdh0kMA7XjUh2HnzAY0IIoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9VAqGbzk6Mbi15yrod6kMpbMLfzBivsH2MJ208PW5to=;
 b=IIoJVjTd7DpYJcKFXjKrPBqEQ6exbF6fi+Lo7Vtyoy1SS0YmI+2J/4OoBtRUYP9w5S8EHdD+qW1I1y3NgpPAWnRf0cIqedlYB6t+beNCWJZgWQQosDFhyHlt1W+qg9jMgjJIrvjwgBZ3/A9dI+bbt6YidQKUGi66zmj5N0rjkxgoIJfo6CSX91z3Pj5Z7I0rp/pC4En+7IcsfVRkTbmA+XUJCbyfRGK9mvPA+MKwxcVLIDs7KZHz8SGcLNnvpWK6EBwRgvTHNRkE9kFdVQOFPeAA14V1ZNbrwgLngzYatgMTOequ8WW0yxYPoa9TnNDBdTmvEKVLDBlNOcAE4NK1Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM5PR11MB1899.namprd11.prod.outlook.com (2603:10b6:3:10b::14)
 by SJ0PR11MB5613.namprd11.prod.outlook.com (2603:10b6:a03:3ab::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Tue, 17 May
 2022 16:26:43 +0000
Received: from DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::b9cb:2e5f:f3ef:f397]) by DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::b9cb:2e5f:f3ef:f397%6]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 16:26:42 +0000
Message-ID: <5dd07f5d-ba92-ef56-8b4c-233b71f1148a@intel.com>
Date:   Tue, 17 May 2022 09:26:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.8.1
Subject: Re: [PATCH v20 4/5] fpga: m10bmc-sec: expose max10 canceled keys in
 sysfs
Content-Language: en-US
To:     Xu Yilun <yilun.xu@intel.com>
CC:     <mdf@kernel.org>, <hao.wu@intel.com>, <lee.jones@linaro.org>,
        <linux-fpga@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <trix@redhat.com>, <marpagan@redhat.com>, <lgoncalv@redhat.com>,
        <matthew.gerlach@linux.intel.com>,
        <basheer.ahmed.muddebihal@intel.com>, <tianfei.zhang@intel.com>
References: <20220516234941.592886-1-russell.h.weight@intel.com>
 <20220516234941.592886-5-russell.h.weight@intel.com>
 <20220517042440.GB40711@yilunxu-OptiPlex-7050>
From:   Russ Weight <russell.h.weight@intel.com>
In-Reply-To: <20220517042440.GB40711@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR05CA0017.namprd05.prod.outlook.com
 (2603:10b6:303:2b::22) To DM5PR11MB1899.namprd11.prod.outlook.com
 (2603:10b6:3:10b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d494c0f9-76a4-4a9b-75c7-08da382206d6
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5613:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <SJ0PR11MB561327A6AC7E03AA1288AD1EC5CE9@SJ0PR11MB5613.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PI4n6e21NzfZaVUXKyU3FsjnjG2aD2XuAQFpm07W8+uWlVP1sA/sS1aprXDLA4GI0QvB8HvCUCLpwXdMhD6JIJj1/NfSfP1v/fySkrSOai7bdZbgjSQsszRD92gxf2KZDHK/A8YQV/JMD41TgIzKIW8sXtrgob/8ZEZWmTt7qmq2hpPlqMcn0HKJ67Ea6d2GyrJ8YA2ZtHdmpNO0F4pglqtUTnApcaxgBQPA0EC5ejF7NoqOyTKmNTbF+TLEOJgBb6duOn1fmFP1HQcBvsuaVL453vTwNX1Mm9T/W2Wxtze+rzq+nHDF+/2KGykSeoKwszAMwciyrzlIJNCpniPTSn1YDnu9A9WuPzu8NNLLRF65PrzdPG9lRXmTkGQx7b1Un6mQl3kC0rmAx0nah3AAlYrHkPjTZ7T4r/tfg4uIWfExgXWys3DALSDpL/8Ip3CPA9nFjKBXQIXqR5LgJpb4bmg2y2VrhNs0PhEbUPOJRrBrRF09iNV0hUJgVDGJEsXcj8sD2snCldXRkjGWOMharR+kd8TRBPc2T/YZNgr3pvwPNrjJYCoZHutTEL0c6+q9BLYago5/c6bOVD27gQhlFi5BsYf/fhJcYaHo4KnzXnIMJsph1A5F0ErOiyCyDX6MenCkV6TSTrDQqgWY35bi2JPtidx6mn/FLGyZTtu+1qxD75oV8mGoMISSP+oCHlogB8w/90e2JMcDIxag9lsXz24ZUTKv3zrx70GCPaz6pPnSz8o0/G3MiRj4nt7w6ouG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1899.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6862004)(66556008)(8676002)(66476007)(4326008)(66946007)(86362001)(31696002)(26005)(53546011)(8936002)(508600001)(37006003)(6636002)(5660300002)(6486002)(38100700002)(82960400001)(186003)(2906002)(83380400001)(6666004)(6512007)(2616005)(316002)(36756003)(31686004)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHR6SmZmWmJzNWIrcnFXTmNVWkFGSlhqRnhBV2JyUmw3dGFwY0d2QnhVRm1i?=
 =?utf-8?B?NXphOFpUWTBSSjIrT1JUTllzYStDM1FpYUxkMFNHbCtxenNCN0RuQUhqQ0lP?=
 =?utf-8?B?TENPV3JKNWN5d3lxdGFnakJQRHNpdUtKblRhVjUrNTVFV0JDRXF0NzVzRldY?=
 =?utf-8?B?dFJlWjNnK0lWTFc2SDJsUUYxb1pERGRuMFZSbXZnWDl6cnY4R2RKeGovK1hs?=
 =?utf-8?B?a1h3SzdOSGpMNDdRTStGL3FOR09wUjBDcVl4RVJ4T1N2SVhianVNNlJtaWlk?=
 =?utf-8?B?S21hUjJoM09KNEdSOFBIOGpqK3BmVEk4bkFTcFhNejVRdUFxb24rMTJKcHNV?=
 =?utf-8?B?YXhWWUQ2UnAwd3dCUjhZMnJFVGlkMW9CS1Y4YUhOd0xOM1A4TldFeG1qTFNN?=
 =?utf-8?B?b3JGaXhzcGt6dGcxNzNLOW5EWjNycHo4MzFZUnBlSUJZOEpuQVZkZHR4YXhU?=
 =?utf-8?B?UEJzdG1HNElkYjRjZFNQT1NWZ3JZbDB0NlhhOFNid0RXdWkrRXJERUUxOFBo?=
 =?utf-8?B?d1VIVTR5ZVZpeHNmS1VMN3NMM1JsaTN3RHBCMHdiK0RoNjlnSFlZZWY0Q3Jk?=
 =?utf-8?B?RERLVmJHLzY3UHZ1Z01ObHV3Z2RsaUR2OWx6ZXdsOUpHK0V3TlRkOWUwdmZZ?=
 =?utf-8?B?NE8xMXJyUVVjZWN1cndiQ0FyQkNUZ2pjQWJhMHluMXVYb094WWNKVjMzU0ho?=
 =?utf-8?B?VnhRRE5pTnlTMTg5ZHRmd3FSN05lQ1FYbUYxaUVuVW5JMUtwVTJTRkJMQVoy?=
 =?utf-8?B?YkFlWUNjWWNjckxSWkdMaTZKR3I1YmxMY0hubEZOaEZSRFpEc0VvOE50dnJQ?=
 =?utf-8?B?RUpWdTdEVDNPQU9BWDQxZ2V5bS8rNlVhc05COWtwaDBiTi9JYWlDUUFHcCtQ?=
 =?utf-8?B?QWtVSkIrdjdROHg5bHQ2NXVVRjlRdEt6cUlvTDE1TjV5cVExc1hUbUZpaFBl?=
 =?utf-8?B?T3VlRG1tZjZOL3lXaWJNT2ZidmdzWTZjUDluOHZobndDTjRabFZQZUNCa0h0?=
 =?utf-8?B?SFdUQkM0bHpxU3Iwa081eDRnREJjTWV6TTU4SFQwbXlkVTJ6RmZpZU5JMWs5?=
 =?utf-8?B?UjlVQVNPRVh0aTdhVmJWLzdyMUxOSHlKU2ZZSS82RlFUVTJUM0QzdlV5THpB?=
 =?utf-8?B?YURlU0FnaDltZXhDRUZwMXlCZTIwRC9lR3hHVkVhbS9HSXc2bitVMkcyMnlz?=
 =?utf-8?B?Y3ovVnFWeGludkJ6ZnVMQTFZaHlWc0EzVVJpSU9Ia1hrUno0NHhOOW10Wk9T?=
 =?utf-8?B?UHEwUEN2TDZkdDg4WWQxQ1ZydXJuRUw1b21vM3czUUZURHQrbkNtWElKbGNq?=
 =?utf-8?B?K29JZHAxZ2ltMkVoanFFWlViaHhiZyt3TFV3SFI0SURpMERnb1kwQTlOc0oy?=
 =?utf-8?B?NENEdkF0Tmg5U1JhNXlaeUwyWEt2UmIyS2lqSmJ0bVEvTXh6dVBmb3N6aXNp?=
 =?utf-8?B?MVBGck5TSEV2cDRqSHFOSG1Qa1NZZFJhRDA1OHJGdjFucVBsdjZpZ0dvYkt6?=
 =?utf-8?B?aHlNM0dEWnByV3dNcFdVc0xjM0NQaDBTVmZuc3g2UTJMeFoyZWMvTXk5dzJq?=
 =?utf-8?B?RWtsOUFwWjkwTUtpQUZlMnZNbmhpMnQ2SXIzTGxxRVIxYmdKYmxWeTNhc3Nu?=
 =?utf-8?B?VTJBNlhScWp6S2dRbEo3WDdxRm5ZOUNBQ2x2aldWaDJObHlZYnB3MGtsS3pO?=
 =?utf-8?B?THY1UWR2bmN1UXo5dXBrMEdZZ1BMOGRBUm11Tk90TS9WakR4QTFCNmtFcW9k?=
 =?utf-8?B?MEJkZm1ORU14RU9GWUUzYy9qM0hQQk1PY0ZWeSt1UDA5cDcyNGsyVGlZVDcx?=
 =?utf-8?B?dnBpbmh0OHNqblQxNzJBdVVTZkZOY0pBTyt5Rm9iQ01EVXlpeEFiS1FOK2ZP?=
 =?utf-8?B?bEdUZDV4Rkt1NVlOTlZJOVdSOUd1K3NBY1lTMmVrVGEwZjhlTjFhdUl0ZEZ0?=
 =?utf-8?B?RmFDRVZmbHRZZWNpSFlka2IrdTZvalN2Q2h4QmtYRXVoWVZRd1ZFOVFEL2ox?=
 =?utf-8?B?RzcrU0tONERaRXZjYjFKWGF3OWhmWVdha1pITXIramlTRDlTNGU5bVE2OGhh?=
 =?utf-8?B?VmpBcWxNVk1VbWhoNW9iTmJYWFBweHlsVGp4WExERWVSb3lUdE9mbGU2ZS8w?=
 =?utf-8?B?MTdnVUMzU1JURlc0Z1RGLzBJd0lDWWpqVHhpQ0puQTFrNTN4cWMyb0lJN3ps?=
 =?utf-8?B?a2Z6bSswTlU1ZGlZczUvNmFkQkNsa1JXM25EeWtDa2piSWxjN3FPZjQvOEpm?=
 =?utf-8?B?WUVwRlpxZE5JZnpqYmJYRFFjaXcxTUhLSDViSFc4NWdzVTJMYWFiSFIrVEVu?=
 =?utf-8?B?ODhzbEtpUmk2Y2dqOU54ai85OFdZazJqOWJEcUM3eGp1T3FCcU9lZVFhR1V1?=
 =?utf-8?Q?K9k8O0wbrv+0Uk3E=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d494c0f9-76a4-4a9b-75c7-08da382206d6
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1899.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 16:26:42.2983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ku2s6vU3dHmhMqrNTOhh73++2CP5Z6OV2FkTaRNs1nkAKkCCWOFR8mRu2MNtJ4BokZeqwSML6QXYl2byhc2R55yR1G4GzBN8xYFVb/Ih65k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5613
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 5/16/22 21:24, Xu Yilun wrote:
> On Mon, May 16, 2022 at 04:49:40PM -0700, Russ Weight wrote:
>> Extend the MAX10 BMC Secure Update driver to provide sysfs files to
>> expose the 128 bit code signing key (CSK) cancellation vectors. These use
>> the standard bitmap list format (e.g. 1,2-6,9).
>>
>> Each CSK is assigned an ID, a number between 0-127, during the signing
>> process. CSK ID cancellation information is stored in 128-bit fields in
>> write-once locations in flash.  The cancellation of a CSK can be used
>> to prevent the card from being rolled back to older images that were
>> signed with a CSK that is now cancelled.
>>
>> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
>> Reviewed-by: Tom Rix <trix@redhat.com>
>> ---
>> v20:
>>   - Added text to the commit message to further describe the cancellation of
>>     code signing keys.
>> v19:
>>   - Change "card bmc" naming back to "m10 bmc" naming to be consistent
>>     with the parent driver.
>> v18:
>>   - No change
>> v17:
>>   - Update the Date and KernelVersion for the ABI documentation to Jul 2022
>>     and 5.19 respectively.
>>   - Change "m10bmc" in symbol names to "cardbmc" to reflect the fact that the
>>     future devices will not necessarily use the MAX10.
>> v16:
>>   - No Change
>> v15:
>>   - Updated the Dates and KernelVersions in the ABI documentation
>> v14:
>>   - No changes
>> v13:
>>   - Updated ABI documentation date and kernel version
>> v12:
>>   - Updated Date and KernelVersion fields in ABI documentation
>> v11:
>>   - No change
>> v10:
>>   - Changed the path expressions in the sysfs documentation to
>>     replace the n3000 reference with something more generic to
>>     accomodate other devices that use the same driver.
>> v9:
>>   - Rebased to 5.12-rc2 next
>>   - Updated Date and KernelVersion in ABI documentation
>> v8:
>>   - Previously patch 4/6, otherwise no change
>> v7:
>>   - Updated Date and KernelVersion in ABI documentation
>> v6:
>>   - Added WARN_ON() call for (size / stride) to ensure
>>     that the proper count is passed to regmap_bulk_read().
>> v5:
>>   - No change
>> v4:
>>   - Moved sysfs files for displaying the code-signing-key (CSK)
>>     cancellation vectors from the FPGA Security Manger class driver
>>     to here. The m10bmc_csk_vector() and m10bmc_csk_cancel_nbits()
>>     functions are removed and the functionality from these functions
>>     is moved into a show_canceled_csk() function for for displaying
>>     the CSK vectors.
>>   - Added ABI documentation for new sysfs entries
>> v3:
>>   - Changed: iops -> sops, imgr -> smgr, IFPGA_ -> FPGA_, ifpga_ to fpga_
>>   - Changed "MAX10 BMC Secure Engine driver" to "MAX10 BMC Secure Update
>>     driver"
>>   - Removed wrapper functions (m10bmc_raw_*, m10bmc_sys_*). The
>>     underlying functions are now called directly.
>>   - Renamed get_csk_vector() to m10bmc_csk_vector()
>> v2:
>>   - Replaced small function-creation macros for explicit function
>>     declarations.
>>   - Fixed get_csk_vector() function to properly apply the stride
>>     variable in calls to m10bmc_raw_bulk_read()
>>   - Added m10bmc_ prefix to functions in m10bmc_iops structure
>> ---
>>  .../sysfs-driver-intel-m10-bmc-sec-update     | 24 ++++++++++
>>  drivers/fpga/intel-m10-bmc-sec-update.c       | 48 +++++++++++++++++++
>>  2 files changed, 72 insertions(+)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update
>> index 1132e39b2125..ca5a34c1c31f 100644
>> --- a/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update
>> +++ b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update
>> @@ -28,6 +28,30 @@ Description:	Read only. Returns the root entry hash for the BMC image
>>  		underlying device supports it.
>>  		Format: string.
>>  
>> +What:		/sys/bus/platform/drivers/intel-m10bmc-sec-update/.../security/sr_canceled_csks
>> +Date:		Jul 2022
>> +KernelVersion:	5.19
>> +Contact:	Russ Weight <russell.h.weight@intel.com>
>> +Description:	Read only. Returns a list of indices for canceled code
>> +		signing keys for the static region. The standard bitmap
>> +		list format is used (e.g. "1,2-6,9").
>> +
>> +What:		/sys/bus/platform/drivers/intel-m10bmc-sec-update/.../security/pr_canceled_csks
>> +Date:		Jul 2022
>> +KernelVersion:	5.19
>> +Contact:	Russ Weight <russell.h.weight@intel.com>
>> +Description:	Read only. Returns a list of indices for canceled code
>> +		signing keys for the partial reconfiguration region. The
>> +		standard bitmap list format is used (e.g. "1,2-6,9").
>> +
>> +What:		/sys/bus/platform/drivers/intel-m10bmc-sec-update/.../security/bmc_canceled_csks
>> +Date:		Jul 2022
>> +KernelVersion:	5.19
>> +Contact:	Russ Weight <russell.h.weight@intel.com>
>> +Description:	Read only. Returns a list of indices for canceled code
>> +		signing keys for the BMC.  The standard bitmap list format
>> +		is used (e.g. "1,2-6,9").
>> +
>>  What:		/sys/bus/platform/drivers/intel-m10bmc-sec-update/.../security/flash_count
>>  Date:		Jul 2022
>>  KernelVersion:	5.19
>> diff --git a/drivers/fpga/intel-m10-bmc-sec-update.c b/drivers/fpga/intel-m10-bmc-sec-update.c
>> index 3f183202de3b..6c39adc6492d 100644
>> --- a/drivers/fpga/intel-m10-bmc-sec-update.c
>> +++ b/drivers/fpga/intel-m10-bmc-sec-update.c
>> @@ -78,6 +78,51 @@ DEVICE_ATTR_SEC_REH_RO(bmc, BMC_PROG_MAGIC, BMC_PROG_ADDR, BMC_REH_ADDR);
>>  DEVICE_ATTR_SEC_REH_RO(sr, SR_PROG_MAGIC, SR_PROG_ADDR, SR_REH_ADDR);
>>  DEVICE_ATTR_SEC_REH_RO(pr, PR_PROG_MAGIC, PR_PROG_ADDR, PR_REH_ADDR);
>>  
>> +#define CSK_BIT_LEN		128U
>> +#define CSK_32ARRAY_SIZE	DIV_ROUND_UP(CSK_BIT_LEN, 32)
>> +
>> +static ssize_t
>> +show_canceled_csk(struct device *dev, u32 addr, char *buf)
>> +{
>> +	unsigned int i, stride, size = CSK_32ARRAY_SIZE * sizeof(u32);
>> +	struct m10bmc_sec *sec = dev_get_drvdata(dev);
>> +	DECLARE_BITMAP(csk_map, CSK_BIT_LEN);
>> +	__le32 csk_le32[CSK_32ARRAY_SIZE];
>> +	u32 csk32[CSK_32ARRAY_SIZE];
>> +	int ret;
>> +
>> +	stride = regmap_get_reg_stride(sec->m10bmc->regmap);
>> +
>> +	WARN_ON(size % stride);
> Same concern.

OK - I'll handle it as an error case.

Thanks,
- Russ

>
>> +	ret = regmap_bulk_read(sec->m10bmc->regmap, addr, csk_le32,
>> +			       size / stride);
>> +	if (ret) {
>> +		dev_err(sec->dev, "failed to read CSK vector: %x cnt %x: %d\n",
>> +			addr, size / stride, ret);
>> +		return ret;
>> +	}
>> +
>> +	for (i = 0; i < CSK_32ARRAY_SIZE; i++)
>> +		csk32[i] = le32_to_cpu(((csk_le32[i])));
>> +
>> +	bitmap_from_arr32(csk_map, csk32, CSK_BIT_LEN);
>> +	bitmap_complement(csk_map, csk_map, CSK_BIT_LEN);
>> +	return bitmap_print_to_pagebuf(1, buf, csk_map, CSK_BIT_LEN);
>> +}
>> +
>> +#define DEVICE_ATTR_SEC_CSK_RO(_name, _addr) \
>> +static ssize_t _name##_canceled_csks_show(struct device *dev, \
>> +					  struct device_attribute *attr, \
>> +					  char *buf) \
>> +{ return show_canceled_csk(dev, _addr, buf); } \
>> +static DEVICE_ATTR_RO(_name##_canceled_csks)
>> +
>> +#define CSK_VEC_OFFSET 0x34
>> +
>> +DEVICE_ATTR_SEC_CSK_RO(bmc, BMC_PROG_ADDR + CSK_VEC_OFFSET);
>> +DEVICE_ATTR_SEC_CSK_RO(sr, SR_PROG_ADDR + CSK_VEC_OFFSET);
>> +DEVICE_ATTR_SEC_CSK_RO(pr, PR_PROG_ADDR + CSK_VEC_OFFSET);
>> +
>>  #define FLASH_COUNT_SIZE 4096	/* count stored as inverted bit vector */
>>  
>>  static ssize_t flash_count_show(struct device *dev,
>> @@ -118,6 +163,9 @@ static struct attribute *m10bmc_security_attrs[] = {
>>  	&dev_attr_bmc_root_entry_hash.attr,
>>  	&dev_attr_sr_root_entry_hash.attr,
>>  	&dev_attr_pr_root_entry_hash.attr,
>> +	&dev_attr_sr_canceled_csks.attr,
>> +	&dev_attr_pr_canceled_csks.attr,
>> +	&dev_attr_bmc_canceled_csks.attr,
>>  	NULL,
>>  };
>>  
>> -- 
>> 2.25.1

