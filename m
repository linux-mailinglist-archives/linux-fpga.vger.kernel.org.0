Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66DC16CF818
	for <lists+linux-fpga@lfdr.de>; Thu, 30 Mar 2023 02:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbjC3AML (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 29 Mar 2023 20:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjC3AMI (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 29 Mar 2023 20:12:08 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C7F61AA;
        Wed, 29 Mar 2023 17:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680135096; x=1711671096;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KyODALr/dYZViyqGYGyN1sTfF6CFwnGqfaSnYa+s8lY=;
  b=FDkl2ofMSALHuAs1l7NJWu3lpqMd9lVdjUkDEI64xCLLe8ke0dhEbVwh
   zBfxrMwF1+9Q5Ig/6W9nUnlrQOKOunu6nGM8v0MCoXSU5y0c7pvpVRPvz
   yA23S/R7WjafMTbDCxCXPg4cQ6dUuweJh/Bo5rdPUaaTQB00oAPSlsTS7
   orDC9Bj2cvNdXcrDgGfoEMPCqVRxH5FTFxscPX9prIOEfY5SZiK0ICp+P
   5Qev85gFMpwcFW0G4NlJ4bRg6RlA0KPY3zRuHVLUuBTCJz5WLhPo4GxOa
   WI52Cpo5rld8Tuu8GYazWIXeSZ9rgZ/zPtANTBUKXcaJNx6N4Gs3KaFxZ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="427306286"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="427306286"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 17:11:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="858698144"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="858698144"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga005.jf.intel.com with ESMTP; 29 Mar 2023 17:11:33 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 29 Mar 2023 17:11:33 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 29 Mar 2023 17:11:33 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.44) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Wed, 29 Mar 2023 17:11:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cOW5T5IPecg90jP3zNuSLOlRcXuPGTSiSGGzW0I8ZUA3e/LmYSwhuzUJTWkhnV/65SEemwY8JsNriJiHyVEw5CBnbOZWP6DaRpwzvkVyyGF9NyYTFKRw4VnTJM9vhvIx4VAF6Ad6U7hfxacxg3qd85fF94D96P4o+UqADlcXvO6g8rYG1Cc7Z54z/jMTs4IHfKi3fGhcCfc1lMrfMCSRTNGrdPFKnFuLOmAkE6baWvcaunDcM12dSNGVrlZY6O4rE+8gQStgmTknlhtbARqPjKHmIjY0wpdb31N8hVjwQqR1khPOZVT/wkjJzzCJjaUMyMrDzAuPCo8hPIWSnhfuqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KyODALr/dYZViyqGYGyN1sTfF6CFwnGqfaSnYa+s8lY=;
 b=AAeRO3Ib3smUMGyqG9ULvWiPql+PsmFnm1pWwQyS8wNS4NmqUqxeqxJ7tkz+rHb/KzQ0JBaRfQ8ktGLzoawFGfXUoInzJ1Fzxi+JKZ7999FjWBm5I9RMznWaLHa0+qI1Sc6hArgB7zORPL3gKQWR55XS4+A3z8vVtP1tZSDqUDcVG121+8xFsV9+diQHV6/2swSaxrbea5K8BWk0QjtQODdkPtT0mLzJCdMu9fBpAeP5NL1Mxlb0mHCKtc48KeY93NbqZeKE8zMgQpb7HbDVspz/n3IpPkp/t/MUgAEO4H7UapwtAYX9bS7y5YJs54LQuGW0tb7Hksk01GGeuQUiqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB6763.namprd11.prod.outlook.com (2603:10b6:303:20b::7)
 by DS0PR11MB7829.namprd11.prod.outlook.com (2603:10b6:8:f1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Thu, 30 Mar
 2023 00:11:29 +0000
Received: from MW4PR11MB6763.namprd11.prod.outlook.com
 ([fe80::c4e:6c7:e9f7:7222]) by MW4PR11MB6763.namprd11.prod.outlook.com
 ([fe80::c4e:6c7:e9f7:7222%7]) with mapi id 15.20.6222.035; Thu, 30 Mar 2023
 00:11:28 +0000
Message-ID: <4b6a7c07-ddee-38c3-fae5-b5df6a633d83@intel.com>
Date:   Wed, 29 Mar 2023 17:11:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.8.0
Subject: Re: [PATCH v1 0/6] PolarFire SoC Auto Update Support
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>
CC:     Conor Dooley <conor.dooley@microchip.com>,
        Xu Yilun <yilun.xu@intel.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, <linux-riscv@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-fpga@vger.kernel.org>
References: <20230217164023.14255-1-conor@kernel.org>
 <Y/ht1eHgtRrLxIhC@yilunxu-OptiPlex-7050> <Y/h1KFGSw13OabYw@wendy>
 <21bebf9d-eb27-5607-b0a9-274c46ef8aa3@intel.com> <Y/0r1aR6Wik2KYBd@spud>
 <cc6176cb-6792-ef11-f42a-d2d5b12d04b4@intel.com> <Y/01B4hCOs9JPfR8@spud>
 <bd80cf70-5545-4830-a4f4-7c4f79212f68@spud>
From:   Russ Weight <russell.h.weight@intel.com>
In-Reply-To: <bd80cf70-5545-4830-a4f4-7c4f79212f68@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR2101CA0009.namprd21.prod.outlook.com
 (2603:10b6:302:1::22) To MW4PR11MB6763.namprd11.prod.outlook.com
 (2603:10b6:303:20b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB6763:EE_|DS0PR11MB7829:EE_
X-MS-Office365-Filtering-Correlation-Id: ac283286-30ae-4e8e-53b3-08db30b34f02
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n27m9WmOqHn+WmLpsESnDmzVC0qPZ+lkkfr/rjo5bHQXKXQR1vb2RKo1dgbWkfx5tAl29AJvSowC6DnjeTDEj9Nw/U9WzKeSsfHIy2lNGR7IdpxFoiTlE2rAcyvG79fVQKdHFthh8vgHEqaa30O/4KzAeQ3v0ThTx+XWp3otKIvstNT1BTknxj2oNgBVCwozsApBKpMI1B/AHRJ/+h1nu2O8wrfHtRqbGLt8iHYnrhD/reyqDUM2dVPuq26cdOI4ZCL2JCpCg0XezqQT5cO20KAttFpYdHuKujPAvHspsFOYaLltfJuX6bH1NCsc+PQs3fj5NYfJpkXAdXa3mb3prMqXNIWmqFZWsflJ8ajOOyrlFc6lbMyKU04zDqDnqvybArS9JsDd27fMreTqohfdUqm053KRQShw4i7Rvh1wYN5mZJkdQf8WM2oN4WYllPaos26Kc9FkwC7jhm3f3SbDGZ1KoHNOa7yj2zg7ceXSJNQTxvQC7FIi+CWx5fpmmZYuiz1ELm0qPuJDmqb8zIcdu4FGYx+r2jcblWJdtk0OvqWHi9ehlm6zx7+gZ9+zhNNW8QVh5F7axXYfBdqfVK+nzcYVWeazWQNBBG+kehwXjebydovQVziO3ACTEvH2A41fZZXLwJVyuuszTZwtwbVhTrSLpSM1luK/xzVf46pLDRgYKxfdtrBigmtc/m6Rud4q
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB6763.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(346002)(136003)(396003)(366004)(451199021)(316002)(478600001)(54906003)(36756003)(31696002)(86362001)(5660300002)(8936002)(82960400001)(66556008)(4326008)(7416002)(15650500001)(38100700002)(66476007)(2906002)(8676002)(6916009)(66946007)(41300700001)(6506007)(186003)(53546011)(26005)(6512007)(83380400001)(31686004)(2616005)(6486002)(966005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eG9UdDJqK05aWVRrc1JkcmwxMGU1dHlhK3FFZDBiWnhkejFxQ0lZWnhZbmZX?=
 =?utf-8?B?Z2NLZkRMdE53NHNtZkNYdkV2V01jSnJ4VGlaZEhYZWRzdmZ6aWNxYkJuY3Rq?=
 =?utf-8?B?eXgzSGI0YUYwclp1RVZYd1ZSakppSE45T0lSRmdONEJzVkRNUHROZjFqcVdK?=
 =?utf-8?B?WGJsdTNmU3MrZ1BLMFFpTUV6VWFSUEdXVkVOLzM1elBMYXRGNUlDc1cyQzFW?=
 =?utf-8?B?SWxmbkc3WEF1Vmx1WDd3RE5YWXVyaXZ2aDRyVi8ycGZ0cHhTeGVET2tGV3lw?=
 =?utf-8?B?UTNjTy84T09YUzIwaUZwNFBsbmRiOGY2bVpEdjI3Mnh1Z3VQbi9BL3ZFOTA5?=
 =?utf-8?B?N0hSZStQSjJMZ3R0b2VCTHQ1Um9HaWIrdXFRNjJyQkF6c3BJYXRySXZwMkZP?=
 =?utf-8?B?R3g4aDNMeU9hT0V6eUVTQTFpd09wQlltYk5rTzBLWHhQTHZieFBUZG1vUURI?=
 =?utf-8?B?UmdBZHNaYzRXRlZlT3lIWDFFQXpoSi9RVjl5T1BHMmMrcW1JeHNTY3loVnIr?=
 =?utf-8?B?Y1ZGNFRneHRlOCtpYlJ2WFZENXRKc2lta084WGV0QkpoQTVQS1lIbk51RXBI?=
 =?utf-8?B?V0crOEJJUUxjcERjdW56QzVMa05Ta2dOU2dKcm5TMFBWMkozbkhGZE9qWS9o?=
 =?utf-8?B?WmtxcFN4MFRnbjJ5cC9Cb004ZHAvSU1HQ3pBS21QYlZpaWFFM3JQaVFhS2xM?=
 =?utf-8?B?WnFrR1lZeStKM01PUkNoS1IxUnVES09vaGF6aG9EQVFmVzFFWld2cnhiQldn?=
 =?utf-8?B?aWI0aVlGZ0p2ZVh2WlByMDVQVzJCeUFXYXBHeHhNdm1zZ3lpSzgrRHhQcWdV?=
 =?utf-8?B?VURWcm5EK3Y0UVltUGZGWTRNck45TEd5TjlNM2lya1NMZ2RJdms3NTJCZmN6?=
 =?utf-8?B?M0pQK3VzcUhWZUlWMzhEdU02TE5oTG9WalBZSXpLS0dmZ2NKMTdNYWt3QmYr?=
 =?utf-8?B?aTJOKzFrZzNuVjFwSzVYY2hzQWFvMEoycHVLY0FhQllFaEVPQXpiNm5aaGJo?=
 =?utf-8?B?NE5EaC9pSm80cmRlOG5CY2pUNm9QbldmYTVaaGJxY0hIajl5dVFUaTU0Qytk?=
 =?utf-8?B?Z3ptSUtNYnVHRldYWXFLdi95Yk9uZzNDbitWdmQxMUc1Ymp6dmZKcVN0SXp3?=
 =?utf-8?B?ODJKeFFBMDlBVkRLR3UvVUlqUDZ0dkVqTExtNHdVNmdJTFBoOHhFcmNiVVlD?=
 =?utf-8?B?Tko5cGZqOUlueVA4ZUg4ZXJpWnFKK2pDSHM2bzlWa05TWlI0SzhOdy9nTjJ4?=
 =?utf-8?B?S1c4SGVrdVVrSEhYdlN1NHQ1MDQ1RXQvNkxEdWhEVG0xendKOTFlczBrYXBz?=
 =?utf-8?B?UWdaT0doZTA2Z3FVU0E5U0w3QlZJYXVTZFZRRnhaYVpjUkFJTzNDTnR2VkE0?=
 =?utf-8?B?WkJrWld4eWYxVUJ2dS9jemhFd2xsODIvYlZIOE5vVmVmVkJzeGsxS2ZDNHFx?=
 =?utf-8?B?TW5Dc1FjTUI1TDBiVE1BOHRmZ3NYVXczTXlrWldXdjQ2YURnamU5ME5idUJ4?=
 =?utf-8?B?Z1B6eVB5SmI3YjNTaU90UHExWmV2enB3L1FRYitjcExrMnN2aldTdXlIeDMy?=
 =?utf-8?B?enNFUmxvTVRwSE9FNEFmUG1JSmlHdjRLN2U5V0lPV2lESTN1VEgzOVR4ajZu?=
 =?utf-8?B?Zk9RZVk2dWRZREVBUXhwak4rZnJhNlBmVzdEL05nYXZyaDNGVHVLYkd5Wmt3?=
 =?utf-8?B?Y1Uvc0ZWVmJVTCtxdkswRGNhNS9USkNDYWd1RFpRUXQzb213V1BZYnRoemZK?=
 =?utf-8?B?ZHdFem5FU0c4TXExTkJoTFhsSUlHd3BvcnhDcEx5eWpqT3J2UWswNWg1Zjhv?=
 =?utf-8?B?WVNCMFhkUXNEZlBYZmxzbDhjeGgxdDY1SXF2NmQ3WUN4bWU0STJGb0xLN1Vn?=
 =?utf-8?B?ckJmOENOUmRsajQyY0pYZVl3c2xJQW9LZ3Y0NC9COHp6cEdKK3plU09DeEpS?=
 =?utf-8?B?RzlIcmtYaGF6U0RhekR0MyszVnJPc0ltK1hGTTZMTjhsNVFVdU9Oc0ZUeTR0?=
 =?utf-8?B?VkYvd3dvMjFnQW1oT3NnQXA2dFdnNDdtL000aUFKZlJ6OTB5WHIxam81ekVt?=
 =?utf-8?B?amE2MUhFcGZsYXQ5ZUZ2dlhFZDV2MWxRQlJTUkxwRDdIUDV4MHY5RHJZSE1m?=
 =?utf-8?B?em1FSk1ucnpRaHJtMHVzVk9CNXJ2M3hGMWtpMjQwNGpkc2hhKzB3cDRKN0JF?=
 =?utf-8?B?QkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ac283286-30ae-4e8e-53b3-08db30b34f02
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB6763.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 00:11:28.8049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /PcUvKwQI105VhM4yMN58lVPou23oeswu2tCuNyrlC4oh91qr3b2SJGCvBdymSl/t2Px3zUoAGdGbyT1gd360a0pDeKjwVeRbGYeLOEySaY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7829
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Conor,

Sorry for the slow reply - I was out of the office for a week...

On 3/22/23 11:51, Conor Dooley wrote:
> Hey Russ,
>
> On Mon, Feb 27, 2023 at 10:56:07PM +0000, Conor Dooley wrote:
>> On Mon, Feb 27, 2023 at 02:42:30PM -0800, Russ Weight wrote:
>>> On 2/27/23 14:16, Conor Dooley wrote:
>>>> On Mon, Feb 27, 2023 at 02:04:36PM -0800, Russ Weight wrote:
>>>>> On 2/24/23 00:28, Conor Dooley wrote:
>>>>>> On Fri, Feb 24, 2023 at 03:57:09PM +0800, Xu Yilun wrote:
>>>>>>> On 2023-02-17 at 16:40:17 +0000, Conor Dooley wrote:
>>>>>>>> This patchset adds support for the "Auto Update" feature on PolarFire
>>>>>>>> SoC that allows for writing an FPGA bistream to the SPI flash connected
>>>>>>>> to the system controller.
>>>>>>> I haven't fully checked the patches yet, just some quick comments:
>>>>>>>
>>>>>>> Since this feature is just to R/W the flash, and would not affect the
>>>>>>> runtime FPGA region, I don't think an FPGA manager is actually needed.
>>>>>>> Why not just use the MTD uAPI? There is a set of exsiting MTD uAPI &
>>>>>>> MTD tool if I remember correctly.
>>>>>> A lack of interest in opening up the system controller to userspace!
>>>>>> You're right in that the writing of the image can be done that way, and
>>>>>> while I was testing I used the userspace bits of mtd along the way - but
>>>>>> for validating that the image we are writing we rely on the system
>>>>>> controller.
>>>>>> I'm really not interested in exposing the system controller's
>>>>>> functionality, especially the bitstream manipulation parts, to userspace
>>>>>> due to the risk of input validation bugs, so at least that side of
>>>>>> things should remain in the kernel.
>>>>>> I suppose I could implement something custom in drivers/soc that does
>>>>>> the validation only, and push the rest out to userspace. Just seemed
>>>>>> fitting to do the whole lot in drivers/fpga.
>>>>> In case you haven't already looked at the new firmware-upload
>>>>> support in the firmware-loader, I'll give you some references
>>>>> here to see if it fit you needs. This would only support the
>>>>> write (not the read) but it would allow the controller to do
>>>>> validation on the write.
>>>>>
>>>>> The is the cover letter which shows a usage example:
>>>>> https://lore.kernel.org/lkml/20220421212204.36052-1-russell.h.weight@intel.com/
>>>>>
>>>>> And this is a pointer to the latest documentation for it:
>>>>> https://docs.kernel.org/driver-api/firmware/fw_upload.html
>>>>>
>>>>> The only current user is: drivers/fpga/intel-m10-bmc-sec-update.c
>>>> Sounds interesting, I shall go and take a look. Just quickly, when you
>>>> say it wouldn't support the read, what exactly do you mean?
>>>> The only read that I am really interested in doing is reading the first
>>>> 1K of flash as I need to RMW it, but I don't think that that's what you
>>>> mean.
>>>> Do you mean that I would not be able to dump the firmware using your
>>>> fw_upload interface? If so, that's an acceptable constraint IMO.
>>> Yes - I mean that you couldn't dump the firmware image from userspace
>>> using the fw_upload interface. The sysfs interface allows you to read
>>> and write a temporary buffer, but once you "echo 0 > loading", there
>>> is no sysfs interface associated with the firmware-loader that would
>>> allow you to read the image from flash. Your controller actually does
>>> the writes, so RMW in that context is fine.
>> Ahh cool. I don't really care about dumping the firmware via such a
>> mechanism, so that sounds good to me.
>> I'll check out your approach, the immediate thought is that it sounds
>> suitable to my use case, so thanks!
> Taken me a while to get around to it, but thanks for your suggestion.
> Looks like it is suitable for what I am trying to do, so in the middle
> of working on another version of this using fw_upload.
> The enum return codes from write are a little clumsy, but oh well, could
> be worse I suppose.
>
> Just one thing I noted (although I rarely pay much attention to/rely on
> the driver-api docs when recent drivers exist as usable examples) is
> that the docs for this stuff is a wee bit out of date due to some API
> changes.
> In the code example in this document:
> https://docs.kernel.org/driver-api/firmware/fw_upload.html
> firmware_upload_register() has fewer arguments than it does when you
> look at the signature of the function in the documentation right below
> it.

I saw your patch to fix this. Thanks!

- Russ
>
> Cheers,
> Conor.

