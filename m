Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 228E7628F1E
	for <lists+linux-fpga@lfdr.de>; Tue, 15 Nov 2022 02:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235826AbiKOBRV (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 14 Nov 2022 20:17:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235905AbiKOBRT (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 14 Nov 2022 20:17:19 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD4A13FAA;
        Mon, 14 Nov 2022 17:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668475037; x=1700011037;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=65GgoCbGG3c/U/PaN0rxI8R0YXimiUdeorb4cFSFjoQ=;
  b=MGqXATtZlxCrhD8WjYVypOadJ7siN4ANhxr/YCMBRHAaZhW8w3njGnq/
   C0MH7fvej8J6+oIbl/InCNbWVV1f5X6VREUaeFyv/wi0XGQ7q//f2bnKK
   q9VXBAFNfMM05xc6RRpEPVAYQYAqs8pFzxr+OQ8J8HzSoxSYR18UF61l6
   yK6++hmOHFCC9sMqPbPIgUYOTlZv+X7xI60LRHdJ9RLNTteAvkyLimyN9
   Guu2tLW75OReiu/QqzfjKk7Jbdq40YyzUaSSrB2WSncEKFbSawRuXXtdB
   6PlmLTapXjMm6LW03iA8mov5CDfBNO775K+rcVC9cGhevQJjjzS1+9vn9
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="374257583"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="374257583"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 17:17:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="707537118"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="707537118"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP; 14 Nov 2022 17:17:12 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 14 Nov 2022 17:17:11 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 14 Nov 2022 17:17:11 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 14 Nov 2022 17:17:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PzUitXEa6UMbVj78VNKVjS9xM0oQt4d9jXx1hygLHD0dMVzsVUNCss/nktBwdY15QDpkq9ZeuedHZn9wFFvR6DdUjuxyfF5visZHo8i+u5P60Efibi4GIhfD++L+ECZ4dLoTGmqOXKlSjL+4rcvMvCPaoCBNqUM1I4yBOO1F3LWIYq3WWvGksF+7HkAYjjqpDF6nyCPPCrXRgW0m2AQDYy5xap+tfvQBp/uXH9faJtFuKRzNEE+zyb3KF4bMs8Sg2RJS9Tzc9CcAEcYlLqG5mxcKpUtbL7YXWTBssvodI7v0MGbPWTfOI/wKic3d3x/D6lCecX+x+bgtb7WMmgDjmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QEhYDhNCLP75G4Q1634VahXaEpodr6lTzCPROeN7XNI=;
 b=RlZtgEPTEYTnRaN8wuqJ3w29FCT3KVOwzWluaFbhQV6JrsguCGq4NtBdEzT5+N0rBQGzuKdpJCnzLGTgMuR91gvktq7ZZK+MAmCMk8PyB49JKPUcSCdkAiHjRG3q85i5KePb5RFUpr/ENijHzUZylgy+9yc731uTVJ9MN/tl5DCsIOpx1r9nDtYjKhI9x3Vdyt5HaPfymMZLFc1Rf3FXPhm2ZMeiCt3G0yzL2OTfkfJtxFtmf9+laPhwzUZdcZGN4tiOKbgO8hq9gJjV8QDFxIlmcnxpqB+rQEOFG7veJn5VppX+E1XchylBdLqM6sfQaT63tDA+b9Jei55HqnAz4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM5PR11MB1899.namprd11.prod.outlook.com (2603:10b6:3:10b::14)
 by SA1PR11MB5826.namprd11.prod.outlook.com (2603:10b6:806:235::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Tue, 15 Nov
 2022 01:17:10 +0000
Received: from DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::cdc6:8225:35ef:247d]) by DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::cdc6:8225:35ef:247d%9]) with mapi id 15.20.5813.017; Tue, 15 Nov 2022
 01:17:09 +0000
Message-ID: <30c62175-e96f-3911-8176-cac3d4928eb5@intel.com>
Date:   Mon, 14 Nov 2022 17:17:06 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH 02/12] mfd: intel-m10-bmc: Create m10bmc_platform_info for
 type specific info
