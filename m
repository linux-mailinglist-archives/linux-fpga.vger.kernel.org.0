Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0214CD965
	for <lists+linux-fpga@lfdr.de>; Fri,  4 Mar 2022 17:47:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234785AbiCDQqQ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 4 Mar 2022 11:46:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbiCDQqP (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 4 Mar 2022 11:46:15 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E603E1C46BC;
        Fri,  4 Mar 2022 08:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646412327; x=1677948327;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=NTx4eDULD6eGPC6I5HgU7f0H0/iK7MHpH/YDRdGpTho=;
  b=eNswEKFo2+3dFz/pv0yap+NZQLWRlx9f6tg7Ovqq+bFst3BTvIofsLQy
   K5YSGWt9/TG7ZHeyU0yOKsDy/JsNw+KIQ+B3noSlu2VeZWuBOWin/JFIl
   L8ySPZWETsY7lRjND48BzqbFW7ZMre92lYBn149tUNbQiK8QHF+57Alq0
   aC3g9cZemmfQaGY388Cg/YgNJPmcUlyziVX5j+MBUyhu621SUtNsMj4NM
   8FFAPX1Yq49tT1zNk+U6cz8Pvt3/CnsPHq8qzeX+XNhU/9qiEp2NlCnNG
   EwxL1lVyOW4UVaKPBe0Aux9DHUONQyEMQQ2ermtiJOQ7Zxj5VvnFJm2G7
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10276"; a="278703245"
X-IronPort-AV: E=Sophos;i="5.90,155,1643702400"; 
   d="scan'208";a="278703245"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2022 08:45:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,155,1643702400"; 
   d="scan'208";a="594829124"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga008.fm.intel.com with ESMTP; 04 Mar 2022 08:45:27 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 4 Mar 2022 08:45:27 -0800
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 4 Mar 2022 08:45:26 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Fri, 4 Mar 2022 08:45:26 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Fri, 4 Mar 2022 08:45:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GBC8pVNzWDunMaKFKId8zCydWH5+ePrFBv1Bqu5Vu3iFdmzBKWo2pKMAQm9yGtxIATtVC/yhVf6T+DET3fHIBzoZtnyZU8A3sczAQ/ZgTI1XSYUt3ZIFKHCszAOvgdSOEO6AR6T9RThhmKM//BTe2WufT7WlRjuR+4AjJ0RNMxSkWoxj6K+sWFriGiZjQCKFs6/aBn+j8O6SbzCdifvKXjsvpyuFBZu7mShr/2dB/rsEvLTEtcOSEv7wb5tdc4zRIRWGJ63+dzdyU4RCYUTtrKula9xjrzBeD6bUPhXNt51H1826Ntx8avFuE5jdluoHXO4KXcWfLSNMMyuhpqLrwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NTx4eDULD6eGPC6I5HgU7f0H0/iK7MHpH/YDRdGpTho=;
 b=i+AtLCIFEewpFkSE7uz48woBtM+hHJ+iAP/6obmr5AoA6ZoxvdJ+1wfXQPAv4YalQeBY0WLST2Jk4bYr+0TFhfRUn5YyvmCwRYQAILW69xshBdL88ebTvhAKrrgSLNox+wrqESNMOp+Xd/TWokcohF3MB/vqJ4JQUprtpHhMlnt8DOVhDlHbU1/eIjJd3RpC8RA06abR6hnTIXXT6+vQp/Kp0C/vE/658hVcI8Op7cE7laQMOOqUgR78e7nLyAoDHAZbu31AcjnKcCUqN6x0wdiP7R8jr83iJBAbGiTR3rrMkFn0VpH+IkGy6aVbXa1tvIO3lOEDR0tJuuzDj2E6Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM5PR11MB1899.namprd11.prod.outlook.com (2603:10b6:3:10b::14)
 by MN2PR11MB4598.namprd11.prod.outlook.com (2603:10b6:208:26f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Fri, 4 Mar
 2022 16:45:24 +0000
Received: from DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::c94c:fd5d:2e7f:251d]) by DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::c94c:fd5d:2e7f:251d%12]) with mapi id 15.20.5038.017; Fri, 4 Mar 2022
 16:45:24 +0000
Message-ID: <bc41bc12-0d88-771f-7e78-4e29361fcfd8@intel.com>
Date:   Fri, 4 Mar 2022 08:45:20 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [PATCH v2 1/2] Documentation: fpga: dfl: add PCI Identification
 documentation
