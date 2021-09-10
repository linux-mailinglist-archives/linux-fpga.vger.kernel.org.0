Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2E7A4072B0
	for <lists+linux-fpga@lfdr.de>; Fri, 10 Sep 2021 22:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233736AbhIJUtH (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 10 Sep 2021 16:49:07 -0400
Received: from mga11.intel.com ([192.55.52.93]:64017 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233384AbhIJUtH (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 10 Sep 2021 16:49:07 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10103"; a="218001644"
X-IronPort-AV: E=Sophos;i="5.85,283,1624345200"; 
   d="scan'208";a="218001644"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2021 13:47:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,283,1624345200"; 
   d="scan'208";a="697289976"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by fmsmga005.fm.intel.com with ESMTP; 10 Sep 2021 13:47:55 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 10 Sep 2021 13:47:55 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 10 Sep 2021 13:47:54 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Fri, 10 Sep 2021 13:47:54 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.102)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Fri, 10 Sep 2021 13:47:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y2HQ3FWa3CdPgTgIMrAuMTEwA74QTZQ8JzA5WrUd8sMxVDR78vnjBmIrnIEjiU4oSpvNeq1citIr8SoceUoPHn1dypxWhT6k2nXQ/tEkpJgBfZhfJG7+fJyCdpySOtuaV52hqy5uB7lLNCnO/dOkkYSdKMITdq1DO/LBDzhqEJllsMbbS7ZnXCOtMEEts+MDZVKS/Xn6sfXqoL0UNANqYAcITsTRe6b6Osvf3ouJgScY920/TCEjygOxxmlK4JLtnCbqMOwYCu1jpWVYID9b1ohELIZnqwY7Egwv/uSnu9ox9uOc+XZcm0amm/EALiCEtQ8saRdVkgbCZaYsT87CtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=aa/jCALVeUnl+bZNAqV7tuwta4sKVvTpfQ2kDw1Z/hQ=;
 b=Sf7VPLaGF7nLRu0z6aelZGsAolro20SYiFI6z5Q5fz+/ndpK5ATTi5YMSfe9w0SnT2RFwiyVz1YOzdnSbT5deYrrnqErPgv+8nAOu6IICV3QRve6dALOWDdO4R33YvFVkX+dQ4+3o5dEOcPAK8iuqKUwa1wOabSCGoTJ0PFj1wfCMV5khqfzpZEZyHOSpeEdvRgh4+PklLqpn5JWC7B94g8nkMFgLKDV/YzaBNTTfDJKw3t6jfEdaSk8ZRcvrywdIZoRU1+VrB2oyMPAwq9Fm8Mv4sufzNjstrSYIl9ULipan2EsbKq1WeuTpunbaDBr+o6+npGp8L4PA6NiRdWPhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aa/jCALVeUnl+bZNAqV7tuwta4sKVvTpfQ2kDw1Z/hQ=;
 b=jjvpo7P7x03d3U1TCdHQ6Wj5JaXCubhFt6Ds1PL1uU4mYpqboIUs0h+eITre246y1NeObBDs6bwm3HTGjcpVM+Q0N1rigWiEFFSpax/gDDZNcZgA4Rw567RT7zhn0Puq3VDCDkUR+/tz2VP0y9sXAX3r14PWh3Sw3pPXEwhP2GU=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
Received: from SA2PR11MB5163.namprd11.prod.outlook.com (2603:10b6:806:113::20)
 by SA0PR11MB4719.namprd11.prod.outlook.com (2603:10b6:806:95::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16; Fri, 10 Sep
 2021 20:47:46 +0000
Received: from SA2PR11MB5163.namprd11.prod.outlook.com
 ([fe80::90de:46c1:4d23:5c8c]) by SA2PR11MB5163.namprd11.prod.outlook.com
 ([fe80::90de:46c1:4d23:5c8c%6]) with mapi id 15.20.4500.017; Fri, 10 Sep 2021
 20:47:46 +0000
Subject: Re: [PATCH v15 1/6] fpga: image-load: fpga image load class driver
To:     Xu Yilun <yilun.xu@intel.com>
CC:     <mdf@kernel.org>, <linux-fpga@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <trix@redhat.com>,
        <lgoncalv@redhat.com>, <hao.wu@intel.com>,
        <matthew.gerlach@intel.com>
References: <20210909021846.681121-1-russell.h.weight@intel.com>
 <20210909021846.681121-2-russell.h.weight@intel.com>
 <20210910064658.GA754505@yilunxu-OptiPlex-7050>
From:   Russ Weight <russell.h.weight@intel.com>
Message-ID: <bc55df5c-d571-aaa5-f36d-2985419bcd29@intel.com>
Date:   Fri, 10 Sep 2021 13:47:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
In-Reply-To: <20210910064658.GA754505@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: MWHPR18CA0065.namprd18.prod.outlook.com
 (2603:10b6:300:39::27) To SA2PR11MB5163.namprd11.prod.outlook.com
 (2603:10b6:806:113::20)
MIME-Version: 1.0
Received: from [10.0.2.4] (50.43.42.212) by MWHPR18CA0065.namprd18.prod.outlook.com (2603:10b6:300:39::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Fri, 10 Sep 2021 20:47:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 192b6850-e66c-44db-0124-08d9749c3e9e
X-MS-TrafficTypeDiagnostic: SA0PR11MB4719:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR11MB47192FB37CC728145EAAAFEFC5D69@SA0PR11MB4719.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I84sDlCJz59EOQoW4LJxoTq3qnM1XcpTSO6oa0trjTS2/AoIQOoz4eTeOK1HNGVSeelJ1kY63SyC9I0sOJ6qvZgYzfPFIP/I+j4Z5WVPJJllL4lzNngFbp4YbD/oI9joWvLj6xL9pp1OJgHKuhRDv2ydDrACZJMnzeexlJ8GbVNNpdkAg8khybgdtwSYSq8m6LL6T+Eg7c6YTDIKCWCJ78pdrdJzpJlckbRydfv1EtXivPacIigtFWTIYn0jJzW36U9SKrXwPc4OUJDlpnYAOGr9kZEfxwYeWxy06XIU+La082u/ClTye540/ilCeXS0BFjPwJumcEGNaZcza1XeyvTOp0TAwKzDLWt8nJm/AWXoWX42E1pg3ZNPOeH9+y5XfyhMq2IWp/BKFj5vo5qyoIjWk61beaYFLMBWLYu2yOPBfGjgSQ7oU8uDGc4/giSp1y49fZUjbIK4qA1Pu+tLDgXwELU7LdGesPVWvZbqprr6N9e44m6SFzXj6U6Mgt/Ha6hBFXMnWW7mOJJ/KyRQrhnWpr0NMG136TzJDe17AqW8kpxnasFmGeQSTWSnldOmL6mpWTi0HXw+UMtkKYuLsd9GOQtlebSMRidIQoB0u3JzhROsa0aBB4g9Ymsuq9PZoLJiOxNZeFqliBQJSYWZ89ulUwkKulBKG4Fdop8J+MY1K9wqxkV4FwPwE3kB+t+ulrl8E3fnXEIt6R3CKQhRURdMdsxVEgARji3S7vz+EkM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB5163.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(366004)(136003)(376002)(346002)(37006003)(83380400001)(316002)(36756003)(478600001)(107886003)(6486002)(2906002)(956004)(86362001)(6862004)(8936002)(4326008)(16576012)(30864003)(38100700002)(53546011)(6636002)(66556008)(8676002)(186003)(5660300002)(66946007)(26005)(31696002)(2616005)(31686004)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1lTNFJhczFzWC9qNGhEaVpQZGhYSHVXajhncjRCUWRGSGhJR0RUYWltSG9u?=
 =?utf-8?B?U2xONk5oWk1UZHVBV1lNc2hpU2p4TlQ3dU91UzNQZFdjQ0pZNE40R3ZxaHg3?=
 =?utf-8?B?NXVHajBUbzc5aGlsMERwb3VaUzZUS3B2TGUwY3B3VDd6UldDbmxBdk11cHRD?=
 =?utf-8?B?cTM2d3VqaEVBbGNPdk9vVkMrWnRqOGd6UllZMkRQWDJWdFBMcXdML2xJWklK?=
 =?utf-8?B?U2VVa1lFRWl0eDREUWluSXFTZlFnbGNqaXhyaFJ3dk5DT1Q3WHNaY2VyeTRJ?=
 =?utf-8?B?UzlLTTVQb0hRa1pxSHV0bzNCK05LTzNVaEh5VkJnZmZ2L3lONGxuUWdwQlFC?=
 =?utf-8?B?aEVYbDFubTd5VCt4WXBxK2padXNRc3Fta1ZJMFE3UFZNaWwwNnYwY2E5Y3k1?=
 =?utf-8?B?NHAweklROTF1aWFHWnY3MFhDNmRTUUVyNk5ZTFFpYWRJZlVHSExxd05PRENN?=
 =?utf-8?B?MFFCdFF6T3psY3h3bFpqVGorYVVrQm1GWTQzM2wvUVVFa0ZzK0hIVEN2OHhj?=
 =?utf-8?B?UlJqakNYQ3ovdHRLTlU3cXdkUWJPV0ExQXA2M2gwNm1wUUEydzV2SDlTR1Nl?=
 =?utf-8?B?Q3k3SEVYYXpBS2Q1YXY5QmU4R08vdm1HSFUwUVZVbnpGUWk0anBLcmkxVzlS?=
 =?utf-8?B?VUVvaVZRQjN5NndVNjc4UkFRRzdyL25scm5UQ0JWNm9aeCtZNENDcHM4RkFj?=
 =?utf-8?B?eXdUdjZGbnFHSnM1dCtQbE4yOEpIM2o1bFhOSTZWM0VWYXdtNWxDVnoxRmkx?=
 =?utf-8?B?OFFOMGtTd1c0Tml3S29vbmg4SUVsWi9YMHZsQThSNW5wUklyMGFuSXpQelJ2?=
 =?utf-8?B?S1lneGhJa3RJTkdyeUFHamZkV3JVSG9HTGdtZjdIaHFrYXpMS0x4WWs0ZnBC?=
 =?utf-8?B?bFVyOTRMV2xOVXVzNmNNSmNXV2FHM0hWeVdqQ0cyWE03ZW14SjdUalhObFBm?=
 =?utf-8?B?Qm1nZ2E3VDhFR09zLy9CR2diclVPS3pWY09PbE9CaU8wT1FERmVBQkJlbzNk?=
 =?utf-8?B?dHErOTlmViszUVV0bW0wbnlSTC9IbjdqRlNHa25DWWVieFFrQ3d1VDdlWWkw?=
 =?utf-8?B?Uzg2cHJzcU52TDlYbFYwSm5Zc2xKNVlDcnJDOHRUb1RZNW1acTB1REUwcXBa?=
 =?utf-8?B?bU41RkNwNTJtZGl1TXVudEF2SDVzdkdBWEF3NGcxRmZoYjlpUzFIWUNmcUMx?=
 =?utf-8?B?M3hmMjVzMWllaGQvaHlkUXlQTFYyeWVVRVBCRjdReXRIWFl5bHV4S1NiWU12?=
 =?utf-8?B?Ym5UdmRQVlpSTWZrMDhOL2FjcmhTcGUyekc3bWhKQjlwbVE4eThTU0Uwa1hy?=
 =?utf-8?B?dXJ1ZW5JN3BWSmZQYWtCWG1zUkhVcFIxT1ppSDR2dVVEeXUyRmhSM1pENlFq?=
 =?utf-8?B?azRIblA3bmFFRVFhbVp4VndvcG00UlMxbUpod1pURy9BL0FrKytuYTk5N3Aw?=
 =?utf-8?B?UkoveG5MZWNUVkRReEFCT2twNERRSFRJZy9DQWxzOFRsdXY1bkdSaTJHajkv?=
 =?utf-8?B?V0EzaTQ4Z0g1dzVQUHZOVWdhS3JGQUg4TkNTR1g5dmtnc2xGZVJqWDV0dVBJ?=
 =?utf-8?B?VkdIRkVFSmVnZ1NFa3pTSnBpYkVpVzZIVzVtU0lBNGRIcm5LdXZBZklXUnNX?=
 =?utf-8?B?eW00eU9qNnVwcEMrWkpwK2VVV1VvejRDNVN4RU1GTkFmQlR4bnNXNEF5ZG1M?=
 =?utf-8?B?WXpUZWRSM2ZpTE9yVE1qQjhwalpnZ2dqRFFRRmJqVSszM1NOTy91bjlPVWpG?=
 =?utf-8?Q?NmP4sURKPWJ2Wu3hFpb5KXXc+6zdZdb3ARs5ZH8?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 192b6850-e66c-44db-0124-08d9749c3e9e
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB5163.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2021 20:47:46.5172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xQK4qhy5+/an0CiWyVuTagQEXki7/QBGxpA+Z8ZT0JvOrxVp7uHVrfHuxU+vZ/VDy8+ppn8yFQ573b3edxuC0YHNCTtfOgWjhPWToz/QIIs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4719
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 9/9/21 11:46 PM, Xu Yilun wrote:
> On Wed, Sep 08, 2021 at 07:18:41PM -0700, Russ Weight wrote:
>> The FPGA Image Load class driver provides an API to transfer update
>> files to an FPGA device. Image files are self-describing. They could
>> contain FPGA images, BMC images, Root Entry Hashes, or other device
>> specific files. It is up to the device driver and the target device
>> to authenticate and disposition the file data.
>>
>> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
>> ---
>> v15:
>>  - Compare to previous patch:
>>      [PATCH v14 1/6] fpga: sec-mgr: fpga security manager class driver 
>>  - Changed file, symbol, and config names to reflect the new driver name
>>  - Rewrote documentation. The documentation will be added to in later patches.
>>  - Removed signed-off/reviewed-by tags
>> v14:
>>  - Updated copyright to 2021
>>  - Removed the name sysfs entry
>>  - Removed MAINTAINERS reference to
>>    Documentation/ABI/testing/sysfs-class-fpga-sec-mgr
>>  - Use xa_alloc() instead of ida_simple_get()
>>  - Rename dev to parent for parent devices
>>  - Remove fpga_sec_mgr_create(), devm_fpga_sec_mgr_create(), and
>>    fpga_sec_mgr_free() functions and update the fpga_sec_mgr_register()
>>    function to both create and register a new security manager.
>>  - Populate the fpga_sec_mgr_dev_release() function.
>> v13:
>>   - No change
>> v12:
>>   - Updated Date and KernelVersion fields in ABI documentation
>> v11:
>>   - No change
>> v10:
>>   - Rebased to 5.12-rc2 next
>>   - Updated Date and KernelVersion in ABI documentation
>> v9:
>>   - Updated Date and KernelVersion in ABI documentation
>> v8:
>>   - Fixed grammatical error in Documentation/fpga/fpga-sec-mgr.rst
>> v7:
>>   - Changed Date in documentation file to December 2020
>> v6:
>>   - Removed sysfs support and documentation for the display of the
>>     flash count, root entry hashes, and code-signing-key cancelation
>>     vectors.
>> v5:
>>   - Added the devm_fpga_sec_mgr_unregister() function, following recent
>>     changes to the fpga_manager() implementation.
>>   - Changed some *_show() functions to use sysfs_emit() instead of sprintf(
>> v4:
>>   - Changed from "Intel FPGA Security Manager" to FPGA Security Manager"
>>     and removed unnecessary references to "Intel".
>>   - Changed: iops -> sops, imgr -> smgr, IFPGA_ -> FPGA_, ifpga_ to fpga_
>> v3:
>>   - Modified sysfs handler check in check_sysfs_handler() to make
>>     it more readable.
>> v2:
>>   - Bumped documentation dates and versions
>>   - Added Documentation/fpga/ifpga-sec-mgr.rst
>>   - Removed references to bmc_flash_count & smbus_flash_count (not supported)
>>   - Split ifpga_sec_mgr_register() into create() and register() functions
>>   - Added devm_ifpga_sec_mgr_create()
>>   - Removed typedefs for imgr ops
>> ---
>> ---
>>  Documentation/fpga/fpga-image-load.rst |  10 ++
>>  Documentation/fpga/index.rst           |   1 +
>>  MAINTAINERS                            |   8 ++
>>  drivers/fpga/Kconfig                   |  10 ++
>>  drivers/fpga/Makefile                  |   3 +
>>  drivers/fpga/fpga-image-load.c         | 124 +++++++++++++++++++++++++
>>  include/linux/fpga/fpga-image-load.h   |  35 +++++++
>>  7 files changed, 191 insertions(+)
>>  create mode 100644 Documentation/fpga/fpga-image-load.rst
>>  create mode 100644 drivers/fpga/fpga-image-load.c
>>  create mode 100644 include/linux/fpga/fpga-image-load.h
>>
>> diff --git a/Documentation/fpga/fpga-image-load.rst b/Documentation/fpga/fpga-image-load.rst
>> new file mode 100644
>> index 000000000000..a6e53ac66026
>> --- /dev/null
>> +++ b/Documentation/fpga/fpga-image-load.rst
>> @@ -0,0 +1,10 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +
>> +============================
>> +FPGA Image Load Class Driver
>> +============================
>> +
>> +The FPGA Image Load class driver provides a common API for user-space
>> +tools to manage image uploads to FPGA devices. Device drivers that
>> +instantiate the FPGA Image Load class driver will interact with the
>> +target device to transfer and authenticate the image data.
>> diff --git a/Documentation/fpga/index.rst b/Documentation/fpga/index.rst
>> index f80f95667ca2..85d25fb22c08 100644
>> --- a/Documentation/fpga/index.rst
>> +++ b/Documentation/fpga/index.rst
>> @@ -8,6 +8,7 @@ fpga
>>      :maxdepth: 1
>>  
>>      dfl
>> +    fpga-image-load
>>  
>>  .. only::  subproject and html
>>  
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 6c63415d2ac2..4e7f48fa7e5c 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -7358,6 +7358,14 @@ F:	Documentation/fpga/
>>  F:	drivers/fpga/
>>  F:	include/linux/fpga/
>>  
>> +FPGA SECURITY MANAGER DRIVERS
>> +M:	Russ Weight <russell.h.weight@intel.com>
>> +L:	linux-fpga@vger.kernel.org
>> +S:	Maintained
>> +F:	Documentation/fpga/fpga-image-load.rst
>> +F:	drivers/fpga/fpga-image-load.c
>> +F:	include/linux/fpga/fpga-image-load.h
>> +
>>  FPU EMULATOR
>>  M:	Bill Metzenthen <billm@melbpc.org.au>
>>  S:	Maintained
>> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
>> index 991b3f361ec9..c12a14e62fff 100644
>> --- a/drivers/fpga/Kconfig
>> +++ b/drivers/fpga/Kconfig
>> @@ -243,4 +243,14 @@ config FPGA_MGR_VERSAL_FPGA
>>  	  configure the programmable logic(PL).
>>  
>>  	  To compile this as a module, choose M here.
>> +
>> +config FPGA_IMAGE_LOAD
>> +	tristate "FPGA Image Load Driver"
> Maybe we don't call it "Driver". A framework or "FPGA Image load support",
> is it better?
>
> There are more descriptions about "driver" below, maybe you need to change
> them all.

Yeah - I think that language sounds better.
>
>> +	help
>> +	  The FPGA Image Load class driver presents a common user API for
>> +	  uploading an image file to an FPGA device. The image file is
>> +	  expected to be self-describing. It is up to the device driver
>> +	  and/or the device itself to authenticate and disposition the
>> +	  image data.
>> +
>>  endif # FPGA
>> diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
>> index 0bff783d1b61..adf228ee4f5e 100644
>> --- a/drivers/fpga/Makefile
>> +++ b/drivers/fpga/Makefile
>> @@ -22,6 +22,9 @@ obj-$(CONFIG_FPGA_MGR_VERSAL_FPGA)      += versal-fpga.o
>>  obj-$(CONFIG_ALTERA_PR_IP_CORE)         += altera-pr-ip-core.o
>>  obj-$(CONFIG_ALTERA_PR_IP_CORE_PLAT)    += altera-pr-ip-core-plat.o
>>  
>> +# FPGA Image Load Framework
>> +obj-$(CONFIG_FPGA_IMAGE_LOAD)		+= fpga-image-load.o
>> +
>>  # FPGA Bridge Drivers
>>  obj-$(CONFIG_FPGA_BRIDGE)		+= fpga-bridge.o
>>  obj-$(CONFIG_SOCFPGA_FPGA_BRIDGE)	+= altera-hps2fpga.o altera-fpga2sdram.o
>> diff --git a/drivers/fpga/fpga-image-load.c b/drivers/fpga/fpga-image-load.c
>> new file mode 100644
>> index 000000000000..7d75bbcff541
>> --- /dev/null
>> +++ b/drivers/fpga/fpga-image-load.c
>> @@ -0,0 +1,124 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * FPGA Image Load Class Driver
>> + *
>> + * Copyright (C) 2019-2021 Intel Corporation, Inc.
>> + */
>> +
>> +#include <linux/fpga/fpga-image-load.h>
>> +#include <linux/module.h>
>> +#include <linux/slab.h>
>> +#include <linux/vmalloc.h>
>> +
>> +#define IMAGE_LOAD_XA_LIMIT	XA_LIMIT(0, INT_MAX)
>> +static DEFINE_XARRAY_ALLOC(fpga_image_load_xa);
>> +
>> +static struct class *fpga_image_load_class;
>> +
>> +#define to_image_load(d) container_of(d, struct fpga_image_load, dev)
>> +
>> +/**
>> + * fpga_image_load_register - create and register an FPGA Image Load Device
>> + *
>> + * @parent: fpga image load device from pdev
>> + * @lops:   pointer to a structure of image load callback functions
> Maybe "ops" is just good, some more below.

OK
>
>> + * @priv:   fpga image load private data
>> + *
>> + * Returns a struct fpga_image_load pointer on success, or ERR_PTR() on
>> + * error. The caller of this function is responsible for calling
>> + * fpga_image_load_unregister().
>> + */
>> +struct fpga_image_load *
>> +fpga_image_load_register(struct device *parent,
>> +			 const struct fpga_image_load_ops *lops, void *priv)
>> +{
>> +	struct fpga_image_load *imgld;
>> +	int id, ret;
>> +
>> +	imgld = kzalloc(sizeof(*imgld), GFP_KERNEL);
>> +	if (!imgld)
>> +		return NULL;
>> +
>> +	ret = xa_alloc(&fpga_image_load_xa, &imgld->dev.id, imgld, IMAGE_LOAD_XA_LIMIT,
>> +		       GFP_KERNEL);
>> +	if (ret)
>> +		goto error_kfree;
>> +
>> +	mutex_init(&imgld->lock);
>> +
>> +	imgld->priv = priv;
>> +	imgld->lops = lops;
>> +
>> +	imgld->dev.class = fpga_image_load_class;
>> +	imgld->dev.parent = parent;
>> +
>> +	ret = dev_set_name(&imgld->dev, "fpga_image%d", id);
> Is it better "fpga_image_load%d"?
OK

Thanks for the comments,
- Russ
>
>> +	if (ret) {
>> +		dev_err(parent, "Failed to set device name: fpga_image%d\n", id);
>> +		goto error_device;
>> +	}
>> +
>> +	ret = device_register(&imgld->dev);
>> +	if (ret) {
>> +		put_device(&imgld->dev);
>> +		return ERR_PTR(ret);
>> +	}
>> +
>> +	return imgld;
>> +
>> +error_device:
>> +	xa_erase(&fpga_image_load_xa, imgld->dev.id);
>> +
>> +error_kfree:
>> +	kfree(imgld);
>> +
>> +	return ERR_PTR(ret);
>> +}
>> +EXPORT_SYMBOL_GPL(fpga_image_load_register);
>> +
>> +/**
>> + * fpga_image_load_unregister - unregister an FPGA image load device
>> + *
>> + * @imgld: pointer to struct fpga_image_load
>> + *
>> + * This function is intended for use in an FPGA Image Load driver's
>> + * remove() function.
>> + */
>> +void fpga_image_load_unregister(struct fpga_image_load *imgld)
>> +{
>> +	device_unregister(&imgld->dev);
>> +}
>> +EXPORT_SYMBOL_GPL(fpga_image_load_unregister);
>> +
>> +static void fpga_image_load_dev_release(struct device *dev)
>> +{
>> +	struct fpga_image_load *imgld = to_image_load(dev);
>> +
>> +	xa_erase(&fpga_image_load_xa, imgld->dev.id);
>> +	kfree(imgld);
>> +}
>> +
>> +static int __init fpga_image_load_class_init(void)
>> +{
>> +	pr_info("FPGA Image Load Driver\n");
>> +
>> +	fpga_image_load_class = class_create(THIS_MODULE, "fpga_image_load");
>> +	if (IS_ERR(fpga_image_load_class))
>> +		return PTR_ERR(fpga_image_load_class);
>> +
>> +	fpga_image_load_class->dev_release = fpga_image_load_dev_release;
>> +
>> +	return 0;
>> +}
>> +
>> +static void __exit fpga_image_load_class_exit(void)
>> +{
>> +	class_destroy(fpga_image_load_class);
>> +	WARN_ON(!xa_empty(&fpga_image_load_xa));
>> +}
>> +
>> +MODULE_DESCRIPTION("FPGA Image Load Driver");
>> +MODULE_LICENSE("GPL v2");
>> +
>> +subsys_initcall(fpga_image_load_class_init);
>> +module_exit(fpga_image_load_class_exit)
>> diff --git a/include/linux/fpga/fpga-image-load.h b/include/linux/fpga/fpga-image-load.h
>> new file mode 100644
>> index 000000000000..a9cef9e1056b
>> --- /dev/null
>> +++ b/include/linux/fpga/fpga-image-load.h
>> @@ -0,0 +1,35 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Header file for FPGA Image Load Driver
>> + *
>> + * Copyright (C) 2019-2021 Intel Corporation, Inc.
>> + */
>> +#ifndef _LINUX_FPGA_IMAGE_LOAD_H
>> +#define _LINUX_FPGA_IMAGE_LOAD_H
>> +
>> +#include <linux/device.h>
>> +#include <linux/mutex.h>
>> +#include <linux/types.h>
>> +
>> +struct fpga_image_load;
>> +
>> +/**
>> + * struct fpga_image_load_ops - device specific operations
>> + */
>> +struct fpga_image_load_ops {
>> +};
>> +
>> +struct fpga_image_load {
>> +	struct device dev;
>> +	const struct fpga_image_load_ops *lops;
>> +	struct mutex lock;		/* protect data structure contents */
>> +	void *priv;
>> +};
>> +
>> +struct fpga_image_load *
>> +fpga_image_load_register(struct device *dev,
>> +			 const struct fpga_image_load_ops *lops, void *priv);
>> +
>> +void fpga_image_load_unregister(struct fpga_image_load *imgld);
>> +
>> +#endif
>> -- 
>> 2.25.1
> Thanks,
> Yilun

