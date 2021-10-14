Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3B3342DEF3
	for <lists+linux-fpga@lfdr.de>; Thu, 14 Oct 2021 18:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbhJNQOw (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 14 Oct 2021 12:14:52 -0400
Received: from mail-dm6nam11on2087.outbound.protection.outlook.com ([40.107.223.87]:20609
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229823AbhJNQOw (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 14 Oct 2021 12:14:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HSVr8JxA/dGd1q00g+eGnM6oBT2inkfI7/wdIo/sLhCK7sj5PhmAISVoUWYVdrJEYby17W+tnm9uy3aOXqGBZOzDxJEBpl4WEEb+jQNV2J3NpzHxozLnh04+57ZQ1IL5SVwAMW6w9JZcm7rxkNXpqRguvjvjnNkXnoCvu/Ri/QrsCWUivhQUH2PnnWqIRah/gu4E4huXRxIssZlyhaoii3pos6814wn0Cc3VXXJu1q0zSyTHNu1wmUGkGefEYdgSr58XoAnES6INJlOhc69ztyR+St06MRaYlUIuBba83aH2DeiaYx/Lo5hEG3xjm7HK8a3zGejDeJYhN0nYTxetKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tXOGBo6GCBkLN8K9HSEmM647C80t/v9F5zxiU4sGsqs=;
 b=PQDkbghVly0IJ7b0jqAy2XT+HbmxCGX07SnkVkf5ptyuUiB1kaR0DqbQp84b6argJaPRaNiBpqrrnCEA6sy7yjiCw7UYwT9cv7aeUgDNgN3mC/hZlB3VGxbkM7aTK8Fxk9b1fAARsgM/0F60QsP0GQFWKsM0mqiCzkXuI2kKXaKlUVOipDHHjuoHCyZU5Lo4r1JpGMUwKVWepQu44Cj5KSRCcxp+prvSJBjQyb6e2smntSYylp1rDXnIGzd+KRTkFJkD6EBGjea6tI6ZgykCrY9wkaWohtI6v6uuocnNpmcQJBHCfOwIEx6GT/cukY1WUDKAWp32QWHCACP+FwX+cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=intel.com smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tXOGBo6GCBkLN8K9HSEmM647C80t/v9F5zxiU4sGsqs=;
 b=IIU5ZEqHuc9sK6NOydKTTmktGig0Mv2VAgA3jFm2MLpY7c6rhF2tT7qn8yy7PU0KrGFBAqTIvhO2LFF23i7hsTN3ZKltnr3PiXR67wpwhXBF72G0Kye2AecGScoDQBlNVYY+IYMBTzYMoOzrLrSKSTb3/lk0aEk1GyrZMZqUL3Q=
Received: from DM5PR16CA0020.namprd16.prod.outlook.com (2603:10b6:3:c0::30) by
 BL3PR02MB8186.namprd02.prod.outlook.com (2603:10b6:208:339::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.25; Thu, 14 Oct 2021 16:12:44 +0000
Received: from DM3NAM02FT052.eop-nam02.prod.protection.outlook.com
 (2603:10b6:3:c0:cafe::3f) by DM5PR16CA0020.outlook.office365.com
 (2603:10b6:3:c0::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend
 Transport; Thu, 14 Oct 2021 16:12:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT052.mail.protection.outlook.com (10.13.5.134) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Thu, 14 Oct 2021 16:12:44 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 14 Oct 2021 09:12:42 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 14 Oct 2021 09:12:42 -0700
Envelope-to: yilun.xu@intel.com,
 mdf@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 robh@kernel.org
Received: from [10.17.2.60] (port=37448)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1mb3LW-000Ewz-E6; Thu, 14 Oct 2021 09:12:42 -0700
Subject: Re: [PATCH V9 XRT Alveo 01/14] Documentation: fpga: Add a document
 describing XRT Alveo drivers
To:     <robh@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <mdf@kernel.org>,
        Max Zhen <max.zhen@xilinx.com>,
        Lizhi Hou <lizhi.hou@xilinx.com>, Xu Yilun <yilun.xu@intel.com>
References: <20210802160521.331031-1-lizhi.hou@xilinx.com>
 <20210802160521.331031-2-lizhi.hou@xilinx.com>
 <20211012050931.GA95330@yilunxu-OptiPlex-7050>
 <8d8f6c08-6e68-a4b8-4cfd-1dd547f3fe28@xilinx.com>
 <20211014022122.GG95330@yilunxu-OptiPlex-7050>
From:   Lizhi Hou <lizhi.hou@xilinx.com>
Message-ID: <cc261622-5104-39ae-7221-b33dd70303e5@xilinx.com>
Date:   Thu, 14 Oct 2021 09:12:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20211014022122.GG95330@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a718bf6-04c2-4b71-3c9b-08d98f2d749a
X-MS-TrafficTypeDiagnostic: BL3PR02MB8186:
X-Microsoft-Antispam-PRVS: <BL3PR02MB8186578D2A22621EC6E778C9A1B89@BL3PR02MB8186.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ERZH5WakSufjv0PAC/rQ/hHepgeYruONmu9vvAIXerf7i0F71KRtxU9iL9dqC3aBKxetRGE9J2aZjtwpX28faICrsJILRNlq1jzoHmQiltqtijFFRgmrbDKmBMVkrzOlOw6+0g2lsLk6dzDKj5Cr/TkbBCA3BJXEP+PY9xuIBkRKXYg2nrGeA2IS6m0ZcbXG7WWCa0mBCNT0Ej7dT1zqs3xkhTt4k1k+NXC2s7DD45wV2deAFStGa/nPb87oSE9YEWYwlSr3jYmczvFzghsADl5b5CWwZXTmmzL9iCZuL6QTxrLfWPzmg8QQ/IQHu5khsV+fqlm/v/s2tUkOxA+F/x+GYnt1U3L6KTPyhGkojzFp7HRvoS8/1e5B/9eH2cL/LmqNb16TTlGCltT1Xz3f2Hb0S9OUkns0wf5lZNMeBNvDrQncgjHRNtFpaTF742OXKCt68qOn8eRhARI7HRYqptUQAUDqYPzq3BzajKE5QeTMIe+u6jKBgaTeL2RNVwEPlCEIdCHkBl6RRwSj+QHbnj8ZF6DXHV6Wd3NbslQoqFgxcyuqtaSb3cxw1DjzKjcsg3Hg97CVJVKXBtpQHspIlOX4RRj7HOdXlIhRF73obcawVdy5J1I56/4N7S4PgGtH//saWfFo8pir+m0PWNi7D0B03ZxKZzhvpIBNJmRnUbK5o8zsidzRFLLpiogJ05EVsYE2nZ7Y36h3AVv1s/DbJmSE4Qo9Xapvc/Sz6UZ5tT4wenkDqtiz/eUH2tpJr4DjfGmwO/TeOTLvk+RHqMeIoATGcqbfxiZ74dj+7l33pTqn87ArGB2pOqiT+/y7hlVoWaxej9X7rz/+lNQn6uSPr9T3QD5cF26o+qrUsAknPKm6PBORHlDIPd5bUKRyBc7g
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(46966006)(36840700001)(356005)(508600001)(966005)(5660300002)(47076005)(8676002)(7636003)(31696002)(26005)(426003)(336012)(45080400002)(4326008)(70586007)(70206006)(53546011)(36756003)(6916009)(2616005)(9786002)(54906003)(82310400003)(31686004)(36906005)(2906002)(30864003)(83380400001)(186003)(36860700001)(44832011)(8936002)(316002)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2021 16:12:44.1281
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a718bf6-04c2-4b71-3c9b-08d98f2d749a
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT052.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB8186
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hello Rob,

Please help with the review of the proposed FDT usage by Alveo/XRT drivers.

Thanks,
Lizhi

On 10/13/21 7:21 PM, Xu Yilun wrote:
> CAUTION: This message has originated from an External Source. Please use proper judgment and caution when opening attachments, clicking links, or responding to this email.
>
>
>>>> +.. _device_tree_usage:
>>>> +
>>>> +Device Tree Usage
>>>> +-----------------
>>>> +
>>>> +The xsabin file stores metadata which advertise HW subsystems present in a
>>>> +partition. The metadata is stored in device tree format with a well defined
>>>> +schema. XRT management driver uses this information to bind *xrt_drivers* to
>>>> +the subsystem instantiations. The xrt_drivers are found in **xrt-lib.ko** kernel
>>>> +module.
>>> I'm still catching up the patchset from the very beginning, and just
>>> finished the Documentation part. So far, I see the DT usage concern
>>> which may impact the architecure a lot, so I should raise it ASAP.
>>>
>>> The concern raised by the DT maintainer:
>>> https://lore.kernel.org/linux-fpga/CAL_JsqLod6FBGFhu7WXtMrB_z7wj8-up0EetM1QS9M3gjm8d7Q@mail.gmail.com/
>>>
>>> First of all, directly parsing FDT in device drivers is not a normal usage of DT
>>> in linux. It is out of the current DT usage model. So it should be agreed by DT
>>> maintainers.
>> Thanks for reviewing XRT document and providing feedback.
>> Here is the reply from Sonal for Rob’s question:
>> https://lore.kernel.org/linux-fpga/BY5PR02MB62604B87C66A1AD139A6F153BBF40@BY5PR02MB6260.namprd02.prod.outlook.com/
>> Overall, libfdt is used by XRT driver to parse the metadata which comes with
>> an Alveo board.
>> When XRT driver discovers an Alveo board, it will read a fdt blob from board
>> firmware file resident on the host.
>> By parsing the fdt blob, XRT driver gets information about this Alveo board,
>> such as version, uuid, IPs exposed to PCI BAR, interrupt binding etc.
>> So libfdt is used simply as Alveo metadata parser here. XRT drivers do not
>> interact with system wide DT or present the Alveo device tree to host. For
>> many systems like x86_64, system wide DT is not present but libfdt parsing
>> services will still be needed.
> Yes, I understand the use case.
>
> My concern is, directly parsing an isolated FDT in device driver and
> populate sub devices, skipping the unflattening, this is a new working
> model of device tree usage, but for the same purpose as the existing
> one.
>
> So I really need the confirmation of DT maintainers.
>
>>> Current FPGA framework modifies kernel's live tree by DT overlay, when FPGA is
>>> dynamically reprogrammed and new HW devices appear. See
>>> Documentation/devicetree/bindings/fpga/fpga-region.txt.
>>>
>>> Then something less important:
>>>
>>>     1. The bindings should be documented in Documentation/devicetree/bindings/.
>>>     2. Are all the example DT usage conform to the exsiting bindings? I
>>>        didn't go through all device classes, but remember like the
>>>        interrupt-controller should have a "interrupt-controller" property, and
>>>        the PCI properties are also different from PCI bindings.
>> The fdt properties are defined for Alveo firmware files. XRT driver is the
>> only consumer of this data. I am wondering if
> Personally I don't like the idea of a different binding definition set,
> even if the new device tree usage is accepted. We all use device tree
> for device enumeration, so why the different definitions.
>
> Thanks,
> Yilun
>
>> Documentation/devicetree/bindings is the right place for Alveo/XRT private
>> format or should it be documented as part of XRT driver documentation?
>> Looking for guidance here.
>>
>>
>> Thanks,
>>
>> Lizhi
>>
>>> Thanks,
>>> Yilun
>>>
>>>> +
>>>> +Logic UUID
>>>> +^^^^^^^^^^
>>>> +A partition is identified uniquely through ``logic_uuid`` property::
>>>> +
>>>> +  /dts-v1/;
>>>> +  / {
>>>> +      logic_uuid = "0123456789abcdef0123456789abcdef";
>>>> +      ...
>>>> +    }
>>>> +
>>>> +Schema Version
>>>> +^^^^^^^^^^^^^^
>>>> +Schema version is defined through the ``schema_version`` node. It contains
>>>> +``major`` and ``minor`` properties as below::
>>>> +
>>>> +  /dts-v1/;
>>>> +  / {
>>>> +       schema_version {
>>>> +           major = <0x01>;
>>>> +           minor = <0x00>;
>>>> +       };
>>>> +       ...
>>>> +    }
>>>> +
>>>> +.. _partition_uuids:
>>>> +
>>>> +Partition UUIDs
>>>> +^^^^^^^^^^^^^^^
>>>> +Each partition may have parent and child UUIDs. These UUIDs are
>>>> +defined by ``interfaces`` node and ``interface_uuid`` property::
>>>> +
>>>> +  /dts-v1/;
>>>> +  / {
>>>> +       interfaces {
>>>> +           @0 {
>>>> +                  interface_uuid = "0123456789abcdef0123456789abcdef";
>>>> +           };
>>>> +           @1 {
>>>> +                  interface_uuid = "fedcba9876543210fedcba9876543210";
>>>> +           };
>>>> +           ...
>>>> +        };
>>>> +       ...
>>>> +    }
>>>> +
>>>> +
>>>> +Subsystem Instantiations
>>>> +^^^^^^^^^^^^^^^^^^^^^^^^
>>>> +Subsystem instantiations are captured as children of ``addressable_endpoints``
>>>> +node::
>>>> +
>>>> +  /dts-v1/;
>>>> +  / {
>>>> +       addressable_endpoints {
>>>> +           abc {
>>>> +               ...
>>>> +           };
>>>> +           def {
>>>> +               ...
>>>> +           };
>>>> +           ...
>>>> +       }
>>>> +  }
>>>> +
>>>> +Subnode 'abc' and 'def' are the name of subsystem nodes
>>>> +
>>>> +Subsystem Node
>>>> +^^^^^^^^^^^^^^
>>>> +Each subsystem node and its properties define a hardware instance::
>>>> +
>>>> +
>>>> +  addressable_endpoints {
>>>> +      abc {
>>>> +          reg = <0x00 0x1f05000 0x00 0x1000>>
>>>> +          pcie_physical_function = <0x0>;
>>>> +          pcie_bar_mapping = <0x2>;
>>>> +          compatible = "abc def";
>>>> +          interrupts = <0x09 0x0c>;
>>>> +          firmware {
>>>> +              firmware_product_name = "abc"
>>>> +              firmware_branch_name = "def"
>>>> +              firmware_version_major = <1>
>>>> +              firmware_version_minor = <2>
>>>> +          };
>>>> +      }
>>>> +      ...
>>>> +  }
>>>> +
>>>> +:reg:
>>>> + Property defines an address range. `<0x00 0x1f05000 0x00 0x1000>` indicates
>>>> + *0x00 0x1f05000* as BAR offset and *0x00 0x1000* as address length.
>>>> +:pcie_physical_function:
>>>> + Property specifies which PCIe physical function the subsystem node resides.
>>>> + `<0x0>` implies physical function 0.
>>>> +:pcie_bar_mapping:
>>>> + Property specifies which PCIe BAR the subsystem node resides. `<0x2>` implies
>>>> + BAR 2. A value of 0 means the property is not defined.
>>>> +:compatible:
>>>> + Property is a list of strings. The first string in the list specifies the exact
>>>> + subsystem node. The following strings represent other devices that the device
>>>> + is compatible with.
>>>> +:interrupts:
>>>> + Property specifies start and end interrupts for this subsystem node.
>>>> + `<0x09 0x0c>` implies interrupts 9 to 13 are used by this subsystem.
>>>> +:firmware:
>>>> + Subnode defines the firmware required by this subsystem node.
>>>> +
>>>> +Alveo U50 Platform Example
>>>> +^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>> +::
>>>> +
>>>> +  /dts-v1/;
>>>> +
>>>> +  /{
>>>> +        logic_uuid = "f465b0a3ae8c64f619bc150384ace69b";
>>>> +
>>>> +        schema_version {
>>>> +                major = <0x01>;
>>>> +                minor = <0x00>;
>>>> +        };
>>>> +
>>>> +        interfaces {
>>>> +
>>>> +                @0 {
>>>> +                        interface_uuid = "862c7020a250293e32036f19956669e5";
>>>> +                };
>>>> +        };
>>>> +
>>>> +        addressable_endpoints {
>>>> +
>>>> +                ep_blp_rom_00 {
>>>> +                        reg = <0x00 0x1f04000 0x00 0x1000>;
>>>> +                        pcie_physical_function = <0x00>;
>>>> +                        compatible = "xilinx.com,reg_abs-axi_bram_ctrl-1.0\0axi_bram_ctrl";
>>>> +                };
>>>> +
>>>> +                ep_card_flash_program_00 {
>>>> +                        reg = <0x00 0x1f06000 0x00 0x1000>;
>>>> +                        pcie_physical_function = <0x00>;
>>>> +                        compatible = "xilinx.com,reg_abs-axi_quad_spi-1.0\0axi_quad_spi";
>>>> +                        interrupts = <0x03 0x03>;
>>>> +                };
>>>> +
>>>> +                ep_cmc_firmware_mem_00 {
>>>> +                        reg = <0x00 0x1e20000 0x00 0x20000>;
>>>> +                        pcie_physical_function = <0x00>;
>>>> +                        compatible = "xilinx.com,reg_abs-axi_bram_ctrl-1.0\0axi_bram_ctrl";
>>>> +
>>>> +                        firmware {
>>>> +                                firmware_product_name = "cmc";
>>>> +                                firmware_branch_name = "u50";
>>>> +                                firmware_version_major = <0x01>;
>>>> +                                firmware_version_minor = <0x00>;
>>>> +                        };
>>>> +                };
>>>> +
>>>> +                ep_cmc_intc_00 {
>>>> +                        reg = <0x00 0x1e03000 0x00 0x1000>;
>>>> +                        pcie_physical_function = <0x00>;
>>>> +                        compatible = "xilinx.com,reg_abs-axi_intc-1.0\0axi_intc";
>>>> +                        interrupts = <0x04 0x04>;
>>>> +                };
>>>> +
>>>> +                ep_cmc_mutex_00 {
>>>> +                        reg = <0x00 0x1e02000 0x00 0x1000>;
>>>> +                        pcie_physical_function = <0x00>;
>>>> +                        compatible = "xilinx.com,reg_abs-axi_gpio-1.0\0axi_gpio";
>>>> +                };
>>>> +
>>>> +                ep_cmc_regmap_00 {
>>>> +                        reg = <0x00 0x1e08000 0x00 0x2000>;
>>>> +                        pcie_physical_function = <0x00>;
>>>> +                        compatible = "xilinx.com,reg_abs-axi_bram_ctrl-1.0\0axi_bram_ctrl";
>>>> +
>>>> +                        firmware {
>>>> +                                firmware_product_name = "sc-fw";
>>>> +                                firmware_branch_name = "u50";
>>>> +                                firmware_version_major = <0x05>;
>>>> +                        };
>>>> +                };
>>>> +
>>>> +                ep_cmc_reset_00 {
>>>> +                        reg = <0x00 0x1e01000 0x00 0x1000>;
>>>> +                        pcie_physical_function = <0x00>;
>>>> +                        compatible = "xilinx.com,reg_abs-axi_gpio-1.0\0axi_gpio";
>>>> +                };
>>>> +
>>>> +                ep_ddr_mem_calib_00 {
>>>> +                        reg = <0x00 0x63000 0x00 0x1000>;
>>>> +                        pcie_physical_function = <0x00>;
>>>> +                        compatible = "xilinx.com,reg_abs-axi_gpio-1.0\0axi_gpio";
>>>> +                };
>>>> +
>>>> +                ep_debug_bscan_mgmt_00 {
>>>> +                        reg = <0x00 0x1e90000 0x00 0x10000>;
>>>> +                        pcie_physical_function = <0x00>;
>>>> +                        compatible = "xilinx.com,reg_abs-debug_bridge-1.0\0debug_bridge";
>>>> +                };
>>>> +
>>>> +                ep_ert_base_address_00 {
>>>> +                        reg = <0x00 0x21000 0x00 0x1000>;
>>>> +                        pcie_physical_function = <0x00>;
>>>> +                        compatible = "xilinx.com,reg_abs-axi_gpio-1.0\0axi_gpio";
>>>> +                };
>>>> +
>>>> +                ep_ert_command_queue_mgmt_00 {
>>>> +                        reg = <0x00 0x40000 0x00 0x10000>;
>>>> +                        pcie_physical_function = <0x00>;
>>>> +                        compatible = "xilinx.com,reg_abs-ert_command_queue-1.0\0ert_command_queue";
>>>> +                };
>>>> +
>>>> +                ep_ert_command_queue_user_00 {
>>>> +                        reg = <0x00 0x40000 0x00 0x10000>;
>>>> +                        pcie_physical_function = <0x01>;
>>>> +                        compatible = "xilinx.com,reg_abs-ert_command_queue-1.0\0ert_command_queue";
>>>> +                };
>>>> +
>>>> +                ep_ert_firmware_mem_00 {
>>>> +                        reg = <0x00 0x30000 0x00 0x8000>;
>>>> +                        pcie_physical_function = <0x00>;
>>>> +                        compatible = "xilinx.com,reg_abs-axi_bram_ctrl-1.0\0axi_bram_ctrl";
>>>> +
>>>> +                        firmware {
>>>> +                                firmware_product_name = "ert";
>>>> +                                firmware_branch_name = "v20";
>>>> +                                firmware_version_major = <0x01>;
>>>> +                        };
>>>> +                };
>>>> +
>>>> +                ep_ert_intc_00 {
>>>> +                        reg = <0x00 0x23000 0x00 0x1000>;
>>>> +                        pcie_physical_function = <0x00>;
>>>> +                        compatible = "xilinx.com,reg_abs-axi_intc-1.0\0axi_intc";
>>>> +                        interrupts = <0x05 0x05>;
>>>> +                };
>>>> +
>>>> +                ep_ert_reset_00 {
>>>> +                        reg = <0x00 0x22000 0x00 0x1000>;
>>>> +                        pcie_physical_function = <0x00>;
>>>> +                        compatible = "xilinx.com,reg_abs-axi_gpio-1.0\0axi_gpio";
>>>> +                };
>>>> +
>>>> +                ep_ert_sched_00 {
>>>> +                        reg = <0x00 0x50000 0x00 0x1000>;
>>>> +                        pcie_physical_function = <0x01>;
>>>> +                        compatible = "xilinx.com,reg_abs-ert_sched-1.0\0ert_sched";
>>>> +                        interrupts = <0x09 0x0c>;
>>>> +                };
>>>> +
>>>> +                ep_fpga_configuration_00 {
>>>> +                        reg = <0x00 0x1e88000 0x00 0x8000>;
>>>> +                        pcie_physical_function = <0x00>;
>>>> +                        compatible = "xilinx.com,reg_abs-axi_hwicap-1.0\0axi_hwicap";
>>>> +                        interrupts = <0x02 0x02>;
>>>> +                };
>>>> +
>>>> +                ep_icap_reset_00 {
>>>> +                        reg = <0x00 0x1f07000 0x00 0x1000>;
>>>> +                        pcie_physical_function = <0x00>;
>>>> +                        compatible = "xilinx.com,reg_abs-axi_gpio-1.0\0axi_gpio";
>>>> +                };
>>>> +
>>>> +                ep_msix_00 {
>>>> +                        reg = <0x00 0x00 0x00 0x20000>;
>>>> +                        pcie_physical_function = <0x00>;
>>>> +                        compatible = "xilinx.com,reg_abs-msix-1.0\0msix";
>>>> +                        pcie_bar_mapping = <0x02>;
>>>> +                };
>>>> +
>>>> +                ep_pcie_link_mon_00 {
>>>> +                        reg = <0x00 0x1f05000 0x00 0x1000>;
>>>> +                        pcie_physical_function = <0x00>;
>>>> +                        compatible = "xilinx.com,reg_abs-axi_gpio-1.0\0axi_gpio";
>>>> +                };
>>>> +
>>>> +                ep_pr_isolate_plp_00 {
>>>> +                        reg = <0x00 0x1f01000 0x00 0x1000>;
>>>> +                        pcie_physical_function = <0x00>;
>>>> +                        compatible = "xilinx.com,reg_abs-axi_gpio-1.0\0axi_gpio";
>>>> +                };
>>>> +
>>>> +                ep_pr_isolate_ulp_00 {
>>>> +                        reg = <0x00 0x1000 0x00 0x1000>;
>>>> +                        pcie_physical_function = <0x00>;
>>>> +                        compatible = "xilinx.com,reg_abs-axi_gpio-1.0\0axi_gpio";
>>>> +                };
>>>> +
>>>> +                ep_uuid_rom_00 {
>>>> +                        reg = <0x00 0x64000 0x00 0x1000>;
>>>> +                        pcie_physical_function = <0x00>;
>>>> +                        compatible = "xilinx.com,reg_abs-axi_bram_ctrl-1.0\0axi_bram_ctrl";
>>>> +                };
>>>> +
>>>> +                ep_xdma_00 {
>>>> +                        reg = <0x00 0x00 0x00 0x10000>;
>>>> +                        pcie_physical_function = <0x01>;
>>>> +                        compatible = "xilinx.com,reg_abs-xdma-1.0\0xdma";
>>>> +                        pcie_bar_mapping = <0x02>;
>>>> +                };
>>>> +        };
>>>> +
>>>> +  }
>>>> +
>>>> +
>>>> +
>>>> +Deployment Models
>>>> +=================
>>>> +
>>>> +Baremetal
>>>> +---------
>>>> +
>>>> +In bare-metal deployments, both MPF and UPF are visible and accessible. The
>>>> +xrt-mgmt driver binds to MPF. The xrt-mgmt driver operations are privileged and
>>>> +available to system administrator. The full stack is illustrated below::
>>>> +
>>>> +                            HOST
>>>> +
>>>> +               [XRT-MGMT]         [XRT-USER]
>>>> +                    |                  |
>>>> +                    |                  |
>>>> +                 +-----+            +-----+
>>>> +                 | MPF |            | UPF |
>>>> +                 |     |            |     |
>>>> +                 | PF0 |            | PF1 |
>>>> +                 +--+--+            +--+--+
>>>> +          ......... ^................. ^..........
>>>> +                    |                  |
>>>> +                    |   PCIe DEVICE    |
>>>> +                    |                  |
>>>> +                 +--+------------------+--+
>>>> +                 |         SHELL          |
>>>> +                 |                        |
>>>> +                 +------------------------+
>>>> +                 |         USER           |
>>>> +                 |                        |
>>>> +                 |                        |
>>>> +                 |                        |
>>>> +                 |                        |
>>>> +                 +------------------------+
>>>> +
>>>> +
>>>> +
>>>> +Virtualized
>>>> +-----------
>>>> +
>>>> +In virtualized deployments, the privileged MPF is assigned to the host but the
>>>> +unprivileged UPF is assigned to a guest VM via PCIe pass-through. The xrt-mgmt
>>>> +driver in host binds to MPF. The xrt-mgmt driver operations are privileged and
>>>> +only accessible to the MPF. The full stack is illustrated below::
>>>> +
>>>> +
>>>> +                                 ..............
>>>> +                  HOST           .    VM      .
>>>> +                                 .            .
>>>> +               [XRT-MGMT]        . [XRT-USER] .
>>>> +                    |            .     |      .
>>>> +                    |            .     |      .
>>>> +                 +-----+         .  +-----+   .
>>>> +                 | MPF |         .  | UPF |   .
>>>> +                 |     |         .  |     |   .
>>>> +                 | PF0 |         .  | PF1 |   .
>>>> +                 +--+--+         .  +--+--+   .
>>>> +          ......... ^................. ^..........
>>>> +                    |                  |
>>>> +                    |   PCIe DEVICE    |
>>>> +                    |                  |
>>>> +                 +--+------------------+--+
>>>> +                 |         SHELL          |
>>>> +                 |                        |
>>>> +                 +------------------------+
>>>> +                 |         USER           |
>>>> +                 |                        |
>>>> +                 |                        |
>>>> +                 |                        |
>>>> +                 |                        |
>>>> +                 +------------------------+
>>>> +
>>>> +
>>>> +
>>>> +
>>>> +
>>>> +Platform Security Considerations
>>>> +================================
>>>> +
>>>> +`Security of Alveo Platform <https://xilinx.github.io/XRT/master/html/security.html>`_
>>>> +discusses the deployment options and security implications in great detail.
>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>> index 056966c9aac9..beeaf0257364 100644
>>>> --- a/MAINTAINERS
>>>> +++ b/MAINTAINERS
>>>> @@ -7274,6 +7274,17 @@ F:     Documentation/fpga/
>>>>    F:   drivers/fpga/
>>>>    F:   include/linux/fpga/
>>>>
>>>> +FPGA XRT DRIVERS
>>>> +M:   Lizhi Hou <lizhi.hou@xilinx.com>
>>>> +R:   Max Zhen <max.zhen@xilinx.com>
>>>> +R:   Sonal Santan <sonal.santan@xilinx.com>
>>>> +L:   linux-fpga@vger.kernel.org
>>>> +S:   Supported
>>>> +W:   https://github.com/Xilinx/XRT
>>>> +F:   Documentation/fpga/xrt.rst
>>>> +F:   drivers/fpga/xrt/
>>>> +F:   include/uapi/linux/xrt/
>>>> +
>>>>    FPU EMULATOR
>>>>    M:   Bill Metzenthen <billm@melbpc.org.au>
>>>>    S:   Maintained
>>>> --
>>>> 2.27.0
