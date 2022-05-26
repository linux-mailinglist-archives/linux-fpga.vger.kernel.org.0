Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84395535514
	for <lists+linux-fpga@lfdr.de>; Thu, 26 May 2022 22:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345492AbiEZUs3 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 26 May 2022 16:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345122AbiEZUs2 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 26 May 2022 16:48:28 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04ED219282;
        Thu, 26 May 2022 13:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653598105; x=1685134105;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rIHsRkbdtsq8OLosS4cxVOxG1/hu/fAD1WxIvaeO4HM=;
  b=ae+rrKle5Z3W35LdUYGqKNn7NtNvO7maICiu+nLSM4jDRsDrGP4tZoaM
   oJsJU07PlsOZKxn+bPaUXPKbX2qJGLRoKa09k+sPPQHdmi4yLcZvRUjAI
   t9pdNAENSITo5obuKAHOenBGNMkENA61lTHSdXB7Uyw2s44ZXTS1sIU2j
   CebXduEvMQEyhKWHtp2IxY/7OBEOwoNQRC6Yy7t+ZX4vPQfLDe+/3LpX1
   geF2hrsqePH/VlvNi50G0KFtMEOrCgDSN5MgK9xZXQSPe3VtWQcNvrRyk
   bz3jPH+ud2Dc67r2ZKmQosBxmpZeXeb5Xm4mGsL5GdY6BgWvkxsj60KOs
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10359"; a="254161815"
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; 
   d="scan'208";a="254161815"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2022 13:48:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; 
   d="scan'208";a="574088332"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga007.jf.intel.com with ESMTP; 26 May 2022 13:48:25 -0700
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 26 May 2022 13:48:25 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 26 May 2022 13:48:25 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 26 May 2022 13:48:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=atAz1WQQ25neU4qAE6zuAh+zyZoADewK5XZ0DhVjJG8lWMHzItB9vJbh5p/2xKe71WjdKYmiUc1XVfSNIay3EGnPbWQtBmCwqiiRDftdSsDbWh8/I58JuwFPRo05uosPJ7YRTvmQexUAWkQcVsWvVMp8Jay/nXaW0T8y3BIjJE/w7ofOaA+yLrHidiIpdV3zD7/PTFh5XANVGhflC8hm6hIyTZ6Leap9uGKjza3ZT5RErfg8FQvo/u8Rq1OqiuAWAooRuHU+JadHQYTiN710JfU3O68WFFi+Ho49gG7TrWQ7996/Itnh8g0wNLYV984ZvEUqzKhPigYYYE9Gqdn74w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=89tb1AOa/GGHAXOi7wH2MTV7p1ndQ71YBmqvnQ0TSds=;
 b=khnx41PdwE67P0/gGJsiPf6+LrGYkB05zhnEGZ0PsHTCMdbfZcto61Y7CEUvIiBOkv/a+tXn4vl46+BVckHYAN2njQNyf95h9UaxTGkqRWKdw/f/Kh5JXEWaA7UMF2F+PCdiwAU0AstjtEx7/yxb291oCcMqqiI7FSq3ocmVf/hKIkK4WuXdb6rUIpmfxb0A2CxNVhrYXVnVjgCzlZBm9MagH48MNQs9qGjuZCYpjqxff7oi+7XQCwty3HkArJa5pY3nJtwbVv3tdnGAwzZBSDEk5TsGcZ5qKgOpz/ZD4rYSGdd4ghyAXsWUggxkq/CNeKlWMk7ejj3Oc8cNjrinQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM5PR11MB1899.namprd11.prod.outlook.com (2603:10b6:3:10b::14)
 by MN2PR11MB4237.namprd11.prod.outlook.com (2603:10b6:208:195::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.17; Thu, 26 May
 2022 20:48:17 +0000
Received: from DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::b9cb:2e5f:f3ef:f397]) by DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::b9cb:2e5f:f3ef:f397%6]) with mapi id 15.20.5273.023; Thu, 26 May 2022
 20:48:16 +0000
