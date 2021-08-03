Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FCA93DF517
	for <lists+linux-fpga@lfdr.de>; Tue,  3 Aug 2021 21:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238837AbhHCTCm (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 3 Aug 2021 15:02:42 -0400
Received: from mga03.intel.com ([134.134.136.65]:9039 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238764AbhHCTCm (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 3 Aug 2021 15:02:42 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10065"; a="213792094"
X-IronPort-AV: E=Sophos;i="5.84,292,1620716400"; 
   d="scan'208";a="213792094"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2021 12:02:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,292,1620716400"; 
   d="scan'208";a="670616386"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga005.fm.intel.com with ESMTP; 03 Aug 2021 12:02:29 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Tue, 3 Aug 2021 12:02:29 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Tue, 3 Aug 2021 12:02:28 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Tue, 3 Aug 2021 12:02:28 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.102)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Tue, 3 Aug 2021 12:02:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iHS0vGiLOlrAuNx0gwu+RdcHLIZMMMd5Dda+a9kIkXSPMXoG4uOGAvm9ZSDVfzVhp7qo2aw4tZsc/RekU0BK8KuvH+hGPd9+oWVE9ilHTWchXgXB7N/htNO8/Z3CjKG7r6RynKqpeTXUCqmdWS18DdJsClyF8vIzpwsftxjdmKZ2IIsInk8hijidCMpR1+GqVUN19RAJsPkKad7AeAg1X50AQvEp5U5glJ28HFlg42FHuiKMGZOLqV6JsciB2hFniqLd39hAd5Lu4bZ/6WzkhvrKBTEWk4Dd6LdT4QIz2UKefi04iINJFyf4aD0lJ06jZTn9h4YD8jbUKJrBAAM5mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OgrlDoKRqQ38KLCHFlT0n6M/kJwyZzmas9ZTwznBYTw=;
 b=UQm/n+/aP6OEArjSMDye2LyT+Htl2RuZ166D1XhKz24SBA5QFOUwuMs1ZReaxgpAbx8XNhyz+MgL63mn8rP503gt0+3PHLXZyMN8tsdQe55Tm+jbfAUbHvxqUBzZekmiI/xrjqpglhqm1zo3qD0dmzcORObP1CjY7y9Cxiz9/Qw6rsSaKwVxvurN77poNCzpE39qqmHx3cYeOcWzfvqMzqhqXU2Y5tLLA4eIpX3Yi9cEpex2b31oAdAW96RT9VeCinDzeZiRCrLtrxEso/RntSTxMMLoE12coBKBtcHmyfpCha3hQLqvjeFIH1dl3IFl45mvaUdoLglJpRB4hjM3QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OgrlDoKRqQ38KLCHFlT0n6M/kJwyZzmas9ZTwznBYTw=;
 b=o2jjVQzsVjzIFCh0s0V1XFSvFUkJdJhqG+467VLeLHg/RiIjzxJPt2sYgT/wlT0Zg9O80XDarPFLnri0qW7FzLaAOX+rpIDc626Fds7ZCJkc9UwNtdNTsB5FEVPZoV4Xfo/vKHTGRgD4MJy/Il6s8RrilMiiOottUZSZ2diphyE=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=intel.com;
Received: from SA2PR11MB5163.namprd11.prod.outlook.com (2603:10b6:806:113::20)
 by SA0PR11MB4670.namprd11.prod.outlook.com (2603:10b6:806:9a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15; Tue, 3 Aug
 2021 19:02:27 +0000
Received: from SA2PR11MB5163.namprd11.prod.outlook.com
 ([fe80::51db:698d:e2e3:7fc8]) by SA2PR11MB5163.namprd11.prod.outlook.com
 ([fe80::51db:698d:e2e3:7fc8%4]) with mapi id 15.20.4373.026; Tue, 3 Aug 2021
 19:02:27 +0000
From:   Russ Weight <russell.h.weight@intel.com>
Subject: Re: [PATCH 02/12] fpga: sec-mgr: enable secure updates
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>,
        <linux-fpga@vger.kernel.org>, <moritzf@google.com>
References: <20210517023200.52707-1-mdf@kernel.org>
 <20210517023200.52707-3-mdf@kernel.org> <YKH/6xQ7bEwJzEsM@kroah.com>
 <5d0552ce-d2bd-cca1-006e-8f11991fd378@intel.com>
 <f3d474d2-f85d-4759-75b5-84af64fe5b3c@intel.com> <YQPgFn/z024U06HJ@kroah.com>
 <85cd4801-ca1f-4482-6999-3d2e648b24e5@intel.com> <YQjY+KL59m51kucV@kroah.com>
Message-ID: <3ba35b3c-3c85-394b-f404-130968587a6f@intel.com>
Date:   Tue, 3 Aug 2021 12:02:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.11.0
In-Reply-To: <YQjY+KL59m51kucV@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: MWHPR2201CA0055.namprd22.prod.outlook.com
 (2603:10b6:301:16::29) To SA2PR11MB5163.namprd11.prod.outlook.com
 (2603:10b6:806:113::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.2.4] (50.43.42.212) by MWHPR2201CA0055.namprd22.prod.outlook.com (2603:10b6:301:16::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend Transport; Tue, 3 Aug 2021 19:02:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb74ef54-dcf6-4075-6de9-08d956b13c6e
X-MS-TrafficTypeDiagnostic: SA0PR11MB4670:
X-Microsoft-Antispam-PRVS: <SA0PR11MB4670A6C4E5604DA827CCA92EC5F09@SA0PR11MB4670.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2TNZII4TzFXKxubCt48TYf4V7fi+qz+z2hmOuOOm1SGMR7uEtZ6Ho4V22GvH6Z2wwF7AR7w5R5ukjPp2p9qCll/wdNcIbiQ35rtCTaC11vjUO1cs7P2M2wX9qdbYm5r4FwpNGgWIDcxGKpswQfpU9yVH9TGAugbkYWJhtnIPfsHRUGB0431gwd0J7Ajz8G/P/SKKYnpNp9gnf5OhAeZ6M0o0FZtR6baEvmIQBBy2Inc95jxswpYCdsqujkWdPC8WZDIpLkgAx8hJuq/1NCNPfKstZsq+k6Nv/5V6+YwTAXiVkevdo1EpaN1gFgBp1jg9gNMN6u+ZpgG6zEO9DjxWtZjNUr/b6RLKUk/iwK74BKdX3j+Nwkt4hX+D1qRmCz4NeDxxg3hjOucoqHhPa6Njh2wHx+7gXKvcRrbQvKWnSaTVJqQpLGlLiRLqhoZOjfFdcXXVods3k0HY2zBghZMTpYqQWaaZW4X/grgQszYwwp44qLgif6eJRroqfeaUJw73iZU7PkQRZwyMRq/z9LqlDpSLAR5NBP1e5OxSKa1OVD9+4plLEcqD6hvKt8Zhl10qfPB9uomjAn11xEwBT1xa/TEkDPTvGJcjNx6qynrMb1hEb9D98Biq/wsmenAk99xReDrx3kV5RiuN8c2lJMbE6KLT6u28x0DbNzGIM4yA0ID9syDW72RSUtWPvHtS6o207SZyQH3D6yP3dGV2QKzmSj8s6Y51dxBNVDDH0JF58WakwVNFBBsEuZlBgP8L/HZS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB5163.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(136003)(346002)(39860400002)(376002)(15650500001)(54906003)(316002)(16576012)(956004)(478600001)(8676002)(26005)(186003)(86362001)(5660300002)(66946007)(2616005)(8936002)(31696002)(66556008)(66476007)(38100700002)(83380400001)(53546011)(6916009)(2906002)(6486002)(31686004)(4326008)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0lGYUgrRGtSZTMxR2hGSkQzS2tMUXdvZW9qZFAzNnhJcVdjS0p6bEpoTHRh?=
 =?utf-8?B?Q2Vjdy9NKzRXUW5KN1N4aTFNd1BycVVtdVI0dWlBR3VvL2Vhc3FVN3JnYnJr?=
 =?utf-8?B?WUpUaDRrZEFIU0RRUHkxNWdxN0VGWmI0M3RNQXhMM21IdmFsN056RVc5WjhP?=
 =?utf-8?B?ZkVSaHh6SXNDdVJIZjZNZ2d4dVBqR3hpMWpzbVNnMkRmTjZCeWxDNWU1N20z?=
 =?utf-8?B?b0dVMXZoY3RYeVowNFFpc01xWWF4MGprRWttVnFqck1MV2xpYkRFRnpLRzBQ?=
 =?utf-8?B?SzBwTGkwQWlQd282QjJ5ZnhFSVM4TGUzeEVPQlRFcEQreXRXditvT0wwb3li?=
 =?utf-8?B?SFp5VkoyN2lCOVpFNzUwTHZ4VnkwS0t5MHZOYmk1MmpXMFJ6VTNWSEJXSDZP?=
 =?utf-8?B?WDlBUkQrQVZVZHgvRnRpTEk3RVljRy96d1dJNXNpdTRjUjhDcktiS09YWS9Y?=
 =?utf-8?B?d2hhVDM5dGRHSUd3QTFLUkg4S0tEVzh3V1RwWTVKZ1ZWbjViL3R2YUpCRDNa?=
 =?utf-8?B?WUZmTVI2YW05TVdVYzVpeUp1bTJ4N3I2NjVrQmRQNExEZUdRc1o4bUltTGJY?=
 =?utf-8?B?M1pLSThiRFJhcXpJY1VsNkIrR0NGcGRRRlpiWlErQUY5QWpXOE5oNTdpcnFw?=
 =?utf-8?B?TmRXcWVacXVxVTNiM29FTFp0aFAwVnRUT2JFVmR2eEExaFNFSU5kczZOeisx?=
 =?utf-8?B?cU5TbWNnNHdJZTJtRTE2TVR2Z1RaVTN3VGxmcEp2R3d3RXRsdDZBb1dVRkdR?=
 =?utf-8?B?UTNsRnk4SGtkUWpzWW9aVXhCb0lhaW03aWNGWVlHSXlvMm9aMmVJM1VEajRm?=
 =?utf-8?B?dE80VzNxTG5nZWhucUhkTU91UnhLVzVBRkc3V2ROdTgvMm5BVHRGN0lTWXNI?=
 =?utf-8?B?Skh3N0d0WENwazNiVnljWHRIV0p5dDBIVzJ2Q1VOM1BCUTdPL2VQVTM3Y2cr?=
 =?utf-8?B?RXB0WFZoSWhFb0R0anR5WkhDc0dlUFhZd2poZGFCdEhDcXVkVS9xZVZzMkFi?=
 =?utf-8?B?dDhZQUZTQmxtMTNOY2dYMmtNQnEzVXVMaGpLY1UwSWpQS2RvOWM1c2lUS25D?=
 =?utf-8?B?SHY2NE93SnNFaEJnTXJTWWhBelZWbjFIVlpZeEVTMmd2YlZHSHhXampVdGQr?=
 =?utf-8?B?YjFva1JtWGNwaEVNOUptc3ZIVHlUNUJWemU4NVZxNTNGWEtUeS9mN3plS2VD?=
 =?utf-8?B?ODI0WS9yZlBySGVTa0FobW1uVWVxQk04dnBvM1FMK1J3TGpNYUhCM3U4MGp5?=
 =?utf-8?B?WWl4U1FCYktRUTJnQ2IzclBwNS9RTFlLZjI0dDVjaE0vMC8rVWFXNkMyN2tI?=
 =?utf-8?B?WDlXN1c1Q282WUU2V2RqVEJhb0lzMnRzOWJuQkREWEhhTUpHUmxQWi9Iaysz?=
 =?utf-8?B?WkcvK1FPVitseVh4dWtXa0VDMmpZZEcvdXZISFMzTmVDUitmaVNzZXlBYUxt?=
 =?utf-8?B?ZVd1M3ZIUlk3Mm8zTmVFbHFWWjdBQ1NLb1kvS2E5Q1NraXFGMTF1NDNWZ1VJ?=
 =?utf-8?B?SlZOc2xjaDkyMEFielFsSXRWZ2FHMHVwZll1RVRzQ1JnQmZiVEVzSG9nTURV?=
 =?utf-8?B?MkdOYklTSXpESDJhZFhCSjA0aGlxQ0Y3cUVvcXR0dThQTGNSNGdMdjRpbzla?=
 =?utf-8?B?a3B3WDJCeURVRitwV21KVE96S2ZvZENPNnBldXlBTVVjK053THJxYWtRQXVs?=
 =?utf-8?B?SlhvTk4rVDA2OXM3c09ISWo5aWYyK0ZoSG9aZ0dsM05Rb094NUQrTXFPMHY2?=
 =?utf-8?Q?dUsJDmyggzIoj4H7ZiQc3yJRJ4skpQRF/efsELP?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eb74ef54-dcf6-4075-6de9-08d956b13c6e
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB5163.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2021 19:02:27.3960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yXBBDNAmuYxa8MDJTua+sDyARSS11xXxJ0K2CaUUJcYFjVGNPTDjG7t8gIxgcKW/1MzMyDU7T3coNGKsIzWjlhP0zHYBnJLKXzVtSKg5Wx8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4670
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 8/2/21 10:49 PM, Greg KH wrote:
>> If the request_firmware() implementation is not acceptable, then would
>> you agree that an IOCTL implementation is our best option?
> There is no difference in the end between using an ioctl, or a sysfs
> file, to provide the filename of your firmware, don't get hung up on
> that.

I meant to suggest that passing file data (not a filename) through an
IOCTL might be better for this use case than trying to use request_firmware.
We have to, somehow, allow the user to point us to the desired image
data (which could be a root-entry-hash, or an FPGA image). We can't
really use a fixed filename modified by device version as many of
the devices do.

> By providing a "filename", you are going around all of the namespace and
> other "container" protection that the kernel provides, and allowing
> processes to potentially load files that are normally outside of their
> scope to the hardware.  If you are willing to allow that security
> "escape", wonderful, but you better document the heck out of it and
> explain why this is allowed for your special hardware and use case.
>
> As you are expecting this to work "in the cloud", I do not think that
> the operators of such hardware are really going to be all that happy to
> see this type of interface given these reasons.
>
> What is wrong with the current fpga firmware api that somehow is lacking
> for your special hardware, that other devices do not have to worry
> about?
The existing framework wants to update the live image in the FPGA,
whereas for this device, we are passing signed data to BMC firmware
which will store it in FLASH to be loaded on a subsequent boot of
the card.

The existing framework needs to manage FPGA state, whereas for this
device, it is just a transfer of signed data. We also have to handle
a total transfer/authentication time of up to 45 minutes, so we are
using a kernel worker thread for the update.

Perhaps the name, fpga security manager, is wrong? Maybe something
like fpga_sec_image_xfer is better?

- Russ
> thanks,
>
> greg k-h

