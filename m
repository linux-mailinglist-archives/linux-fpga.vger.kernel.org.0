Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78F7B3B1931
	for <lists+linux-fpga@lfdr.de>; Wed, 23 Jun 2021 13:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbhFWLqX (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 23 Jun 2021 07:46:23 -0400
Received: from mail-eopbgr150097.outbound.protection.outlook.com ([40.107.15.97]:49543
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230071AbhFWLqW (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 23 Jun 2021 07:46:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MPlI7EE3e5rF1LAQmUEeB6gDWAcvgfSiJeRnAl78LTvZULV1KzCwdbKDKeXJ07oJX6W8TIUF6Q0dxVzJ/NKKb+YoZpQ3n7+4AI0cZ8jmQS/a8eJRZ8+WYbQ2XDB0YuAJTc1PQCZASk+pXh9+JIKMJlo4623ZN1yZBPn2E1XvejhxMT9xd1Py+44O+ps22wiKCxzcmcqefyyUa/Mcu7SCggE8D9J8I1xLw3nlExsfZUM3yg8R1LTJjiOirPE4EAqvVCZT83nDokeyLT6dAwoosf8ArUK+PMqMjZnZtdloD4foyZGc2jzXpuL/CdxlJaMX9xy4MFGz8R42wvRlRrqKpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FavaVzVQZv9eKmUuf0yOn/+Dt/jcvndz4ltLhQcbp9U=;
 b=MBOA8zIM0jQ4WxhK6DTOtt9GnULgvayxf46q0jOpr5Ov+3XcvOmfSCPPtt2c9jejmq4DzGsvpabzhyy3KRrTSbx+1jLvrGccHWoXXVlquMf9eUb7BQ8CXvJZd7QT011RRuLgTGQqUbu/otHVDy2A3eyqNhNTMQZLBmvKCzN/mGY9+R8rkg92h9l7phiE0pSu1QQE+in2WNJy9bO77sCvnn+5VJjaqcJTa554rpBYoTM3G5d+tDACEj9ig01svwgN1OSPmZVE3AT3uxxlJXZQJFAEmETvlO+K06nLReo9i8v+HyERDfghRHpypShbpQTBGNwaZx3YIUVMGEZNtx+b+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silicom.dk; dmarc=pass action=none header.from=silicom.dk;
 dkim=pass header.d=silicom.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=SILICOMLTD.onmicrosoft.com; s=selector2-SILICOMLTD-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FavaVzVQZv9eKmUuf0yOn/+Dt/jcvndz4ltLhQcbp9U=;
 b=rEQ+LyQI6QnoOZPk0iy85nRCT8Hkyj8IfgcRGFewh8XX1NNmtCTjPBzn+LtabcE9U/UX/o7eZKtUQj5E5oFFUBdolCi0TKs/BvkV6GObxjd3gDLjJgQoI74wGr+aUsR7zMZz85yU52YqToXaFdvLdPBatikIA8tu0P7S7mwDoHI=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=silicom.dk;
Received: from AM0PR0402MB3426.eurprd04.prod.outlook.com
 (2603:10a6:208:22::15) by AM8PR04MB7347.eurprd04.prod.outlook.com
 (2603:10a6:20b:1d0::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Wed, 23 Jun
 2021 11:44:03 +0000
Received: from AM0PR0402MB3426.eurprd04.prod.outlook.com
 ([fe80::50fd:f133:3592:292e]) by AM0PR0402MB3426.eurprd04.prod.outlook.com
 ([fe80::50fd:f133:3592:292e%7]) with mapi id 15.20.4242.023; Wed, 23 Jun 2021
 11:44:03 +0000
Subject: Re: [PATCH 2/4] fpga: dfl: Move DFH header register macros to
 linux/dfl.h
To:     Tom Rix <trix@redhat.com>, Wu Hao <hao.wu@intel.com>,
        Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>
Cc:     =?UTF-8?Q?Martin_Hundeb=c3=b8ll?= <mhu@geanix.com>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-spi@vger.kernel.org,
        Debarati Biswas <debaratix.biswas@intel.com>,
        Russ Weight <russell.h.weight@intel.com>
References: <20210621070621.431482-1-mhu@silicom.dk>
 <20210621070621.431482-3-mhu@silicom.dk>
 <81975a85-e9d6-bd4b-7666-56d1d1d581bc@redhat.com>
From:   =?UTF-8?Q?Martin_Hundeb=c3=b8ll?= <mhu@silicom.dk>
Message-ID: <7c6021cc-69c5-7c3f-9e37-30c933535835@silicom.dk>
Date:   Wed, 23 Jun 2021 13:44:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <81975a85-e9d6-bd4b-7666-56d1d1d581bc@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 8bit
X-Originating-IP: [185.17.218.86]
X-ClientProxiedBy: AM5PR1001CA0017.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:206:2::30) To AM0PR0402MB3426.eurprd04.prod.outlook.com
 (2603:10a6:208:22::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.64.70] (185.17.218.86) by AM5PR1001CA0017.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:206:2::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18 via Frontend Transport; Wed, 23 Jun 2021 11:44:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f2e0478-d7e1-477b-1b86-08d9363c32d6
X-MS-TrafficTypeDiagnostic: AM8PR04MB7347:
X-Microsoft-Antispam-PRVS: <AM8PR04MB7347AEACB62E419715C73CC1D5089@AM8PR04MB7347.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GVD/tn9sNQqzYzdHuUAOih96QCpdLdjaGVix86kpVAHBAcEb06rsulFJkcUgzrriTcFpPuk3C7yXXWAYNx+4vGNnmk6jUEcRy1BT8WSKF/NSGIahAdakPyBcbCwDwFFdIb0Ytaw2uMLuojVxmgIT6EZ733zbDLJKngGkfShGNIkoiODZwLSB/cQAdTfG1tswX4TPuK14M5B9hiuSUIabn+zpbQUSyJ1MM7lWNP0EWsH7ZSOsbbWwGtJyYrp2muzvj+TWsZndnWT8edCfd9rlZ0SHVSRIwfEq1lYB3wj3ZnG4t/cjwW5ka8gPnZMy6XlQLCYqb/P+wT5wV0oVQq8nYZRqkmHgIPCghL5rVIzR4YwlEnnJbJ7xTPhoKcCBGzjNDuN9W6cv0ipIUp7yifVe5EIfwtsj+XJCVoPmUeSCdllnf4Slu4kkb6B4+DQCq+tYXpNgRIzy0/XQtaMNiVMKwAdQJD5jf77c0SxA0fb2nPrMxFspVY4nFvkoUAfsAOqNHzmKvtyMARsJhpAmL/4YkvNHDAVk0Zfk8KPywQC34T1fnIGkBVPpJ0xB74aERFnzA5PK0kt7ogK6Pg2UHmPN/xFaEJwEOENlTcFZABq6DsI5SE9cWvLzXTAXPW73/gg3XBXP+wKJXgfN9teoZjrpNKDKdE21SWGuEgOCDTYv9d067PwknbW05Wr/MfTyLA1B
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3426.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(136003)(376002)(366004)(39850400004)(2906002)(6486002)(31686004)(53546011)(66476007)(66556008)(4326008)(66946007)(26005)(36756003)(5660300002)(186003)(110136005)(16576012)(54906003)(316002)(38100700002)(66574015)(8676002)(478600001)(956004)(2616005)(7416002)(8936002)(8976002)(83380400001)(16526019)(31696002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGNqZnRVR2xORU5HYkh5dlNkTHlqYnQ2b29hbkxuSUhZb0tSaERiaktTQ1Y3?=
 =?utf-8?B?dHp5dmJaZFBtYmRNM3R5eUUrVm1RbGhrQTRXMUF2TkNPdldsQVpFNGZnUlRF?=
 =?utf-8?B?K1B2UVhvU21JRUx2ZlNPMjhKdUlkTk1jNWJEOU9EK3U3QkJyK25OdkI2M3dk?=
 =?utf-8?B?Uk9YSmM4ZWx0aEFHNVJDUGtDNXVyR3Bxalc0ek1XTG1mU1NkTVZjUDF1eGh6?=
 =?utf-8?B?ZDVyOXpJbTVtQUVNQ1V0M2F2VlVQWlVtVFhtTlNFUm9kMDg3Vm9IY3F5bkZ6?=
 =?utf-8?B?OFJhbVlrY0oyRm55dXF6aDZJMDRsMTVEVnNCeHBlMExnQzQzTXkreG8yUXpN?=
 =?utf-8?B?RWkzZ05INDlTeUpWT2RhR0RER28zdUdkckRkVGs2RHJqRkkxKzdIQUZ1UFJH?=
 =?utf-8?B?dkF0YUV0QVREUGdwb2FEZGxsNnA3NzNpOG1MaG9ZaEJNMUlNbXY4RHFiWi9w?=
 =?utf-8?B?K1NmVElrSWF3YmcrNVVrcjhLRHdsc0phV21WQk1iVEFNNjJYb0NWSy9BZTFr?=
 =?utf-8?B?b053d1Z3U1ZEeWxRS0hTcFNkQk5zT1ZWNVdoS1hocXJzRUg0MFRydWEydUYv?=
 =?utf-8?B?aWFtOGU5VlA5VE1TSDFmWjR1MVpRdUpiY2dOangzMWtKQ2RPZDM1cFFCSERv?=
 =?utf-8?B?WHYxdGo1bTRGT0lkS0RCV214WXAxckZ2ZG5qWXRzQnErWndEMXlmeG1pQytU?=
 =?utf-8?B?QXNZdUlka3hLaTEvbVlNQTIxWCs3dHhqbktVclFhdENrSW9RSjNOc0lBcysv?=
 =?utf-8?B?VGhUSVE3a2ZkMlp4R3dmZ0xiYkU2WE9wd2VCS3dkOXltUWZpZEIzL2JkL1A4?=
 =?utf-8?B?V1ZvRCtZVmVRSjVWY3ZWdi9QTWJ4aS9uQXNERlk2MWIzWW4xaUZtdFBtSlgr?=
 =?utf-8?B?aTg0eVRUY1FQSm5tcmhqZHR5Wm5YNk1rMzRxa1YvUEoxSzBPK0RWeGs3ZmZF?=
 =?utf-8?B?MVY5R0Yxd0N2YlN4M0xtV3VUYWgyV1UrVG54MEJDNklBeEtNd1B4M2NHakRl?=
 =?utf-8?B?MHI3MlJ6RlV6Q1NWL2JPbERQZG0zMVFvV1k0VEZka285VDViK3E1cTRYQkUr?=
 =?utf-8?B?K3QvSW9uYXF3b0pXbjZyU1BpaGMycFdTT2ZoWnErMnNzL1RGV3R6TkoxcGJZ?=
 =?utf-8?B?cXhNOWJWcWluVlkrQmVYdUVSQm9aeUlqNTdSTkppUDRzRFgyMSt6R25lNnMz?=
 =?utf-8?B?NUdicXExS3hQSG5naE53NTI5dGhFME9tZzR6VlZnc09MNjFUMUorOURkTlgy?=
 =?utf-8?B?RlpjSEt0NDBOTnNDeU91RE9FSE9mMHBPNmEyZk1BMkpFc2JMTTh1UjdXaGxC?=
 =?utf-8?B?SEtueGQ0b0VQam9vc3FWYklhaGtSOUdWOEMvaDRvUFBxVEhPNTFiSnpWMm5X?=
 =?utf-8?B?MlZXT3dEb0ZESXpMVVRVMzU0WEdzMzlIUGp1d29hRFZ5cmQzdHpxd01KUXBv?=
 =?utf-8?B?aU5QcEN4eVFuYWNHWHFPOVZXbVIxRi9vcENnNzVqcU1OWE9iSEoyOGtjbTZD?=
 =?utf-8?B?d3hCdHFNOUhwUi9La2hXZkJhUlRRVUZpQ1REeVEvVFJTR1BtbWNVZ1hIQ3Nq?=
 =?utf-8?B?Wlc3cElncU1BRmxCQ0M3S1V3MmY1MG5ESnh4Z2VpYnZzOE5scHQ2aXEvdjRq?=
 =?utf-8?B?aEVSblIxdnpzV0IwcEVVTzd4a0g4MHNQN2pyRFpMWHFHWnFJc1RBU1JxeElj?=
 =?utf-8?B?TmR2alpibXM5S0R0TUFmSEJ0UEE2UFBWMkp3YXZEN29ISzE2YW1GRkpMMU9E?=
 =?utf-8?Q?qVnl/0mNURct/DzzHPtjsTarwpfEoynf9dUM9ZA?=
X-OriginatorOrg: silicom.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f2e0478-d7e1-477b-1b86-08d9363c32d6
X-MS-Exchange-CrossTenant-AuthSource: AM0PR0402MB3426.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2021 11:44:02.9845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c9e326d8-ce47-4930-8612-cc99d3c87ad1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: seH3ZVAnmGJaCzDzKb4K7vdIselbxKhBbynldFJK2rGQPoVJWKzcAjGNvoPYAYAt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7347
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 21/06/2021 15.56, Tom Rix wrote:
> 
> On 6/21/21 12:06 AM, Martin Hundebøll wrote:
>> From: Debarati Biswas <debaratix.biswas@intel.com>
>>
>> Device Feature List (DFL) drivers may be defined in subdirectories other
>> than drivers/fpga, and each DFL driver should have access to the Device
>> Feature Header (DFH) register, which contains revision and type
>> information. This change moves the macros specific to the DFH register
>> from drivers/fpga/dfl.h to include/linux/dfl.h.
>>
>> Signed-off-by: Debarati Biswas <debaratix.biswas@intel.com>
>> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
>> Signed-off-by: Martin Hundebøll <mhu@silicom.dk>
>> ---
>>   drivers/fpga/dfl.h  | 48 +----------------------------------------
>>   include/linux/dfl.h | 52 +++++++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 53 insertions(+), 47 deletions(-)
>>
>> diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
>> index 2b82c96ba56c..6ed0353e9a99 100644
>> --- a/drivers/fpga/dfl.h
>> +++ b/drivers/fpga/dfl.h
>> @@ -17,6 +17,7 @@
>>   #include <linux/bitfield.h>
> 
> bitfield.h was added to linux/dfl.h
> 
> Likely both aren't needed, try removing this one.

After this patch both headers use GENMASK_ULL() and BIT_ULL(), which are both defined in linux/bits.h, so I would expect both to include that instead. A lot of the users of dfl.h uses FIELD_GET(), which is defined in linux/bitfield.h, so I would expect that to be included there instead.

I can prepare a patch to fix that up, if you like?

// Martin