Message-ID: <dec6a2e8-f527-0594-0504-90e116c7d5ba@intel.com>
Date:   Thu, 26 May 2022 13:48:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.8.1
Subject: Re: [PATCH v21 2/5] fpga: m10bmc-sec: create max10 bmc secure update
Content-Language: en-US
To:     Xu Yilun <yilun.xu@intel.com>
CC:     <mdf@kernel.org>, <hao.wu@intel.com>, <lee.jones@linaro.org>,
        <linux-fpga@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <trix@redhat.com>, <marpagan@redhat.com>, <lgoncalv@redhat.com>,
        <matthew.gerlach@linux.intel.com>,
        <basheer.ahmed.muddebihal@intel.com>, <tianfei.zhang@intel.com>
References: <20220521003607.737734-1-russell.h.weight@intel.com>
 <20220521003607.737734-3-russell.h.weight@intel.com>
 <20220526080447.GF148394@yilunxu-OptiPlex-7050>
From:   Russ Weight <russell.h.weight@intel.com>
In-Reply-To: <20220526080447.GF148394@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR17CA0070.namprd17.prod.outlook.com
 (2603:10b6:300:93::32) To DM5PR11MB1899.namprd11.prod.outlook.com
 (2603:10b6:3:10b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da1e4e74-188b-425f-3c20-08da3f590f36
X-MS-TrafficTypeDiagnostic: MN2PR11MB4237:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <MN2PR11MB423793F0C47743AB04541F5CC5D99@MN2PR11MB4237.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z2FFLOuAdXGtm3CefSYUot9MH8yz4AVA8jP0x6nZhPc7cTumxATuvbO+WBiQ0Er+k008Kj4tZUbvMxnTNsixdk1Ur8s7yBjqPHRWOwbpb+OSUU2yc/sjFSfsiYgIe4412kFHQfSe6waYFwnwswJ9HNtmMeTtvsxjIWDghD91Undr5VZfrCggn7PNwwaBkwkDZkN3h2c386iL7DeuLi87xyQFSaMXA0KKme5jq9GKu0Scj8gtjM4i7cRk9svJyFlzIf7KsWDvrOM0e20x6aDXZOON+x+0ZMoufx5vB3pMXp6TJriU0/QmM2B9zTh8MaVkESSUq2bKxoZ/dTU8LM6l90b6PCSi9IzZrqKOLaf0TpqX+cwWfsxsC9xIlv0eem9WGeB05aJH5e71hyjvDgpg9nUbDRATIrnL7JV/2kaoxvmbn4p//kxaXp+Xz3SDO18T+iOO3UuA8k/WyvvjpyV8fAUhyxvPYK00zOaTEDIGxX1tOoQKDc0qa5g6zsjlv9YnbU7dcO21NHbSMOLdSCfU3eiryZG/ipSRoycST/R+3o+ZkK8mxFS4AShxZWCcRAK9buh1fZ1y0wjuX4tWQFvR0T30zQNXNl3NwgKzYM7TrCHIPoj0nyy8j5NVrmQrni+ymgFDXzwdMqNSOFMgvVqYj6FIrj2B/X9eUiDIDB36QtkxkLpWrr+ocPSZ8wA213NZmBvPZbWvZLEYb6HSVjvjh1FeilFNnTlR9Altx8lgZE4mKpu+YAkBZpeACm1oXJDW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1899.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(15650500001)(186003)(26005)(66556008)(4326008)(83380400001)(66946007)(66476007)(508600001)(5660300002)(6486002)(6862004)(2616005)(6666004)(31696002)(8676002)(6512007)(38100700002)(2906002)(6506007)(53546011)(6636002)(37006003)(36756003)(31686004)(30864003)(82960400001)(316002)(86362001)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3RCWk9TWFJVakppQmJjbWQ3bSs1SzFnajUwUUhmcFZGT0tVRlg2dS9adlpH?=
 =?utf-8?B?R28vMk8yK3ZzbEx6UE1VTGNBaWVOWnN5NnhTT0k1MTVZdUcrL1d3MnlSL3Bl?=
 =?utf-8?B?UTN4bE4zQXltdm01VlA4aGl6VGtxT2JReklDQjVES3pyVmpiQTVaYm5zR0Fs?=
 =?utf-8?B?bHRTdDBSbGtMVzFXS3dyOHhlai9KSlNaSERlVTVDTFJnemJTZVh4cjV1TnRY?=
 =?utf-8?B?YzR3ajZqNUlocXkvRG1zQWxWRFdPWDkzRGlxQ0owS25UUHUrVE5TMkNlUlRV?=
 =?utf-8?B?YkVLU3Yvb0N6L0hvUy9xQklhdllUYVpXQzNjYnVHQVdXU0VKZlIvMVJvN1ph?=
 =?utf-8?B?M3dJTk90eFdadVNLUGhLK0MyVkNiUHJRV08vSHlVSkd1WnFabVhjcTM3RnNI?=
 =?utf-8?B?OVlEb3FSQ0poc3g3WjdkaEFKZDhRMnlvMW9sSHlzVmVqNjR1SjB2MzdlN2NR?=
 =?utf-8?B?czd4RzI1VTZqWHZERnQrWmgvSFM2dmUxMG1CbFFJOHBhS1VKWitISU5sNkZK?=
 =?utf-8?B?R3dYa0NLb2dhSTZ1aTVYeGxhdnlWTmJac3FGNjZUTDJtSVZMWFp5SXFTeEpP?=
 =?utf-8?B?RVl4ZnJOZWdUUlVHaUlmQnpJQXpZMU11SFNqK0dCT21LcW8veU5kWDRkaENr?=
 =?utf-8?B?ZXoyQ0tSRVNiZkp3bXAySWFST0dWNkV1b21tL0dScDZnRmxjQmdJN3J1VE1J?=
 =?utf-8?B?Z2VYSEN6NW1hQUNEdzBES05QdnF1OHJOT1NzRjl2QTVqcUJlS3R3dmozc25U?=
 =?utf-8?B?U2lCQTNEdkdMMGxzRmFReWVGdHlsYXNXZmpxalhzQWZ2aU5FRXIrWERUdTJF?=
 =?utf-8?B?aFJvVE5JeGNPV1V6cmNDRDBNcnc3UzdEMlhwdFNGWStYSmhxb2hCSGJuckVG?=
 =?utf-8?B?blBrek5pZ1FrZDhNWGVsYnhZRDRiYTBGdVYzYVQvM1c1aVpxbUpjTUovcHhJ?=
 =?utf-8?B?Z3RkeFBzTGtmbS9iNHRxS0RCNUh4Z0NUUXFvc3NjRVhrMjkyejZzejFseUNL?=
 =?utf-8?B?YVZMOUFCUk1wMHNCQWg0ZzlTUzhTTEhHM3YwN3lNWDNvZlZpSmRIdGo1cC90?=
 =?utf-8?B?STRheHdtNmVlSGNELzJ4QnkrWEkxSkhuTnZ4Vnc0dFV3M0JqK0xRNk9uN25P?=
 =?utf-8?B?aFVPendNRkpTUk8rZFJpWXpSYjkvUjVicmpwS2FVWjlLU3FpVjg0a0dsTGNr?=
 =?utf-8?B?US9wZlpSbkRERm5RcmRZM3VkUTlNaXV4UnB5QTRCZW1keHBwWnVIMGlkeFNa?=
 =?utf-8?B?YklrdmtsaDRtcStGbXYvRjQ0RDFnMWJBeC96MWRUSFJvdEsxcHpQalhFSVFj?=
 =?utf-8?B?RmxBbGlTcE1DVHhwVmdVaHVub0IybTFBanIrY09ZOUxiTURiUE5raHE1RjB6?=
 =?utf-8?B?clVKUWh3VTRzemRIK21rNVR1WHJzaGx0RExXQ2JHMkJPRzNDQm8wYllaTUZE?=
 =?utf-8?B?a1psV3oxWmttSFBiaEhCOGdRSjY1YnNpczQ1N0p5QVhuUXphUTlPZzlHaUhX?=
 =?utf-8?B?SnphWFZRV2pkTThrYjNvd2JFQ2RzWnIxUS9sMnpwdXp4a1ZMNDhDRlpwTXVL?=
 =?utf-8?B?RnVhR0xrK2paVWRMOWQ5M09GcFNRUzhFUndPTFZHb01Gdk5qbHhxVng0Z0RK?=
 =?utf-8?B?YWsrWTZEMkZLSkdSbTRMQWVTZnNNUFFoczZJbllFUmJNVlFKVXp5NkFEcWJL?=
 =?utf-8?B?L3Vjc2dpN25sbUxPSGxIUlZUSElrM0JDbmpFbklDZm0zRXpyZERONWsyYnJR?=
 =?utf-8?B?Vjc2Z3d0NTVXRkpEZUJ6L0c3ZDlVbGQ0QmRTemxGS2dMZEdQUlBjSFlubHA0?=
 =?utf-8?B?aHc5bXh0dEM0cUtSNCtJTksvZ09YYkNRaUFRdUxldkVtcDhvR2F3R2dtN3M2?=
 =?utf-8?B?aU5QTWs0WlpFVnhwdmMrWG9nRWJ3Z2JqWVZDczgydERhU2RZM3l2OEZWeHJC?=
 =?utf-8?B?a2lINXVnWlEyUjlQaXhxMUx3ZEFDVDE5UXBhL3BKYlM1Mk1XZUZPYWdXdEl0?=
 =?utf-8?B?YTlaS3UwY0txajQ0UFVDMFVhblI1T2RjclZXTjBWOVhraG85aXM2YU5md2Jj?=
 =?utf-8?B?NGh6dUNHL2VxT3FHWlp3RmhsZmtsdWs3TzhaYkxFWkZXMDR5UTFaSnN4TVB6?=
 =?utf-8?B?MVdlbjZPRDdObElWcStDTDlvN0k4NkRBQ1h6YU0wM21DbS9zbkRCMHE2eFFr?=
 =?utf-8?B?MEc4SUlrR1oxb2RER3YxalJEUjRmWmJjdEZCYmdaRlhJRG1kQmZiMVNHb0Vr?=
 =?utf-8?B?ZWVZUVplK3NEWG9jRTNvMkdIMVZhSkI0dVZtMU5kbzkzRjJ6b1NFZFF5ZFNo?=
 =?utf-8?B?STllb2ppT2Ivd1JIWE5mTTdWL1E2dE9Va25Eay9yNVoxWEc2VU5oTzRnOW44?=
 =?utf-8?Q?+fxJRTFTAE4kINek=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: da1e4e74-188b-425f-3c20-08da3f590f36
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1899.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2022 20:48:16.8229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ndps4IXVh038ytdCBAT3/RGRO15QWJssZXAOxdque8aMrdFZvR/KIPKP5c1ezgNRB7MPsqRdVWgSdgucCMVD8rKSijWrudl7Sl/3K++TFlM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4237
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 5/26/22 01:04, Xu Yilun wrote:
> On Fri, May 20, 2022 at 05:36:04PM -0700, Russ Weight wrote:
>> Create a sub-driver for the FPGA Card BMC in order to support secure
>> updates.  This patch creates the Max10 BMC Secure Update driver and
>> provides sysfs files for displaying the root entry hashes (REH) for the
>> FPGA static region (SR), the FPGA Partial Reconfiguration (PR) region,
>> and the card BMC.
>>
>> The Intel MAX10 BMC Root of Trust (RoT) requires that all BMC Nios firmware
>> and FPGA images are authenticated using ECDSA before loading and executing
>> on the card. Code Signing Keys (CSK) are used to sign images. CSKs are signed
>> by a root key. The root entry hash is created from the root public key.
>>
>> The RoT provides authentication by storing an REH bitstream to a write-once
>> location. Image signatures are verified against the hash.
>>
>> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
>> Reviewed-by: Tom Rix <trix@redhat.com>
>> ---
>> v21:
>>   - No change
>> v20:
>>   - Added text to the commit message to describe Root Entry Hashes.
>>   - Use reverse christmas tree format for local variable declarations in
>>     show_root_entry_hash().
>>   - Remove WARN_ON() from show_root_entry_hash() and return -EINVAL if 
>>     sha_num_bytes is not a multiple of stride.
>>   - Move MODULE_DEVICE_TABLE() macro to just beneath the definition of
>>     intel_m10bmc_sec_ids[].
>> v19:
>>   - Change "card bmc" naming back to "m10 bmc" naming to be consistent
>>     with the parent driver.
>> v18:
>>   - Changed the ABI documentation for the Root Entry Hashes to specify
>>     string as the format for the output.
>>   - Updated comments, strings and config options to more consistently
>>     refer to the driver as the Intel FPGA Card BMC Secure Update driver.
>>   - Removed an instance of dev_dbg().
>>   - Deferred the call to firmware_upload_register() to a later patch
>>     where the required ops are provided. The bmc_sec_remove() function is
>>     also removed from this patch and added in a later patch.
>>   - Switched from MODULE_ALIAS() to MODULE_DEVICE_TABLE() in anticipation
>>     of additional cards to be supported by the same driver.
>> v17:
>>   - Update the Date and KernelVersion for the ABI documentation to Jul 2022
>>     and 5.19 respectively.
>>   - Updated the copyright end-date to 2022 for the secure update driver.
>>   - Change m10bmc to cardbmc to reflect the fact that the future devices
>>     will not necessarily use the MAX10. This affects filenames, configs, and
>>     symbol names.
>>   - Removed references to the FPGA Image Load class driver and replaced
>>     them with the new firmware-upload service from the firmware loader.
>>   - Firmware upload requires a unique name for the firmware device. Use
>>     xarray_alloc to generate a unique number to append to the name.
>>   - Changed the license from GPL to GPLv2 per commit bf7fbeeae6db: 'module:
>>     Cure the MODULE_LICENSE "GPL" vs. "GPL v2" bogosity'
>> v16:
>>   - No Change
>> v15:
>>   - Updated the Dates and KernelVersions in the ABI documentation
>>   - Change driver name from "n3000bmc-secure" to "n3000bmc-sec-update".
>>   - Change CONFIG_FPGA_M10_BMC_SECURE to CONFIG_FPGA_M10_BMC_SEC_UPDATE.
>>   - Change instances of *bmc-secure to *bmc-sec-update in file name
>>     and symbol names.
>>   - Change instances of *m10bmc_secure* to *m10bmc-sec_update* in symbol
>>     names.
>>   - Change instances of *lops* to *ops* in symbol names.
>> v14:
>>   - Changed symbol and text references to reflect the renaming of the
>>     Security Manager Class driver to FPGA Image Load.
>> v13:
>>   - Updated copyright to 2021
>>   - Updated ABI documentation date and kernel version
>>   - Call updated fpga_sec_mgr_register() and fpga_sec_mgr_unregister()
>>     functions instead of devm_fpga_sec_mgr_create() and
>>     devm_fpga_sec_mgr_register().
>> v12:
>>   - Updated Date and KernelVersion fields in ABI documentation
>> v11:
>>   - Added Reviewed-by tag
>> v10:
>>   - Changed the path expressions in the sysfs documentation to
>>     replace the n3000 reference with something more generic to
>>     accomodate other devices that use the same driver.
>> v9:
>>   - Rebased to 5.12-rc2 next
>>   - Updated Date and KernelVersion in ABI documentation
>> v8:
>>   - Previously patch 2/6, otherwise no change
>> v7:
>>   - Updated Date and KernelVersion in ABI documentation
>> v6:
>>   - Added WARN_ON() call for (sha_num_bytes / stride) to assert
>>     that the proper count is passed to regmap_bulk_read().
>> v5:
>>   - No change
>> v4:
>>   - Moved sysfs files for displaying the root entry hashes (REH)
>>     from the FPGA Security Manager class driver to here. The
>>     m10bmc_reh() and m10bmc_reh_size() functions are removed and
>>     the functionality from these functions is moved into a
>>     show_root_entry_hash() function for displaying the REHs.
>>   - Added ABI documentation for the new sysfs entries:
>>     sysfs-driver-intel-m10-bmc-secure
>>   - Updated the MAINTAINERS file to add the new ABI documentation
>>     file: sysfs-driver-intel-m10-bmc-secure
>>   - Removed unnecessary ret variable from m10bmc_secure_probe()
>>   - Incorporated new devm_fpga_sec_mgr_register() function into
>>     m10bmc_secure_probe() and removed the m10bmc_secure_remove()
>>     function.
>> v3:
>>   - Changed from "Intel FPGA Security Manager" to FPGA Security Manager"
>>   - Changed: iops -> sops, imgr -> smgr, IFPGA_ -> FPGA_, ifpga_ to fpga_
>>   - Changed "MAX10 BMC Secure Engine driver" to "MAX10 BMC Secure
>>     Update driver"
>>   - Removed wrapper functions (m10bmc_raw_*, m10bmc_sys_*). The
>>     underlying functions are now called directly.
>>   - Changed "_root_entry_hash" to "_reh", with a comment explaining
>>     what reh is.
>> v2:
>>   - Added drivers/fpga/intel-m10-bmc-secure.c file to MAINTAINERS.
>>   - Switched to GENMASK(31, 16) for a couple of mask definitions.
>>   - Moved MAX10 BMC address and function definitions to a separate
>>     patch.
>>   - Replaced small function-creation macros with explicit function
>>     declarations.
>>   - Removed ifpga_sec_mgr_init() and ifpga_sec_mgr_uinit() functions.
>>   - Adapted to changes in the Intel FPGA Security Manager by splitting
>>     the single call to ifpga_sec_mgr_register() into two function
>>     calls: devm_ifpga_sec_mgr_create() and ifpga_sec_mgr_register().
>> ---
>>  .../sysfs-driver-intel-m10-bmc-sec-update     |  29 ++++
>>  MAINTAINERS                                   |   7 +
>>  drivers/fpga/Kconfig                          |  12 ++
>>  drivers/fpga/Makefile                         |   3 +
>>  drivers/fpga/intel-m10-bmc-sec-update.c       | 134 ++++++++++++++++++
>>  5 files changed, 185 insertions(+)
>>  create mode 100644 Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update
>>  create mode 100644 drivers/fpga/intel-m10-bmc-sec-update.c
>>
>> diff --git a/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update
>> new file mode 100644
>> index 000000000000..2bb271695e14
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update
>> @@ -0,0 +1,29 @@
>> +What:		/sys/bus/platform/drivers/intel-m10bmc-sec-update/.../security/sr_root_entry_hash
>> +Date:		Jul 2022
>> +KernelVersion:	5.19
> Oh, please also update the Date & KernelVersion when 5.19-rc1 comes.
OK - I'll update for Sep 2022 and 5.20

Thanks,
- Russ
>
> Thanks,
> Yilun
>
>> +Contact:	Russ Weight <russell.h.weight@intel.com>
>> +Description:	Read only. Returns the root entry hash for the static
>> +		region if one is programmed, else it returns the
>> +		string: "hash not programmed".  This file is only
>> +		visible if the underlying device supports it.
>> +		Format: string.
>> +
>> +What:		/sys/bus/platform/drivers/intel-m10bmc-sec-update/.../security/pr_root_entry_hash
>> +Date:		Jul 2022
>> +KernelVersion:	5.19
>> +Contact:	Russ Weight <russell.h.weight@intel.com>
>> +Description:	Read only. Returns the root entry hash for the partial
>> +		reconfiguration region if one is programmed, else it
>> +		returns the string: "hash not programmed".  This file
>> +		is only visible if the underlying device supports it.
>> +		Format: string.
>> +
>> +What:		/sys/bus/platform/drivers/intel-m10bmc-sec-update/.../security/bmc_root_entry_hash
>> +Date:		Jul 2022
>> +KernelVersion:	5.19
>> +Contact:	Russ Weight <russell.h.weight@intel.com>
>> +Description:	Read only. Returns the root entry hash for the BMC image
>> +		if one is programmed, else it returns the string:
>> +		"hash not programmed".  This file is only visible if the
>> +		underlying device supports it.
>> +		Format: string.
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index a4ae11be9e5d..2f2a736ef790 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -7797,6 +7797,13 @@ F:	Documentation/fpga/
>>  F:	drivers/fpga/
>>  F:	include/linux/fpga/
>>  
>> +INTEL MAX10 BMC SECURE UPDATES
>> +M:	Russ Weight <russell.h.weight@intel.com>
>> +L:	linux-fpga@vger.kernel.org
>> +S:	Maintained
>> +F:	Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update
>> +F:	drivers/fpga/intel-m10-bmc-sec-update.c
>> +
>>  FPU EMULATOR
>>  M:	Bill Metzenthen <billm@melbpc.org.au>
>>  S:	Maintained
>> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
>> index 991b3f361ec9..0831eecc9a09 100644
>> --- a/drivers/fpga/Kconfig
>> +++ b/drivers/fpga/Kconfig
>> @@ -243,4 +243,16 @@ config FPGA_MGR_VERSAL_FPGA
>>  	  configure the programmable logic(PL).
>>  
>>  	  To compile this as a module, choose M here.
>> +
>> +config FPGA_M10_BMC_SEC_UPDATE
>> +	tristate "Intel MAX10 BMC Secure Update driver"
>> +	depends on MFD_INTEL_M10_BMC && FW_UPLOAD
>> +	help
>> +	  Secure update support for the Intel MAX10 board management
>> +	  controller.
>> +
>> +	  This is a subdriver of the Intel MAX10 board management controller
>> +	  (BMC) and provides support for secure updates for the BMC image,
>> +	  the FPGA image, the Root Entry Hashes, etc.
>> +
>>  endif # FPGA
>> diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
>> index 5935b3d0abd5..139ac1b573d3 100644
>> --- a/drivers/fpga/Makefile
>> +++ b/drivers/fpga/Makefile
>> @@ -22,6 +22,9 @@ obj-$(CONFIG_FPGA_MGR_VERSAL_FPGA)	+= versal-fpga.o
>>  obj-$(CONFIG_ALTERA_PR_IP_CORE)		+= altera-pr-ip-core.o
>>  obj-$(CONFIG_ALTERA_PR_IP_CORE_PLAT)	+= altera-pr-ip-core-plat.o
>>  
>> +# FPGA Secure Update Drivers
>> +obj-$(CONFIG_FPGA_M10_BMC_SEC_UPDATE)	+= intel-m10-bmc-sec-update.o
>> +
>>  # FPGA Bridge Drivers
>>  obj-$(CONFIG_FPGA_BRIDGE)		+= fpga-bridge.o
>>  obj-$(CONFIG_SOCFPGA_FPGA_BRIDGE)	+= altera-hps2fpga.o altera-fpga2sdram.o
>> diff --git a/drivers/fpga/intel-m10-bmc-sec-update.c b/drivers/fpga/intel-m10-bmc-sec-update.c
>> new file mode 100644
>> index 000000000000..f9f39d2cfe5b
>> --- /dev/null
>> +++ b/drivers/fpga/intel-m10-bmc-sec-update.c
>> @@ -0,0 +1,134 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Intel MAX10 Board Management Controller Secure Update Driver
>> + *
>> + * Copyright (C) 2019-2022 Intel Corporation. All rights reserved.
>> + *
>> + */
>> +#include <linux/bitfield.h>
>> +#include <linux/device.h>
>> +#include <linux/firmware.h>
>> +#include <linux/mfd/intel-m10-bmc.h>
>> +#include <linux/mod_devicetable.h>
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/slab.h>
>> +
>> +struct m10bmc_sec {
>> +	struct device *dev;
>> +	struct intel_m10bmc *m10bmc;
>> +};
>> +
>> +/* Root Entry Hash (REH) support */
>> +#define REH_SHA256_SIZE		32
>> +#define REH_SHA384_SIZE		48
>> +#define REH_MAGIC		GENMASK(15, 0)
>> +#define REH_SHA_NUM_BYTES	GENMASK(31, 16)
>> +
>> +static ssize_t
>> +show_root_entry_hash(struct device *dev, u32 exp_magic,
>> +		     u32 prog_addr, u32 reh_addr, char *buf)
>> +{
>> +	struct m10bmc_sec *sec = dev_get_drvdata(dev);
>> +	int sha_num_bytes, i, ret, cnt = 0;
>> +	u8 hash[REH_SHA384_SIZE];
>> +	unsigned int stride;
>> +	u32 magic;
>> +
>> +	stride = regmap_get_reg_stride(sec->m10bmc->regmap);
>> +	ret = m10bmc_raw_read(sec->m10bmc, prog_addr, &magic);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (FIELD_GET(REH_MAGIC, magic) != exp_magic)
>> +		return sysfs_emit(buf, "hash not programmed\n");
>> +
>> +	sha_num_bytes = FIELD_GET(REH_SHA_NUM_BYTES, magic) / 8;
>> +	if ((sha_num_bytes % stride) ||
>> +	    (sha_num_bytes != REH_SHA256_SIZE &&
>> +	     sha_num_bytes != REH_SHA384_SIZE))   {
>> +		dev_err(sec->dev, "%s bad sha num bytes %d\n", __func__,
>> +			sha_num_bytes);
>> +		return -EINVAL;
>> +	}
>> +
>> +	ret = regmap_bulk_read(sec->m10bmc->regmap, reh_addr,
>> +			       hash, sha_num_bytes / stride);
>> +	if (ret) {
>> +		dev_err(dev, "failed to read root entry hash: %x cnt %x: %d\n",
>> +			reh_addr, sha_num_bytes / stride, ret);
>> +		return ret;
>> +	}
>> +
>> +	for (i = 0; i < sha_num_bytes; i++)
>> +		cnt += sprintf(buf + cnt, "%02x", hash[i]);
>> +	cnt += sprintf(buf + cnt, "\n");
>> +
>> +	return cnt;
>> +}
>> +
>> +#define DEVICE_ATTR_SEC_REH_RO(_name, _magic, _prog_addr, _reh_addr) \
>> +static ssize_t _name##_root_entry_hash_show(struct device *dev, \
>> +					    struct device_attribute *attr, \
>> +					    char *buf) \
>> +{ return show_root_entry_hash(dev, _magic, _prog_addr, _reh_addr, buf); } \
>> +static DEVICE_ATTR_RO(_name##_root_entry_hash)
>> +
>> +DEVICE_ATTR_SEC_REH_RO(bmc, BMC_PROG_MAGIC, BMC_PROG_ADDR, BMC_REH_ADDR);
>> +DEVICE_ATTR_SEC_REH_RO(sr, SR_PROG_MAGIC, SR_PROG_ADDR, SR_REH_ADDR);
>> +DEVICE_ATTR_SEC_REH_RO(pr, PR_PROG_MAGIC, PR_PROG_ADDR, PR_REH_ADDR);
>> +
>> +static struct attribute *m10bmc_security_attrs[] = {
>> +	&dev_attr_bmc_root_entry_hash.attr,
>> +	&dev_attr_sr_root_entry_hash.attr,
>> +	&dev_attr_pr_root_entry_hash.attr,
>> +	NULL,
>> +};
>> +
>> +static struct attribute_group m10bmc_security_attr_group = {
>> +	.name = "security",
>> +	.attrs = m10bmc_security_attrs,
>> +};
>> +
>> +static const struct attribute_group *m10bmc_sec_attr_groups[] = {
>> +	&m10bmc_security_attr_group,
>> +	NULL,
>> +};
>> +
>> +#define SEC_UPDATE_LEN_MAX 32
>> +static int m10bmc_sec_probe(struct platform_device *pdev)
>> +{
>> +	struct m10bmc_sec *sec;
>> +
>> +	sec = devm_kzalloc(&pdev->dev, sizeof(*sec), GFP_KERNEL);
>> +	if (!sec)
>> +		return -ENOMEM;
>> +
>> +	sec->dev = &pdev->dev;
>> +	sec->m10bmc = dev_get_drvdata(pdev->dev.parent);
>> +	dev_set_drvdata(&pdev->dev, sec);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct platform_device_id intel_m10bmc_sec_ids[] = {
>> +	{
>> +		.name = "n3000bmc-sec-update",
>> +	},
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(platform, intel_m10bmc_sec_ids);
>> +
>> +static struct platform_driver intel_m10bmc_sec_driver = {
>> +	.probe = m10bmc_sec_probe,
>> +	.driver = {
>> +		.name = "intel-m10bmc-sec-update",
>> +		.dev_groups = m10bmc_sec_attr_groups,
>> +	},
>> +	.id_table = intel_m10bmc_sec_ids,
>> +};
>> +module_platform_driver(intel_m10bmc_sec_driver);
>> +
>> +MODULE_AUTHOR("Intel Corporation");
>> +MODULE_DESCRIPTION("Intel MAX10 BMC Secure Update");
>> +MODULE_LICENSE("GPL");
>> -- 
>> 2.25.1

