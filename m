Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3109B42AAA7
	for <lists+linux-fpga@lfdr.de>; Tue, 12 Oct 2021 19:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbhJLRYO (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 12 Oct 2021 13:24:14 -0400
Received: from mga01.intel.com ([192.55.52.88]:32801 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229510AbhJLRYM (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 12 Oct 2021 13:24:12 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10135"; a="250619338"
X-IronPort-AV: E=Sophos;i="5.85,368,1624345200"; 
   d="scan'208";a="250619338"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2021 10:20:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,368,1624345200"; 
   d="scan'208";a="591848925"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga004.jf.intel.com with ESMTP; 12 Oct 2021 10:20:16 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 12 Oct 2021 10:20:16 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 12 Oct 2021 10:20:15 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Tue, 12 Oct 2021 10:20:15 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Tue, 12 Oct 2021 10:20:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jEsaIrBBeqYcor0vtW6gNZIcCZQs+XI+VQyMXSflok5iMtFE0ocGsXG1s6x5LaJivd1a1kA6QXBBRiGfXtQFjTv7gIRvrS7UyUcJbFR97q+zbMShFuIQaNkgQLSxmOrsC+TnhK4OsyJyxTdiiiWxhlWrZ0iD+FXR6bxg8yPPNBF9v5UAPLjAHU9GcAWNf264fgrxZNsas1OrUcxjRjKw/jwX2SB48+c9PldZHUwoBV4buHkXe6NFz9Nj8C9B+jbJzJhwpoJzglCy4ZFUIZcZNjlJyBIMXcuyY/nGLGYPhRDKCkI9twvIMuN2HY2bzWZI40CO6on7uZb8RZYPzO8LEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5GDBruBgBwhsbiZo7mOkuWshC8Tpv68k2mW/f3doUPU=;
 b=N/q5gcdVJ8xF353nTJK52HW5N0iKcXQPlNfUtsrzGxfE5UwFEZmomiSJS9VHTGKd+TxRUlRfOFYRJeFcUVjfdYI1FJMX1nGQ+bi8GVP2q1KTmiSCeEmt6SCNOJ4O8hoDMOSFtlv+Wqv938PZY3cULhnczKOo0egGbMvq9opPSWWXdCsDs+/YOZ3eMky4992Ny1tXiJ5L5xDXfQXOR4QuKSkInI5d+SC8varIp8nmdULtKks/VkCCxJxdFe6VMBLKwh8IW4KlUPqgAV1zPEJZhI58B4f1zMytdDbcUfIUBDkW/aPEvQUbVDlzAlI/rm+F29oOMKNYkO1jmkTWuTE7ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5GDBruBgBwhsbiZo7mOkuWshC8Tpv68k2mW/f3doUPU=;
 b=Dx71Oo8DzNjsZy9NsTi16vDEJECv1jE/RwMnnmITuucQgu5xNzcSgjqGwpBCVgYuvyNxWTAZIO0r5DtIC+ohuxr/wLtHjqPgevtViSlQensFowU6arK0Qk37y1boZV6BN1+C8vGYPMZOs94nTsJ/1Numc0UEcfLvRmhjzfHJu44=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
Received: from SA2PR11MB5163.namprd11.prod.outlook.com (2603:10b6:806:113::20)
 by SA2PR11MB5193.namprd11.prod.outlook.com (2603:10b6:806:fa::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Tue, 12 Oct
 2021 17:20:13 +0000
Received: from SA2PR11MB5163.namprd11.prod.outlook.com
 ([fe80::a039:c121:4dce:5def]) by SA2PR11MB5163.namprd11.prod.outlook.com
 ([fe80::a039:c121:4dce:5def%8]) with mapi id 15.20.4587.026; Tue, 12 Oct 2021
 17:20:12 +0000
Subject: Re: [PATCH v17 0/5] FPGA Image Load (previously Security Manager)
To:     Xu Yilun <yilun.xu@intel.com>
CC:     Tom Rix <trix@redhat.com>, <mdf@kernel.org>,
        <linux-fpga@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lgoncalv@redhat.com>, <hao.wu@intel.com>,
        <matthew.gerlach@intel.com>
References: <20210929230025.68961-1-russell.h.weight@intel.com>
 <20211009080859.GA85181@yilunxu-OptiPlex-7050>
 <450ed897-f726-9671-26b7-2a24bb046e89@redhat.com>
 <20211011014154.GA82360@yilunxu-OptiPlex-7050>
 <79350773-3629-2734-21c0-0314a762e722@redhat.com>
 <336e4827-b09a-e1ab-b67d-d8755012d71c@intel.com>
 <20211012074752.GB95330@yilunxu-OptiPlex-7050>
From:   Russ Weight <russell.h.weight@intel.com>
Message-ID: <e629eca0-a86c-4028-7bbf-65185699137b@intel.com>
Date:   Tue, 12 Oct 2021 10:20:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
In-Reply-To: <20211012074752.GB95330@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: MWHPR19CA0049.namprd19.prod.outlook.com
 (2603:10b6:300:94::11) To SA2PR11MB5163.namprd11.prod.outlook.com
 (2603:10b6:806:113::20)
MIME-Version: 1.0
Received: from [10.0.2.4] (50.43.42.212) by MWHPR19CA0049.namprd19.prod.outlook.com (2603:10b6:300:94::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend Transport; Tue, 12 Oct 2021 17:20:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a1b2bdc-6aab-45ac-8d2b-08d98da48cd0
X-MS-TrafficTypeDiagnostic: SA2PR11MB5193:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA2PR11MB5193DB1B6460005E28825BACC5B69@SA2PR11MB5193.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xq+F/NYGml5wVWH1iWKICrZ9QSK+5J8DPBLa1+lgAXS4oQeJCvU4M85YYBG8zw174AaYvwwsKMs+8IvDKG48UL/25Iu7fJXyIZT+1NW3Y9ocG/xoFaYMhjMoxg/psQ/yuIDzGmFJwFwoaqbB/LXdHvumXO3LLKsfbCVY6IuHJhi1w5jIqPuck3/BAdEK67C29VWpk94MaeRbJaqOeHNdiC8QRnMBwpgX5wKNqK7+I6PvU34ApYXL2NtWcM9EU3EiJ0n5ck7OUcyXCPPCTs/aDsQ3QcSeMllm7he+GyxinKKqg0aDt5/ygN4pL99Hazae3G0w7TiWm5IY88EvpncSikwk6soJOVqnSLmotXWIAuFDEExCalUtrzPNHYdCBvl98yDGvfnBy0G5uOOJrpNBXUAlG6BM6+AlDQyMsniFRdgotm89DsYO1W0Ml2Ln1k233Q5RX8Uo3iqJRmkwU8YSuwHrosrUYvF3UCY8n0bS52YnGYtJLoXfrNHqsPTAhlTRaDnt8eBEsmhWcPwYEnRiEQ87xdC/4Ajo+CeXKBqguIvNM+ei9jT6hvpYBF032BiO2c4Wf52ML3gi/dDkqE9PrlCCO6N5nQXHaY9JOFrPhLnREZL0JB+mvIuuHbWOK7tqLdrqISPNjtFAWj2ZfzdoAvmf/GWIcNV+PUf3oQG6A0rOOQmQUFdMtFwKcvDIHKRyWz28qDbOXhDHrVKmF4hRWcD1AP0c79mzSnZrg8TpaKjoWxJN9fPZp65j5U5dky4C8dE4sXUdJNRX+p5u8YWMj7f+4Eaaz+a/eKWzaECO98vZCsrAVol2Yt29TtVyMcwvAU31n/irmyH7USweUEa8Bo8yyrLMh64Y/W3vCjDcgvY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB5163.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(26005)(37006003)(15650500001)(316002)(186003)(16576012)(5660300002)(8676002)(966005)(38100700002)(6486002)(6862004)(31686004)(107886003)(508600001)(36756003)(2616005)(4326008)(83380400001)(8936002)(86362001)(66946007)(66556008)(956004)(53546011)(6636002)(66476007)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OW95VDFTaU55ZE56bDdyWmlPMDlUVGVXaU9iVGNLTFduT1dLYXZERTVXSVJ4?=
 =?utf-8?B?OWQ1UXVTREFQcUlOd3hlRjdjb0dJclNhWExPUllTMmdzUHk4b3FoYVBJWkM3?=
 =?utf-8?B?TGZ1Y0I4c2ZneXF5dWFrRjBWL1M2KzFQL2MvMHRPcWNvdGk5WTN5bXJxcmtQ?=
 =?utf-8?B?aW5BUXZTWUpEMzliSW5VbkVTRFYrSjFRbHZibXdLTnlIbEV5emFWVmZuRDU4?=
 =?utf-8?B?WFcyQnFPbHVRMFZ4MnFGd0pvNWd3M3BmYVhIdlphQ2pNeWxybFpMb3dKVjlx?=
 =?utf-8?B?Sk5LcU1PR3hYaXliUGhaalFHdmtvQTRTNXR5N2FaVTFrZjFIN2s1THUvazgz?=
 =?utf-8?B?QStRRXhUeGVvR28xOHBiRjdhSURpZndzZlJMMkMwTERWVFB4TmtzS2g5Smdv?=
 =?utf-8?B?MytFMDJaNDhNYkZDMGc4L1ZwLzRubUFhcVZ5TUdzb0hhSnA3MFdHZVRNZytS?=
 =?utf-8?B?OExiMW1RL0lONUFubkkrcnMza0tIL3lxSXNWcmttbnozTFAyNWxFVml0SDRj?=
 =?utf-8?B?M2RZS3MvOUhPSFNjMi9KV21YSHdvSndacUtWZEpZejA5SHFXYThqamtSa2J2?=
 =?utf-8?B?UXRtOUI3OXBob2treTJiOUVyeWwzY01HMGxtcjlkczdwWTdnYkVycVlYUDky?=
 =?utf-8?B?SDMveEhoeWUzY3JOZDlKblEyREVHOEZmM1RKSnlCcGFGU0RGdzU3UndxTk5O?=
 =?utf-8?B?ZmRNQWNkVjFHK1F2N1Yra201MDZBQjkwUXN3RU1RamdkMzE3aWFZTnh0eDhD?=
 =?utf-8?B?YTJPSkFPd3paeDhzeW1aV2w1ZG9pWmJiczllR2RVWS9LNzZJQlJ3QjIySnYv?=
 =?utf-8?B?SWhkTXIxbDZDRnE3MHJCbngvSFNBR2FLRGtCU1RvSG5xVFRFc2tvb2xjRjE5?=
 =?utf-8?B?UG5HQ3ZLNlpVNHVPMHNvTldQM1k0K2ttOWpCNEVnN2diV1NCdmNOVUtFKyti?=
 =?utf-8?B?akVjQWVXbStZOFpHUjN4VXBkQ2V1V2xtcVJERk9keFphYktQUFloZmhYOVlz?=
 =?utf-8?B?UHVLai9NZkFkKzZvOU1zaFk3K21EazhRZzdueHlqYjdOK1FiV2NMTytnSFQx?=
 =?utf-8?B?ZE9GZXM4MGpEQnQ4SE9zWGtOcWkzaTVndXpDRzBtZGM5WUczS0c2TlNBOEdq?=
 =?utf-8?B?ZHVtYmEzWXFPaDN3UEZDYVRnelpvR0ZROVRpdElVZWJEaUxvM2JjZ3E4ZENu?=
 =?utf-8?B?cTAxcXVHbmdkUDlyUXd1SzVkKzlCUDJWTTVpOWtFS1NkcWFyU3o0WmpZb2NL?=
 =?utf-8?B?S2tyTFEvWkR0UzhZand2a1BreG5BemZNUktFbm96NlhBQUpLK1VNOHhWMllB?=
 =?utf-8?B?WEx1TjYzdyttTmJVdi9jWHFva0pIZWlPWEl4cWpPd0dWWHNsL0JDVldScnFT?=
 =?utf-8?B?emczZk9XQjZtR1R4L3RpMzRvUEE2ek9rOXF3anYwU1BpUWlvbTRvK2hwR3cz?=
 =?utf-8?B?Y3B4bXdDVzhRTmMxeGpTUFdpYm9yOTNMbTNNVmcxMkNMVDhEK0VaeUhVaTlF?=
 =?utf-8?B?czJsRWZqOEVGUHJ3SUJabzhEcElKaW9xbWxsb1d5cTAyNm1jd0hpNnU1OFRR?=
 =?utf-8?B?SzRqQW02RzRra0p1TktWS2tacVFjMXB6bG1mYTBaVldPMzN4bk5lUi9TYTBu?=
 =?utf-8?B?K3pwMWRZNEg3djNxZjhIamovZ3V3NGtYS0RRaU9HaTAyOHNTT0tUVHFoQzdD?=
 =?utf-8?B?Qy9ZcU5yL002bVdZakh3cHNyUFFJMUN5NWxLRVpYaWZ4YWN2TWQxa2FJYzFE?=
 =?utf-8?Q?4jJagkmZaXaa8bjZZ0A27Wqd/8lzRROxZfhUT2t?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a1b2bdc-6aab-45ac-8d2b-08d98da48cd0
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB5163.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2021 17:20:12.7730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kj3D/4IMJxdMVfjMaHJYbjvkwJ97+Ay49Og8GAH/Yzy6s0t61lEhaxrMg8DblYezjwFX9lWiipMtHh9Zs4RfYzDQeSy9RFWy1Y2Hk4b7CwA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5193
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 10/12/21 12:47 AM, Xu Yilun wrote:
> On Mon, Oct 11, 2021 at 06:00:16PM -0700, Russ Weight wrote:
>>
>> On 10/11/21 5:35 AM, Tom Rix wrote:
>>> On 10/10/21 6:41 PM, Xu Yilun wrote:
>>>> On Sat, Oct 09, 2021 at 05:11:20AM -0700, Tom Rix wrote:
>>>>> On 10/9/21 1:08 AM, Xu Yilun wrote:
>>>>>> On Wed, Sep 29, 2021 at 04:00:20PM -0700, Russ Weight wrote:
>>>>>>> The FPGA Image Load framework provides an API to upload image
>>>>>>> files to an FPGA device. Image files are self-describing. They could
>>>>>>> contain FPGA images, BMC images, Root Entry Hashes, or other device
>>>>>>> specific files. It is up to the lower-level device driver and the
>>>>>>> target device to authenticate and disposition the file data.
>>>>>> I've reconsider the FPGA persistent image update again, and think we
>>>>>> may include it in FPGA manager framework.
>>>>>>
>>>>>> Sorry I raised this topic again when it is already at patch v17, but now
>>>>>> I need to consider more seriously than before.
>>>>>>
>>>>>> We have consensus the FPGA persistent image update is just like a normal
>>>>>> firmware update which finally writes the nvmem like flash or eeprom,
>>>>>> while the current FPGA manager deals with the active FPGA region update
>>>>>> and re-activation. Could we just expand the FPGA manager and let it handle
>>>>>> the nvmem update as well? Many FPGA cards have nvmem and downloaders
>>>>>> supports updating both FPGA region and nvmem.
>> The fpga-image-load driver is actually just a data transfer. The class
> IMHO, The fpga-mgr dev is also a data transfer. The fpga-region dev is
> acting as the FPGA region admin responsible for gating, transfering and
> re-enumerating.
>
> So my opinion is to add a new data transfer type and keep a unified process.
>
>> driver has no knowledge about what the data is or where/if the data will
>> be stored.
> The fpga-image-load driver knows the data will be stored in nvmem,
FYI: This is not strictly correct. In a coming product there is a
case where the data will be stored in RAM. Richard Gong was also
looking to use this driver to validate an image without programming
or storing it. The fpga-image-load driver has no expectation that
the data will be stored in nvmem, or even that it will be stored
at all.

> while
> the fpga-mgr knows the data will be stored in FPGA cells. They may need
> to know the exact physical position to store, may not, depends on what the
> HW engines are.
>
>> This functionality could, of course, be merged into the fpga-mgr. I did
>> a proof of concept of this a while back and we discussed the pros and cons.
>> See this email for a recap:
>>
>> https://marc.info/?l=linux-fpga&m=161998085507374&w=2
>>
>> Things have changed some with the evolution of the driver. The IOCTL
>> approach probably fits better than the sysfs implementation. At the time
>> it seemed that a merge would add unnecessary complexity without adding value.
> I think at least developers don't have to go through 2 sets of software
> stacks which are of the same concept. And adding some new features like
> optionally threading or canceling data transfer are also good to FPGA
> region update. And the nvmem update could also be benifit from exsiting
> implementations like scatter-gather buffers, in-kernel firmware loading.
>
> I try to explain myself according to each of your concern from that mail
> thread:
>
> Purpose of the 2 updates
> ========================
>
>   As I said before, I think they are both data transfer devices. FPGA
> region update gets extra support from fpga-region & fpga-bridge, and
> FPGA nvmem update could be a standalone fpga-mgr.
>
> Extra APIs that are unique to nvmem update
> ==========================================
>
>   cdev APIs for nvmem update:
>     Yes we need to expand the functionality so we need them.
>
>   available_images, image_load APIs for loading nvmem content to FPGA
>   region:
>     These are features in later patchsets which are not submitted, but we
>     could talk about it in advance. I think this is actually a FPGA region
>     update from nvmem, it also requires gating, data loading (no SW transfer)
>     and re-enumeration, or a single command to image_load HW may result system
>     disordered. The FPGA framework now only supports update from in-kernel
>     user data, maybe we add support for update from nvmem later.
>
>   fpga-mgr state extend:
>     I think it could be extended, The current states are not perfect,
>     adding something like IDLE or READY is just fine.
>
>   fpga-mgr status extend:
>     Add general error definitions as needed. If there is some status
>     that is quite vendor specific, expose it in low-level driver.
>
>   remaining-size:
>     Nice to have for all.
>
> Threading the update
> ====================
>
>   Also a good option for FPGA region update, maybe we also have a slow FPGA
>   reprogrammer?
>
> Cancelling the update
> ====================
>
>   Also a good option for FPGA region update if HW engine supports.
These are all good points.

Thanks,
- Russ
>
> Thanks,
> Yilun
>
>>>>>> According to the patchset, the basic workflow of the 2 update types are
>>>>>> quite similar, get the data, prepare for the HW, write and complete.
>>>>>> They are already implemented in FPGA manager. We've discussed some
>>>>>> differences like threading or canceling the update, which are
>>>>>> not provided by FPGA manager but they may also nice to have for FPGA
>>>>>> region update. An FPGA region update may also last for a long time??
>>>>>> So I think having 2 sets of similar frameworks in FPGA is unnecessary.
>>>>>>
>>>>>> My quick mind is that we add some flags in struct fpga_mgr & struct
>>>>>> fpga_image_info to indicate the HW capability (support FPGA region
>>>>>> update or nvmem update or both) of the download engine and the provided
>>>>>> image type. Then the low-level driver knows how to download if it
>>>>>> supports both image types.An char device could be added for each fpga manager dev, providing the
>>>>>> user APIs for nvmem update. We may not use the char dev for FPGA region
>>>>>> update cause it changes the system HW devices and needs device hotplug
>>>>>> in FPGA region. We'd better leave it to FPGA region class, this is
>>>>>> another topic.
>> I'll give this some more thought and see if I can come up with some RFC
>> patches.
>>
>> - Russ
>>>>>> More discussion is appreciated.
>>>>> I also think fpga_mgr could be extended.
>>>>>
>>>>> In this patchset,
>>>>>
>>>>> https://lore.kernel.org/linux-fpga/20210625195849.837976-1-trix@redhat.com/
>>>>>
>>>>> A second, similar set of write ops was added to fpga_manger_ops,
>>>>>
>>>>> new bit/flag was added to fpga_image_info
>>>>>
>>>>> The intent was for dfl to add their specific ops to cover what is done in
>>>>> this patchset.
>>>> I think we don't have to add 2 ops for reconfig & reimage in framework,
>>>> the 2 processes are almost the same.
>>>>
>>>> Just add the _REIMAGE (or something else, NVMEM?) flag for
>>>> fpga_image_info, and low level drivers handle it as they do for other
>>>> flags.
>>>>
>>>> How do you think?
>>> A single set is fine.
>>>
>>> A difficult part of is the length of  time to do the write. The existing write should be improved to use a worker thread.
>>>
>>> Tom
>>>
>>>> Thanks,
>>>> Yilun
>>>>
>>>>> Any other driver would do similar.
>>>>>
>>>>> Is this close to what you are thinking ?
>>>>>
>>>>> Tom
>>>>>
>>>>>> Thanks,
>>>>>> Yilun
>>>>>>