Content-Language: en-US
To:     Xu Yilun <yilun.xu@intel.com>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC:     <linux-fpga@vger.kernel.org>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>,
        Lee Jones <lee@kernel.org>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        "Tianfei zhang" <tianfei.zhang@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20221108144305.45424-1-ilpo.jarvinen@linux.intel.com>
 <20221108144305.45424-3-ilpo.jarvinen@linux.intel.com>
 <Y24gJ7fIsUPmhzY2@yilunxu-OptiPlex-7050>
 <752a1dc-fae6-4431-41cf-a6deaf157ad3@linux.intel.com>
 <Y3Gg29pGm4DwjOgI@yilunxu-OptiPlex-7050>
From:   Russ Weight <russell.h.weight@intel.com>
In-Reply-To: <Y3Gg29pGm4DwjOgI@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0192.namprd03.prod.outlook.com
 (2603:10b6:303:b8::17) To DM5PR11MB1899.namprd11.prod.outlook.com
 (2603:10b6:3:10b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR11MB1899:EE_|SA1PR11MB5826:EE_
X-MS-Office365-Filtering-Correlation-Id: 00a460b0-6bc1-41c8-f60d-08dac6a71e49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pYyK7KHhPn4EWMVB/difzpEQv2g2JRlzNksTLFiNWyMnc1QXzyjFUFWTzUWInD6pZCIi6MwXUs4AXZxHdNq7mDCA2VWK5aEWbNP48vOd0ikQW4i/uZcMIj+JVmWddQTbIo3Nzz+REY6gqJZXywzNHZE8EyiOWWXzAOzio+GVMuNemi75FzHWVXNkqLA0UwU3hRwKEeIgA5MiGs0nJiQEUxsGf65lajr5Ug6sd5xJWZy+nTtfHOzXj02xG/Ir7jkCxPq1seEZqHzYHiqog6ndW2dyp7hyItEhHkOsMDyL4E2NIqKMoPq68j9/VzI7IFr6d2PUvdpdlYs/PHuBsYeXNuHbMjsRwbxh0s2J6IZccYB5kM21zFKhZl2/S0ha3U+3uHL2V+/uI2qdJ33k15pDth7OY+e7Gyqgub+PadL6Til3Ta5HXkZkYnBY53BXyVon/uQd4Sy9U0KIBbeEHm1kjq+lnty8E3pTy7I0fbM2bBINorzQMJGA3ItWkdufkJpFQ27htatSjn6/1cn+ivVJVUZMTdSqo9cPD4bzAI47e4hEufBq1jTdCGUbuidKSRwrULneSWOFJBtnd7T58KVyVUH1QvYguS7+MZhpJu/HjgHx3WGdiodE/TEqA1kqr48W2BeWFfNvbNp9++XVb2OsVphkE74iLjorhtFOQfZfkhn+JfT5oKrvMpOeDTHJAQBjR2h0KBfJx+XOBC58TuooRJh9byFQcU2CGL/0iSMlDT8h/XTLaSO0n+NOhvYynxMZKl0gSz54WSWv8U9euXK1/cFproNSKvSKRz1MeK5PVYM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1899.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(136003)(346002)(396003)(39860400002)(451199015)(2906002)(8936002)(86362001)(316002)(41300700001)(31696002)(2616005)(6512007)(186003)(82960400001)(38100700002)(26005)(5660300002)(83380400001)(53546011)(66574015)(66556008)(54906003)(110136005)(4326008)(8676002)(66946007)(66476007)(6666004)(6506007)(478600001)(31686004)(6486002)(36756003)(4001150100001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWE4RElnT3BQblAwdXd1OGJTeGdiQnErNTVqWkxCVDdCYjh0ZDhxRTJOR1Fp?=
 =?utf-8?B?SmwralNxdlJ3dXpsQUIwdTRtTFg3NGora3RDYWtFcXFFRnJVdFhXYnlzZ0JQ?=
 =?utf-8?B?VzVxbzRFaWs2RWNqYUdibHVFa2dpaGo1Q2pOc0c2aldjUHpieWpMWklMYjgx?=
 =?utf-8?B?VDJ4eUExY0tnaEdMTkJNVFl1MHBRTURFOEhSc1Vtai9WZE1RUVJoM094OWEv?=
 =?utf-8?B?b0pVallQNmc2eStlMmx6MUVEaHd5NVVtdnlud3pZUFF2d1ovcEFxb2NWSFBS?=
 =?utf-8?B?N1BpczZSY2k0bmhzVGxSaXNXaXVxQUFvMGtlekFsam9nclUvUlE1ZmlCREE1?=
 =?utf-8?B?YUJIQ01Uc2lSV1NzbHF3Z3dENTk3WVAycXEwTERNaFM3ZFlJYnpUWnNQRlJ4?=
 =?utf-8?B?a2pWMHpoYytiOTlaNkRVL0xKbEdkVU9VU01QeXNpN1U2UGRCMDV4dlBJWVFH?=
 =?utf-8?B?RDVBeks4djMyQUpBQXowZytEN29xU1ZWMUhNVk9FMks3bnMxQTVWMUtZV1I5?=
 =?utf-8?B?RnpSRGlOTm9kaVd2S0JXcWw5Mk5uSGdub3VNdDZIUUwrcStXWHBPZHR2dlZV?=
 =?utf-8?B?K0VXK2VjQjh5dGZ4SVJKL0JyMFEyMHIzcWNCQkVReDJXWmZLbjRPSG00SE13?=
 =?utf-8?B?cVZlZkRWMG5jSWV6TlQ0RWxNQnpkY0VNY09pSjF5TUU2ZGkxV3NWNk41bnd4?=
 =?utf-8?B?OHFwVkUxSno3TU9YYlRFK2xpVHFqTEhhaDA0aEFHMzI1RnJaWXRHN1pSZkJw?=
 =?utf-8?B?VExhdlo3WEdOTmNYQ0NsbGFiZ2RvSzlrNzZHaDZJMVpyQ3RETktCdldaMVdj?=
 =?utf-8?B?MVlVRTdPbk9kdmhCdlpNZWg1THEzK0tDMDc2OUNBME9EMXc3dEphN3VuTFZ6?=
 =?utf-8?B?Nnp2WDlXM2cvUTB3eGtxUm4xSHpMUTd0Q0tVNDZ4aEt1VW5jTVNyYWF0clhZ?=
 =?utf-8?B?SnJobE9hMEMyWG5GMXU5V3NBc0V3Y0czNEtNWW5DUmVUOVZrS2ZxcGIrZnJD?=
 =?utf-8?B?NlQ4c3RCMEk1OVVrcGhOOUxIaEFnM0tLSHYxK2lOUmZQaDRqMzkzemlpdGcr?=
 =?utf-8?B?MVZ5QzJRYzFCRTFpZmVucWxEVDNhQWFEVDlyYlExMktLOVNLSnBlS2hKdnBN?=
 =?utf-8?B?dUlrYldubjg5Rk9RanRCSnVMQUE1alZ4NHNSVWFmWXBNb3FiYkRaVzYwZFV2?=
 =?utf-8?B?a0RQSzIxMFI0K0RrK2x5c0svWlFKV0V5bi9DbjU3dkYzaUdRNUdsOTEydW5a?=
 =?utf-8?B?Z3BjbVIyU2c3NU8wY05TMUcrVFlxUTlGWEZTbkFwbXBscFU4dVhhUHlaV0F1?=
 =?utf-8?B?OW1wcThlWW9zRVYxSTk0bEJIKzU4VFl3WmcySEJ5SW1tMUdGanhEMEVzWHdh?=
 =?utf-8?B?dFhuK0h6QXBLRFQxY0Ztai8xeVVEVGd5TUZUYWVEL1BjdGltdGZ0eHBQZi9i?=
 =?utf-8?B?R1BlV0hrTmdmRHk2Y2JiN3lqWFBTWktNRmNuK20rektLRkZtaDIvcnlNWHN3?=
 =?utf-8?B?a01uRXV5dXpzV0RQMHI2VE1odEhLTm9MeTYrd3VsM0xlbVFDdWp3SXJNT1hF?=
 =?utf-8?B?aldIOW4valVrN2FMV05KL3UwYWNaOXVZT2hEQ1AwMVhJc1lzcDFqMlQ4eGFz?=
 =?utf-8?B?aElxWTdISVdOUFVVMVJRMWpla2tUcm1LQThLQjJnVXdLbFNwTXJUUy94RTdV?=
 =?utf-8?B?aS94eFN5WTlyTHNuWFlEMldndHB5TUZIdTlucENUaXl4S0FZZEw1WTNmNTVL?=
 =?utf-8?B?aC9XT1lWRUZoT3Z0Q3IwdjRaT3lBclM0cWxZM1QyNm5naXVzSmJjOC9CY1FW?=
 =?utf-8?B?NmQyd0pCL1pGS0pseFBEZ1BENXVjaW8yeWlsL2h5bjh3bVNpVHhUbG5XS3VV?=
 =?utf-8?B?aHBpVHF2ZnltQnZWb202b2wwK01IOVdjWkJJZlNEalkzSUo2VzlaVm9vakcw?=
 =?utf-8?B?VTY5bFVIbkxEY0hvYjA4R2VSMi9rODRvcXRqbVNvMUlZajhCQmlPbE95Q1Q3?=
 =?utf-8?B?UW9KYTJmWnRQZFV3QUFmM1I1Q3JyQ3hWTlBQZlRrajcvZkxqYkw4OGdpeXBX?=
 =?utf-8?B?ekhEc1NsSjVMc296Mm45RGJ2enlWSFY2U2VyUWxuajFnbXpXbXdHVEE2aWF2?=
 =?utf-8?B?N2dnMjBMYUVoc212dlpsbjkvRi9jSzRZSlFhY3JFZnh5LzBQQUxTUVB4ajky?=
 =?utf-8?B?eGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 00a460b0-6bc1-41c8-f60d-08dac6a71e49
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1899.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2022 01:17:09.8379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fQghFRphubOm7hTwqKJDgkgTkGtLetzW4VYoRLHmckl4yi0W7KICcm15YKi98grSmSP8SsWbfe3jXIcFzKcJ0B2nkzIR4IF1tXdOfwWYdg0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5826
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 11/13/22 17:58, Xu Yilun wrote:
> On 2022-11-11 at 13:49:38 +0200, Ilpo Järvinen wrote:
>> On Fri, 11 Nov 2022, Xu Yilun wrote:
>>
>>> On 2022-11-08 at 16:42:55 +0200, Ilpo Järvinen wrote:
>>>> BMC type specific info is currently set by a switch/case block. The
>>>> size of this info is expected to grow as more dev types and features
>>>> are added which would have made the switch block bloaty.
>>>>
>>>> Store type specific info into struct and place them into .driver_data
>>>> instead because it makes things a bit cleaner.
>>>>
>>>> Reviewed-by: Russ Weight <russell.h.weight@intel.com>
>>>> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>>>> ---
>>>>  drivers/mfd/intel-m10-bmc.c       | 50 +++++++++++++++++--------------
>>>>  include/linux/mfd/intel-m10-bmc.h | 14 +++++++++
>>>>  2 files changed, 41 insertions(+), 23 deletions(-)
>>>>
>>>> diff --git a/drivers/mfd/intel-m10-bmc.c b/drivers/mfd/intel-m10-bmc.c
>>>> index ee167c5dcd29..762808906380 100644
>>>> --- a/drivers/mfd/intel-m10-bmc.c
>>>> +++ b/drivers/mfd/intel-m10-bmc.c
>>>> @@ -156,15 +156,17 @@ static int check_m10bmc_version(struct intel_m10bmc *ddata)
>>>>  static int intel_m10_bmc_spi_probe(struct spi_device *spi)
>>>>  {
>>>>  	const struct spi_device_id *id = spi_get_device_id(spi);
>>>> +	const struct intel_m10bmc_platform_info *info;
>>>>  	struct device *dev = &spi->dev;
>>>> -	struct mfd_cell *cells;
>>>>  	struct intel_m10bmc *ddata;
>>>> -	int ret, n_cell;
>>>> +	int ret;
>>>>  
>>>>  	ddata = devm_kzalloc(dev, sizeof(*ddata), GFP_KERNEL);
>>>>  	if (!ddata)
>>>>  		return -ENOMEM;
>>>>  
>>>> +	info = (struct intel_m10bmc_platform_info *)id->driver_data;
>>>> +	ddata->info = info;
>>> Where to use the ddata->info?
>> In patch 5/12 there are many these constructs:
>> const struct m10bmc_csr_map *csr_map = sec->m10bmc->info->csr_map;
>>
>> Now that I look though, this particular line is altered by the split patch 
>> 4/12 so it would be not strictly necessary to do it here. I'd prefer, 
>> however, still to add it here even if it's technically not used until 
>> after the split 5/12 patch because it very much logically belongs to this 
>> change.
> It's good to me.
>
>>>>  	ddata->dev = dev;
>>>>  
>>>>  	ddata->regmap =
>>>> @@ -183,24 +185,8 @@ static int intel_m10_bmc_spi_probe(struct spi_device *spi)
>>>>  		return ret;
>>>>  	}
>>>>  
>>>> -	switch (id->driver_data) {
>>>> -	case M10_N3000:
>>>> -		cells = m10bmc_pacn3000_subdevs;
>>>> -		n_cell = ARRAY_SIZE(m10bmc_pacn3000_subdevs);
>>>> -		break;
>>>> -	case M10_D5005:
>>>> -		cells = m10bmc_d5005_subdevs;
>>>> -		n_cell = ARRAY_SIZE(m10bmc_d5005_subdevs);
>>>> -		break;
>>>> -	case M10_N5010:
>>>> -		cells = m10bmc_n5010_subdevs;
>>>> -		n_cell = ARRAY_SIZE(m10bmc_n5010_subdevs);
>>>> -		break;
>>>> -	default:
>>>> -		return -ENODEV;
>>>> -	}
>>>> -
>>>> -	ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_AUTO, cells, n_cell,
>>>> +	ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_AUTO,
>>>> +				   info->cells, info->n_cells,
>>>>  				   NULL, 0, NULL);
>>>>  	if (ret)
>>>>  		dev_err(dev, "Failed to register sub-devices: %d\n", ret);
>>>> @@ -208,10 +194,28 @@ static int intel_m10_bmc_spi_probe(struct spi_device *spi)
>>>>  	return ret;
>>>>  }
>>>>  
>>>> +static const struct intel_m10bmc_platform_info m10bmc_m10_n3000 = {
>>>> +	.type = M10_N3000,
>>> Is the type enum still useful? Found no usage.
>> There's no use within context of this patch series. However, I think there 
>> might have been something depending on it in the changes that are not part 
>> of this series so I left it in place for now.
> I'm not sure how it would be used later. This patch is to eliminate the
> "switch (board type) case" block, but similar code is still to be added
> later?

Unfortunately, these will be needed later. Consider the following (future)
function that has to account for a field that was moved from one register
to another:

    static int
    m10bmc_sec_status(struct m10bmc_sec *sec, u32 *status)
    {
            u32 reg_offset, reg_value;
            int ret;

            reg_offset = (sec->type == N6000BMC_SEC) ?
                    auth_result_reg(sec->m10bmc) : doorbell_reg(sec->m10bmc);

            ret = m10bmc_sys_read(sec->m10bmc, reg_offset, &reg_value);
            if (ret)
                    return ret;

            *status = rsu_stat(reg_value);

            return 0;
    }

With this patch-set, most conditionals are removed, but there will still
be some cases where it is needed. If you prefer, we could wait and add
the type in when we are ready to use it.

- Russ

>
> Thanks,
> Yilun

