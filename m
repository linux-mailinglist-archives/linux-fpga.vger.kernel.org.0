Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5E606955D2
	for <lists+linux-fpga@lfdr.de>; Tue, 14 Feb 2023 02:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjBNBUZ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 13 Feb 2023 20:20:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjBNBUY (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 13 Feb 2023 20:20:24 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 490964ECA;
        Mon, 13 Feb 2023 17:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676337623; x=1707873623;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ChKiR4XTEm1RABk/v514GeAKaCqUipvPSBI6lvuGEdc=;
  b=WN3d6ND5QeHzCHOy6L8PaYKbYJoWTZuWho2nJEhv1hBOs39y1DX1ejdx
   BRLGPUuUVs5xss2syu4YvgWyA+l4YQV3OYJxxJTRCMn4QBUU2y8ACoBch
   y/GTklS5JvnF7MvLXNmxlfusdbQVrBwtM6clSbT9pBwXHyafC9bEBjJ5D
   x19gSEcxu4vQd8C80pBe+mbv39mmVmWdcn3cI+bVNjgSdOfG89TSsMyBc
   kukMDgeik8l36YJur8mRjfDxZvGblBZgypVkMcSnERS/g3ic4X3G5bDmW
   F6hAV51pCRKxNal3q3qyT9v+43xt0polFrv08oua+zjTQA4RSu1tJeT9h
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="329677481"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="329677481"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 17:20:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="737716313"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="737716313"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP; 13 Feb 2023 17:20:18 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 13 Feb 2023 17:20:16 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 13 Feb 2023 17:20:16 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 13 Feb 2023 17:20:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SUx1HKrQQIDPNA/w9mstJlMhyIptjRP+AfUw2gZu9uxkeNTAMmAxiMlAQ5/5oMn8kD+KRG86Mw7DfqwY0mAHjshNfzJCTKwZi2ANn+L8ZVFZTlEpt2QfQsvyMhegBT9nzOwAYlGEtELO0e0DSWdiIxUZ7cML2M+e4V2hhfKoteVaph2D5dRKP+25K1sxQk4AK2ZTG4D0w0p24nr6+dDpf+3ZW9BG2HZtbGXd6LNNP3rSOf7NoV525vZwQN26tz3pgQhgse05mlUakeBW84M9PxtJq71oT1vEM4xZFnJy6bIpKmxj8iUxSFEtii63Zg04Xqmf4grHStWIqfs4LH5eXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MZU4SIc3Lgy1PFsobS5Ozi7Ha9Ub+NUmFYJZu6JPxQ0=;
 b=Ja0UJfe9SWfkGNvNZToM9GlCVr0t4YCx3E77Shj5Y65LrFpDjBIQsGrkql2BkOzhqitT1OF38wFt6ialC9jbTkScPNPvATsLt+7FaPKaSBQSrxrzypfXM5NAaxHM4qMa8tFdnq3ba9ZSx1xYBsSYPC0fcGmurC4QIm/OfqJbdMkN2h9QtH+q19NZes81SQyiI4LblUYOUHNkqX+QlEBVaTnHDZnnaCf/W/U4CYr650Ycb4qDAFZEGDQnlf/vUhd5886Qbv5umtNdo/+PKcn04LrMgMzT3P1EqA/OzZEK9hgfAslubbtSVl3cgSCqganEkdXGa8TkU08Yy/BKpLArBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM5PR11MB1899.namprd11.prod.outlook.com (2603:10b6:3:10b::14)
 by BL3PR11MB6340.namprd11.prod.outlook.com (2603:10b6:208:3b4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Tue, 14 Feb
 2023 01:20:06 +0000
Received: from DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::d151:74c0:20d6:d5fc]) by DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::d151:74c0:20d6:d5fc%6]) with mapi id 15.20.6086.024; Tue, 14 Feb 2023
 01:20:06 +0000
Message-ID: <05f6238e-4ad8-f30c-38da-74c343e6abb5@intel.com>
Date:   Mon, 13 Feb 2023 17:20:01 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [RFC PATCH 0/4] fpga: add initial KUnit test suite for the
 subsystem