Content-Language: en-US
To:     Tom Rix <trix@redhat.com>, <matthew.gerlach@linux.intel.com>,
        <hao.wu@intel.com>, <yilun.xu@intel.com>,
        <basheer.ahmed.muddebihal@intel.com>, <mdf@kernel.org>,
        <corbet@lwn.net>, <linux-fpga@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dan.j.williams@intel.com>, <ashok.raj@intel.com>,
        <tianfei.zhang@intel.com>
References: <20220303003534.3307971-1-matthew.gerlach@linux.intel.com>
 <20220303003534.3307971-2-matthew.gerlach@linux.intel.com>
 <6448f21f-7ce1-d9ce-1048-29aca14f9d3d@redhat.com>
From:   Russ Weight <russell.h.weight@intel.com>
In-Reply-To: <6448f21f-7ce1-d9ce-1048-29aca14f9d3d@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0209.namprd03.prod.outlook.com
 (2603:10b6:303:b8::34) To DM5PR11MB1899.namprd11.prod.outlook.com
 (2603:10b6:3:10b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ba71b13f-7f4c-440c-b286-08d9fdfe60dd
X-MS-TrafficTypeDiagnostic: MN2PR11MB4598:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
X-Microsoft-Antispam-PRVS: <MN2PR11MB45982F0F4F88C7C1103BD593C5059@MN2PR11MB4598.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C9NRXay69vTlVbFijHEVufHgnsjA3PGxEIzxki4JUeUvpsxFLj4okc2Kq/IfYWkHzOJeApElMQtUxAfxC3rnuf9nHzJz6EailSbQaU3XldRt/2j23mUFsanUtteV6FcG7k0Ysjpedhmi1bFob5ZSC5l0Gd+xHtFHkA9o9k1lDkLtCVVWcZb4zgpACXWolaWSewNXWbCzy/5ozYV4v6wVZn+ZirYoB0QeFEdcfpDehy2m4R3+he37Aatm+9a3LSP2b3dzoCeqEYl7977/UIyoOfLHDXHBBVsK4cijDXxLotrMbkuVqQcNMAzml1QqASCfjg8hml4LzRTx4e7FkBePJDWgFhctJgQXKy66kjvRig06mcFaeB9iLgXtIkBWCgnmQtYx5SDYP5kVwXF8RsPbOyRiwg4Y1RYMPiTilgYnvjkx6r3l1Z3N3RNg4tsRJOvdiUNQELLdcXMUCmiGOpttnsQ+/R5eHEH8UoI22UwmkuhmEt8WcioeKXuL26+5xEp4fBtd/Sw3SpImCrFAa2S5o29Xb0kFT2hAhxjetknlmQNYCP+t7hxtUehtVEnqozihEZQZcR4AJukmRmUvKL3dP7uxwuUObMpU3Y9Zk50xv0ABYFi7kNxSxHwKCY2AG1hwfgDoA5e+4Jae0KCDajvlvyKhF3dvIRzFB4jP7lkr4hV2bNlbDWM9SZgSzKu7vTqH3wupyxe+4IcYGYUSGTAeD8NdoaQZWiE//kTLxx2MU/TNX6tn9IybWpT+ZO+W6k08
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1899.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(31686004)(2616005)(186003)(26005)(6636002)(316002)(921005)(8676002)(66946007)(66556008)(66476007)(36756003)(86362001)(508600001)(6486002)(2906002)(83380400001)(5660300002)(82960400001)(8936002)(38100700002)(53546011)(6666004)(6512007)(6506007)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXNIWVVsaGt4MlEwTVRWRnNMeXlzWnlwTm51TG91aTNvQU4xZXpoR0laVE1q?=
 =?utf-8?B?Y1h3dlBxL2UwYkFNYXJzNDZiTmpUWDNZMDNwb3VPOFRDbHoxWlpSY2J6L3NB?=
 =?utf-8?B?d3NkSGlsTHk4WWRHZWJYU2tzN3Z5a2NhbnQ4RWhkWnZyY2dtM2lVTHdXZnBR?=
 =?utf-8?B?cEs1YkkyY1lXQ2lrblJwNTI0bUt4VWRQei9MdFpOaEhDWHplbVpqTmt0Z0Rx?=
 =?utf-8?B?ekhsL3RjL294MGxZTXpTdjgxUEE1TE1uWXBjMDB6MDltNzE1QTMrT1lUOGk1?=
 =?utf-8?B?Ync1SkdLRXJjaDk0bFJoNUxTNEt0UFFNeFNDR0JmdWtuSjM5S1VySWdjR3k0?=
 =?utf-8?B?UDQySGNnME1PNTh0cUV5WkxIUUxVYnlzdHdHRThYUjJHeU80ZjFqbDRwUUMw?=
 =?utf-8?B?ZWlTZERWZW5TcGRiNXdLSDlSeTFGNUI1YWlzaGJCK2JwWWJDcTRINnAzc09N?=
 =?utf-8?B?bVJQMEV6eURvQVNRVC9zWjIrYTNmMGt0Rmo1ZTQva2RLUHYvLzcvNnNtOTlp?=
 =?utf-8?B?dDVMclFmbkxKK01PMk9MTEQvS2hFcTFIUlZOQ3lnL3Y3WkpZT3lrbHd6Z1pY?=
 =?utf-8?B?bTBDQlVTTHBOYlBUTnp5ckJ5NFAxWGYyenNkU0NBdUpnVERBZkRYKzBxZEdE?=
 =?utf-8?B?K2k1alZRekZMWVF5Zk9kREpZZkdxdWMySHNHa3h1bDZqK0YxVDJsdGZBRGYr?=
 =?utf-8?B?ZDhzcXpSTlIrL09ZWUZtSFRPOW1TNkxtVVFtMW5TN0lJUEwwMDNhcEh1WXZT?=
 =?utf-8?B?bHZXY00vQmM1Sit3K3ZBMUhtQzBoSDIzWHcyUWdVRUpTaUliK2RiUUgwSHJO?=
 =?utf-8?B?ZzJQdlJFaHRYTFNYMDYrR2hQdFlpd280SjJZdUJDc3d5T2xZOTJxNFlwRDB4?=
 =?utf-8?B?em80MUJhTmZCcGxtcjJINHZ4aC9wWVZwOFJnS1VRWkMvbm9DMGZ6ZjV0c3Uw?=
 =?utf-8?B?WXZWZWJ2OWxXK0M2OWV5dFB0ZWJkdW9zb25zS3ZYNmE3TkpLYXhCNk1Cc0Fq?=
 =?utf-8?B?OWlqL0pTdzNOV1NwanU5dFp3ZWVtcEs5Y0dJY21RRjFEYmVEbUE1cE9TMG5U?=
 =?utf-8?B?TWRFUVRDMWJHSkllUE80Q1I4S3cvTFppNHZwS0pEMElTS0dmczlLSGFhWVZI?=
 =?utf-8?B?VVpsNXRDZzVETXQyd2Z3TmlCdVJQY0F0WmNOYWV0U08zcURUMklPYldLSnpG?=
 =?utf-8?B?bjdhOWFkRk5Hbk9GdWRBeFVNbSthODQvbFhKUzVtVGt6QmhjTFlNRGNDUHNY?=
 =?utf-8?B?Z053NXhDaXFhUkdCWGVsMWFBaGFBVkdvUDl2WGdHZVEwMmRyVi9WK2MwUWc2?=
 =?utf-8?B?TTdpTVlLS05vcVBXN0h1c203ZHVZNlRCR3RmaUROUDFEL0xyYVBjZU1kaEQw?=
 =?utf-8?B?RUdsYkRIb1V2ZjJIS2pXengzUjB1NUNSSHBtZFVQVUtsVU5nQTFJSlZ2T0pq?=
 =?utf-8?B?VStSak1wNkxETWl5bXJTOVA5THQ3eFEvTGVlUy80OE1keVh5b1BQYVpRNGNL?=
 =?utf-8?B?S0NrK3M2OEtqRWJ3LzR1Vk5tNGVIS3BHTVJDUlBDbVB2WW5VdTl1ZzAwUXRj?=
 =?utf-8?B?eUl2enE3NFJlREJzbnhvbHNoRE0zM0d6MmpVUFhKZGFLcmsxQ3dBaGZLZU9O?=
 =?utf-8?B?U1JCeitvQnQxL2VXc1A2RHZFb0tXS0pPUTZwUzIwMWFpeWJXN28zUWlmcDBx?=
 =?utf-8?B?OFB3K3hZTXAwUkExSHlmYmtSMnZVUmVEa2pWLzVyNnlJdHJ5bDNBWk5HQXFz?=
 =?utf-8?B?aVlCWDJBWStTQkhSRUtkSnNqYjd2K203OENJZForeFhOTmUvQWJqVXhiUDFs?=
 =?utf-8?B?RUx3TGlNUncxTUFIS3RFQWhlb3lXYTRoQzFmaTBwamhUSmxmMzZvd0ZyeW5I?=
 =?utf-8?B?WU5lM3BlUXBxc3JmRmp3eWlGendZdVBFSkFZNkhPNXhlRWpGUElocTRXelZy?=
 =?utf-8?B?ZWxpcnY2aDJKRnkzTTdFNVUyUmlFQ1RqaFRtTjJXMlZ2VGp6bEFubW5naS9P?=
 =?utf-8?B?OU5RRkp3RmxncktpL2EzWlV1MEl4TE92SC9SMllQalV1cnFWeU1OcUtzRytK?=
 =?utf-8?B?SmdDNWlOMHl1ckNmb1RyS0tlZnN5Ymh0dzE0dmUxQ1o5bnNSM1VlUmViWlcz?=
 =?utf-8?B?TXZPV0trQUtCWTc2dFpxUjVHcHdIUkJWbnJrb2laUVNKcFBraTgzc3ltYU9S?=
 =?utf-8?B?ZUd0aWY2MElmK3R1R3lXU1VSa09RQXZyK3B4dU9rRnAzelhxbjlVTEZJNGN2?=
 =?utf-8?B?YkR0L0lTY1FhY3V3R2c2SEh4dWRBPT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ba71b13f-7f4c-440c-b286-08d9fdfe60dd
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1899.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2022 16:45:24.0173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: al3hkr26iW17a8tg762AgLeFClC5oPPJMM/le0yx7yjyOGqDBaE1z6RaImkckLH/9WE5rMCZZ8OOBpqg8dIj0uhiFNKnnOKhwt/YK/uy+f0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4598
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 3/3/22 14:04, Tom Rix wrote:
>
> On 3/2/22 4:35 PM, matthew.gerlach@linux.intel.com wrote:
>> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>
>> Add documentation on identifying FPGA based PCI cards prompted
>> by discussion on the linux-fpga@vger.kernel.org mailing list.
>>
>> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>> ---
>> v2: Introduced in v2.
>> ---
>>   Documentation/fpga/dfl.rst | 20 ++++++++++++++++++++
>>   1 file changed, 20 insertions(+)
>>
>> diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
>> index ef9eec71f6f3..5fb2ca8e76d7 100644
>> --- a/Documentation/fpga/dfl.rst
>> +++ b/Documentation/fpga/dfl.rst
>> @@ -502,6 +502,26 @@ Developer only needs to provide a sub feature driver with matched feature id.
>>   FME Partial Reconfiguration Sub Feature driver (see drivers/fpga/dfl-fme-pr.c)
>>   could be a reference.
>>   +PCI Device Identification
>> +================================
>> +Since FPGA based PCI cards can be reconfigured to a perform a completely
>> +new function at runtime, properly identifying such cards and binding the
>> +correct driver can be challenging. In many use cases, deployed FPGA based
>> +PCI cards are essentially static and the PCI Product ID and Vendor ID pair
>> +is sufficient to identify the card.  The DFL framework helps with the
>> +dynamic case of deployed FPGA cards changing at run time by providing
>> +more detailed information about card discoverable at runtime.
>> +
>> +At one level, the DFL on a PCI card describes the function of the card.
>> +However, the same DFL could be instantiated on different physical cards.
>> +Conversely, different DFLs could be instantiated on the same physical card.
>> +Practical management of a cloud containing a heterogeneous set of such cards
>> +requires a PCI level of card identification. While the PCI Product ID and
>> +Vendor ID may be sufficient to bind the dfl-pci driver, it is expected
>> +that FPGA PCI cards would advertise suitable Subsystem ID and Subsystem
>> +Vendor ID values. PCI Vital Product Data (VPD) can also be used for
>> +more granular information about the board.
>
> This describes a bit more of the problem, it should describe it wrt ofs dev id. The introduction of the ofs dev should be explicitly called out as a generic pci id.
>
> Why couldn't one of the old pci id's be reused ?
>
> How will the subvendor/subid be enforced ?
>
> Is the current security manager patchset smart enough to save the board from being bricked when a user doesn't look beyond the pci id ?

Yes - the security manager is invoked based of DFL feature ID and revision, and the functionality is differentiated based on the same information.

>
> What happens if a board uses this device id but doesn't have a max10 to do the update ?
>
> Tom
>
>> +
>>   Location of DFLs on a PCI Device
>>   ================================
>>   The original method for finding a DFL on a PCI device assumed the start of the
>