Content-Language: en-US
To:     Marco Pagani <marpagan@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, "Wu Hao" <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-fpga@vger.kernel.org>
References: <20230203170653.414990-1-marpagan@redhat.com>
From:   Russ Weight <russell.h.weight@intel.com>
In-Reply-To: <20230203170653.414990-1-marpagan@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0063.namprd03.prod.outlook.com
 (2603:10b6:303:b6::8) To DM5PR11MB1899.namprd11.prod.outlook.com
 (2603:10b6:3:10b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR11MB1899:EE_|BL3PR11MB6340:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e0b4e66-879f-41e0-c0fc-08db0e299a8f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vVdcziZ/NM/2/H67w/EJkMBqRPFjhZFamf4t++IeaysLNBGB9sQH1MgSR7AQjsAAjZ3ykHAGgCJgaAC6pOyUuK9Sr60z9Dh66uGeOWbayhB2QdFnYllWjwZFVhlGbTnMryXIkVqMse+0Zf7ZhGf8404NbdpdYQdDbVoTbHoLTrJvgkvSjswR2RWkO+xBT+mnZk4E8CZxbOL++ZzB24i1tcXk+hnk4ByhqnJgG8BRPBEy+ecBo6X1UWdLlUxuCDJh4yjAPKQ8QGsbMrOd5kDQdaVP+kSzCB5oI0Le0jn3r/2JOTF0Mf3WyPmcSgQ58sbxaS1lqSdAKcEKyCjXpZbpAt3KQ+esQbxGmfGqVyVY09Dy0rbiaSRIvglOKvRgYowSA8bRpDoUn4315xRPPoVJgAqvbzxXndPaoWWpbhD2gJ3GJxFEBMFCKn2DEHBA7NACfZRrflvPM881XfIqDHwgn6yvVFGrRmQvtMaiNUUc2JThawnpIzAD2i8AxGsgukpqinu+Q+KSMH0/IKvV9yTWNF0xoAK1HGHBnF/VKehcbfM2lWUr3k0AJ1w5UUQyuE8ElqW4v+F2z0lMVq4FPc1runrvEJA6lE/Y63kBm4H78ay2Suov2IWBlG3JKcLW21yYlMe++SCe/in8M37SeaqAfhSguYOhdGw3X4VoTLGABdupM1f741PjJpYnLk6hrBIST9wfG9vbW81iHvfxSctYdrqfPwmIqXuCDCDPfFDkJCU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1899.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(39860400002)(366004)(376002)(136003)(396003)(451199018)(31696002)(36756003)(86362001)(110136005)(316002)(4326008)(66946007)(8676002)(6486002)(478600001)(2906002)(66556008)(41300700001)(5660300002)(8936002)(82960400001)(66476007)(38100700002)(6512007)(2616005)(26005)(53546011)(186003)(6506007)(6666004)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXgwQzBRaWhFazR2czdJVklrQ1VVZFFFa2MrQkVuZW5RaWdXNmE1RDI0cW9H?=
 =?utf-8?B?Y2x1d2krQnZ6eWptY3lrdnBlMTV3b0h2M251NFlCcmhBNnBuK3I5ejF1MmdR?=
 =?utf-8?B?a3F3aFVmVkpUUHNoVlppVWpObTk5YUxXN3Z1RkdLS0hNd3did2lKRXIveUo2?=
 =?utf-8?B?cFl2c1pjZlh5d0wydkpNOXlEZkhScVV1b2p2QWRaY1AzaksyY0x2OWNObkU2?=
 =?utf-8?B?ZDR1dlRUb3Y2KzU1ckFqOUMyNkIrS1RtWGFuTnlRQlJqVWJuSi9pYXdJdEIx?=
 =?utf-8?B?TnNDSnh3cUxDalI1YzA1V1BiTDRZYkgyUStxWHNsbW93Ry9kdDFuOGFMY0Nl?=
 =?utf-8?B?ZFd5T0FKdHFVdGUrU1pucWhVa21TenQwbi9iU1hDbm5xZ0k4UWN3UU0rM1l1?=
 =?utf-8?B?bWtqTnl5M3l4M1loNEl1Uys4U0VnSWZMVWk2aEsvbXlnM3lzMS9PSVJhYVY4?=
 =?utf-8?B?S2V1NEw5ZHhvYVA5U09pY2FKdjJuWGt1NlJHK0VQZzZzZEJqOWhHVkF0emJR?=
 =?utf-8?B?MkhmYm5MeUlXVEppMGdReTh4ZThxZ2JZZDlvVU9iNFZ5dFhHSUJ3dnN1MUFV?=
 =?utf-8?B?RnZBVWIxaGU3MW9iV1pSa2QwcXFZd0p5RHJRRXhIQVN6LzlHbThBQlZKRnZO?=
 =?utf-8?B?cFRveEpZLzFtVXhLRWhMRGZ0V2VKMDBwWEhnemdjYzJ3VnlEeklweGNSdng1?=
 =?utf-8?B?bnM5cHU2TXd1V3lGQjZxUVRXN0pnSGNaRzMzdE1HUDE3MEJBemNHcncvbUVN?=
 =?utf-8?B?ZU1CYTZLWWRzMDA2KzFhOXp0eG1zQ1ZqcXprUzFWMFRnY0IwWlB0QlJxbTRV?=
 =?utf-8?B?UTN2OUVxbnpRb0tpKys2ZHd1b2dla2UrcnVOVzhpUDM4U3kxQm9uOWYzbDYw?=
 =?utf-8?B?b3BZVXcyU09mTHVra0NrRlQ4MlJpRWc4Z0xvSUZVRnJPd3RveGx4OVNPckd3?=
 =?utf-8?B?RytQZ29UOTcxd2MxUzBxbjRtRkF5amlGVy9ST1hTTnlqWXVpYk1MV2VIS2p2?=
 =?utf-8?B?eXAzWk9nNHBkZmRrc0FTWStYbHM3VEhxL1BLTEJhU1V2NldyaWc3anNBbDF4?=
 =?utf-8?B?UzBZMDNpUnRINWFPYXNkMHBlaGpCanFlRGRmS2tybzlrTlVHc2UvUFdpeXIx?=
 =?utf-8?B?YkkwVkZGY0srazFhU0RFTTVkbHhMRXN2dndBVzV4V1RhTmxqMU4wZW8vUklP?=
 =?utf-8?B?T2xROVJXU095a01Ka01QT2dSb1ptOVVONjg2SGFzTG5CZ1oyVjR3bURlRUww?=
 =?utf-8?B?WEQxdWI4Tjl6LzJ0MzJkckk5NkNSY3pya1FLajlweURjYlNGZHJSZUdQbnJ0?=
 =?utf-8?B?bWpLZzVmOHZKalJPR1ZNSXJiRmYxeDMrU0pONHpVTVBTaEV5V01naGROa0NZ?=
 =?utf-8?B?Yk02RURMVnR0WThWb0lmNUMyOHVabDRaTXlHc0tSZHdHcnVMb29xelNtemVz?=
 =?utf-8?B?RjQ0MGExYmlaTC9aV095TmV3QnBNSVJIaEJCeVNJNTFwN2FERU9KeUJMckVL?=
 =?utf-8?B?OFE1RGZsNGU1MzJxdnY3bEE1Y0VRODZLdW8zYU9zSTNNdk9kcmpBZ1dnTUdh?=
 =?utf-8?B?NWJWbm1LVi9mRGRvcFZNbk5ML2gvSFpsNzF6ejVyeUQ0NFpzSmQydmwvUnkr?=
 =?utf-8?B?Sld0TE8zQlgxK2FKN0FOME04Q0MvR25GUmxWd3dYRDljNG9yd1VKdVNIZEwz?=
 =?utf-8?B?aVdsU1ZtNmRGRTlwNVFObmRhNmhpWGYyenF5M0pQaGZIQmtwTFJNT3V1UkRy?=
 =?utf-8?B?ZkQrczk4TEUzZWVRSGRjbkIrcXdqS2I5UXIyRnNWN01TV3BkR3hWM2l4OUtC?=
 =?utf-8?B?blB1NjRwV3ExZmEraUw3QXhlaG94WU5SUU4wU2Vtajk3RHJyMytPMFZwVnBj?=
 =?utf-8?B?Q3N3SmJVeUtpNWNXQmNveWVRMnVoZG9ZYkY2bHg2K2syTGd4NStrb2tiS00y?=
 =?utf-8?B?cU1VVlA3RU02cXJpZmhlNEV0c0s2OFFabVlKVkNGRldnTk9CSDlHa0hWY1Yz?=
 =?utf-8?B?YlA3bm44OE10Tyt1a2UrOExsN0ZTNVM5Q3gwMndicDVzeGk5dnFGWTQxTVJy?=
 =?utf-8?B?NWFSa0wxeE1SbDM1OXNRQ1RmVmtOS0dNQ1I1ZDBWYW9NT2o2OXlmeDV4bnhW?=
 =?utf-8?B?MjN0VkpPdHVQQ0FZN1J1V25UVlhvK3NPd1FMckxPc0xFR21aZXczYjIrQ1pj?=
 =?utf-8?B?QlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e0b4e66-879f-41e0-c0fc-08db0e299a8f
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1899.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 01:20:05.5898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: koOGpBLxs2ELb85+6dZEtaK6jxIghC2I0Ugj7eEjU2MaDkqQQc0naQHYmwuzNSgYdTTPtosSfdJ7SvotF5Ba1bOFPHbwIiSZm1P+cEZgoVM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6340
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 2/3/23 09:06, Marco Pagani wrote:
> This patch set introduces a KUnit suite to test the core components
> of the FPGA subsystem. More specifically, the suite tests the core
> functions of the FPGA manager, FPGA bridge, and FPGA region.
>
> These components are tested using "fake" modules that allow
> observing their internals without altering the source code.
>
> The test suite can be run using
> [user@localhost linux]$ ./tools/testing/kunit/kunit.py run --kunitconfig=drivers/fpga/tests
When I tried running these tests, I got an error until I created this file:

drivers/fpga/tests/.kunitconfig:
CONFIG_KUNIT=y
CONFIG_FPGA=y
CONFIG_FPGA_REGION=y
CONFIG_FPGA_BRIDGE=y
CONFIG_FPGA_KUNIT_TESTS=y

I think this file needs to be included in your patchset?

- Russ

>
> Marco Pagani (4):
>   fpga: add initial KUnit test suite
>   fpga: add fake FPGA region
>   fpga: add fake FPGA manager
>   fpga: add fake FPGA bridge
>
>  drivers/fpga/Kconfig                  |   2 +
>  drivers/fpga/Makefile                 |   3 +
>  drivers/fpga/tests/.kunitconfig       |   5 +
>  drivers/fpga/tests/Kconfig            |  15 ++
>  drivers/fpga/tests/Makefile           |   6 +
>  drivers/fpga/tests/fake-fpga-bridge.c | 214 +++++++++++++++
>  drivers/fpga/tests/fake-fpga-bridge.h |  36 +++
>  drivers/fpga/tests/fake-fpga-mgr.c    | 365 ++++++++++++++++++++++++++
>  drivers/fpga/tests/fake-fpga-mgr.h    |  42 +++
>  drivers/fpga/tests/fake-fpga-region.c | 186 +++++++++++++
>  drivers/fpga/tests/fake-fpga-region.h |  37 +++
>  drivers/fpga/tests/fpga-tests.c       | 264 +++++++++++++++++++
>  12 files changed, 1175 insertions(+)
>  create mode 100644 drivers/fpga/tests/.kunitconfig
>  create mode 100644 drivers/fpga/tests/Kconfig
>  create mode 100644 drivers/fpga/tests/Makefile
>  create mode 100644 drivers/fpga/tests/fake-fpga-bridge.c
>  create mode 100644 drivers/fpga/tests/fake-fpga-bridge.h
>  create mode 100644 drivers/fpga/tests/fake-fpga-mgr.c
>  create mode 100644 drivers/fpga/tests/fake-fpga-mgr.h
>  create mode 100644 drivers/fpga/tests/fake-fpga-region.c
>  create mode 100644 drivers/fpga/tests/fake-fpga-region.h
>  create mode 100644 drivers/fpga/tests/fpga-tests.c
>

