Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F08042D05F
	for <lists+linux-fpga@lfdr.de>; Thu, 14 Oct 2021 04:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbhJNC3z (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 13 Oct 2021 22:29:55 -0400
Received: from mga18.intel.com ([134.134.136.126]:59564 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229496AbhJNC3z (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 13 Oct 2021 22:29:55 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10136"; a="214525331"
X-IronPort-AV: E=Sophos;i="5.85,371,1624345200"; 
   d="scan'208";a="214525331"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2021 19:27:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,371,1624345200"; 
   d="scan'208";a="441904632"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.162])
  by orsmga006.jf.intel.com with ESMTP; 13 Oct 2021 19:27:47 -0700
Date:   Thu, 14 Oct 2021 10:21:22 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Lizhi Hou <lizhi.hou@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
        maxz@xilinx.com, sonal.santan@xilinx.com, yliu@xilinx.com,
        michal.simek@xilinx.com, stefanos@xilinx.com,
        devicetree@vger.kernel.org, trix@redhat.com, mdf@kernel.org,
        robh@kernel.org, Max Zhen <max.zhen@xilinx.com>
Subject: Re: [PATCH V9 XRT Alveo 01/14] Documentation: fpga: Add a document
  describing XRT Alveo drivers
Message-ID: <20211014022122.GG95330@yilunxu-OptiPlex-7050>
References: <20210802160521.331031-1-lizhi.hou@xilinx.com>
 <20210802160521.331031-2-lizhi.hou@xilinx.com>
 <20211012050931.GA95330@yilunxu-OptiPlex-7050>
 <8d8f6c08-6e68-a4b8-4cfd-1dd547f3fe28@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8d8f6c08-6e68-a4b8-4cfd-1dd547f3fe28@xilinx.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> > > +.. _device_tree_usage:
> > > +
> > > +Device Tree Usage
> > > +-----------------
> > > +
> > > +The xsabin file stores metadata which advertise HW subsystems present in a
> > > +partition. The metadata is stored in device tree format with a well defined
> > > +schema. XRT management driver uses this information to bind *xrt_drivers* to
> > > +the subsystem instantiations. The xrt_drivers are found in **xrt-lib.ko** kernel
> > > +module.
> > I'm still catching up the patchset from the very beginning, and just
> > finished the Documentation part. So far, I see the DT usage concern
> > which may impact the architecure a lot, so I should raise it ASAP.
> > 
> > The concern raised by the DT maintainer:
> > https://lore.kernel.org/linux-fpga/CAL_JsqLod6FBGFhu7WXtMrB_z7wj8-up0EetM1QS9M3gjm8d7Q@mail.gmail.com/
> > 
> > First of all, directly parsing FDT in device drivers is not a normal usage of DT
> > in linux. It is out of the current DT usage model. So it should be agreed by DT
> > maintainers.
> Thanks for reviewing XRT document and providing feedback.
> Here is the reply from Sonal for Rob’s question:
> https://lore.kernel.org/linux-fpga/BY5PR02MB62604B87C66A1AD139A6F153BBF40@BY5PR02MB6260.namprd02.prod.outlook.com/
> Overall, libfdt is used by XRT driver to parse the metadata which comes with
> an Alveo board.
> When XRT driver discovers an Alveo board, it will read a fdt blob from board
> firmware file resident on the host.
> By parsing the fdt blob, XRT driver gets information about this Alveo board,
> such as version, uuid, IPs exposed to PCI BAR, interrupt binding etc.
> So libfdt is used simply as Alveo metadata parser here. XRT drivers do not
> interact with system wide DT or present the Alveo device tree to host. For
> many systems like x86_64, system wide DT is not present but libfdt parsing
> services will still be needed.

Yes, I understand the use case.

My concern is, directly parsing an isolated FDT in device driver and
populate sub devices, skipping the unflattening, this is a new working
model of device tree usage, but for the same purpose as the existing
one.

So I really need the confirmation of DT maintainers.

> > 
> > Current FPGA framework modifies kernel's live tree by DT overlay, when FPGA is
> > dynamically reprogrammed and new HW devices appear. See
> > Documentation/devicetree/bindings/fpga/fpga-region.txt.
> > 
> > Then something less important:
> > 
> >    1. The bindings should be documented in Documentation/devicetree/bindings/.
> >    2. Are all the example DT usage conform to the exsiting bindings? I
> >       didn't go through all device classes, but remember like the
> >       interrupt-controller should have a "interrupt-controller" property, and
> >       the PCI properties are also different from PCI bindings.
> 
> The fdt properties are defined for Alveo firmware files. XRT driver is the
> only consumer of this data. I am wondering if

Personally I don't like the idea of a different binding definition set,
even if the new device tree usage is accepted. We all use device tree
for device enumeration, so why the different definitions.

Thanks,
Yilun

> Documentation/devicetree/bindings is the right place for Alveo/XRT private
> format or should it be documented as part of XRT driver documentation?
> Looking for guidance here.
> 
> 
> Thanks,
> 
> Lizhi
> 
> > 
> > Thanks,
> > Yilun
> > 
> > > +
> > > +Logic UUID
> > > +^^^^^^^^^^
> > > +A partition is identified uniquely through ``logic_uuid`` property::
> > > +
> > > +  /dts-v1/;
> > > +  / {
> > > +      logic_uuid = "0123456789abcdef0123456789abcdef";
> > > +      ...
> > > +    }
> > > +
> > > +Schema Version
> > > +^^^^^^^^^^^^^^
> > > +Schema version is defined through the ``schema_version`` node. It contains
> > > +``major`` and ``minor`` properties as below::
> > > +
> > > +  /dts-v1/;
> > > +  / {
> > > +       schema_version {
> > > +           major = <0x01>;
> > > +           minor = <0x00>;
> > > +       };
> > > +       ...
> > > +    }
> > > +
> > > +.. _partition_uuids:
> > > +
> > > +Partition UUIDs
> > > +^^^^^^^^^^^^^^^
> > > +Each partition may have parent and child UUIDs. These UUIDs are
> > > +defined by ``interfaces`` node and ``interface_uuid`` property::
> > > +
> > > +  /dts-v1/;
> > > +  / {
> > > +       interfaces {
> > > +           @0 {
> > > +                  interface_uuid = "0123456789abcdef0123456789abcdef";
> > > +           };
> > > +           @1 {
> > > +                  interface_uuid = "fedcba9876543210fedcba9876543210";
> > > +           };
> > > +           ...
> > > +        };
> > > +       ...
> > > +    }
> > > +
> > > +
> > > +Subsystem Instantiations
> > > +^^^^^^^^^^^^^^^^^^^^^^^^
> > > +Subsystem instantiations are captured as children of ``addressable_endpoints``
> > > +node::
> > > +
> > > +  /dts-v1/;
> > > +  / {
> > > +       addressable_endpoints {
> > > +           abc {
> > > +               ...
> > > +           };
> > > +           def {
> > > +               ...
> > > +           };
> > > +           ...
> > > +       }
> > > +  }
> > > +
> > > +Subnode 'abc' and 'def' are the name of subsystem nodes
> > > +
> > > +Subsystem Node
> > > +^^^^^^^^^^^^^^
> > > +Each subsystem node and its properties define a hardware instance::
> > > +
> > > +
> > > +  addressable_endpoints {
> > > +      abc {
> > > +          reg = <0x00 0x1f05000 0x00 0x1000>>
> > > +          pcie_physical_function = <0x0>;
> > > +          pcie_bar_mapping = <0x2>;
> > > +          compatible = "abc def";
> > > +          interrupts = <0x09 0x0c>;
> > > +          firmware {
> > > +              firmware_product_name = "abc"
> > > +              firmware_branch_name = "def"
> > > +              firmware_version_major = <1>
> > > +              firmware_version_minor = <2>
> > > +          };
> > > +      }
> > > +      ...
> > > +  }
> > > +
> > > +:reg:
> > > + Property defines an address range. `<0x00 0x1f05000 0x00 0x1000>` indicates
> > > + *0x00 0x1f05000* as BAR offset and *0x00 0x1000* as address length.
> > > +:pcie_physical_function:
> > > + Property specifies which PCIe physical function the subsystem node resides.
> > > + `<0x0>` implies physical function 0.
> > > +:pcie_bar_mapping:
> > > + Property specifies which PCIe BAR the subsystem node resides. `<0x2>` implies
> > > + BAR 2. A value of 0 means the property is not defined.
> > > +:compatible:
> > > + Property is a list of strings. The first string in the list specifies the exact
> > > + subsystem node. The following strings represent other devices that the device
> > > + is compatible with.
> > > +:interrupts:
> > > + Property specifies start and end interrupts for this subsystem node.
> > > + `<0x09 0x0c>` implies interrupts 9 to 13 are used by this subsystem.
> > > +:firmware:
> > > + Subnode defines the firmware required by this subsystem node.
> > > +
> > > +Alveo U50 Platform Example
> > > +^^^^^^^^^^^^^^^^^^^^^^^^^^
> > > +::
> > > +
> > > +  /dts-v1/;
> > > +
> > > +  /{
> > > +        logic_uuid = "f465b0a3ae8c64f619bc150384ace69b";
> > > +
> > > +        schema_version {
> > > +                major = <0x01>;
> > > +                minor = <0x00>;
> > > +        };
> > > +
> > > +        interfaces {
> > > +
> > > +                @0 {
> > > +                        interface_uuid = "862c7020a250293e32036f19956669e5";
> > > +                };
> > > +        };
> > > +
> > > +        addressable_endpoints {
> > > +
> > > +                ep_blp_rom_00 {
> > > +                        reg = <0x00 0x1f04000 0x00 0x1000>;
> > > +                        pcie_physical_function = <0x00>;
> > > +                        compatible = "xilinx.com,reg_abs-axi_bram_ctrl-1.0\0axi_bram_ctrl";
> > > +                };
> > > +
> > > +                ep_card_flash_program_00 {
> > > +                        reg = <0x00 0x1f06000 0x00 0x1000>;
> > > +                        pcie_physical_function = <0x00>;
> > > +                        compatible = "xilinx.com,reg_abs-axi_quad_spi-1.0\0axi_quad_spi";
> > > +                        interrupts = <0x03 0x03>;
> > > +                };
> > > +
> > > +                ep_cmc_firmware_mem_00 {
> > > +                        reg = <0x00 0x1e20000 0x00 0x20000>;
> > > +                        pcie_physical_function = <0x00>;
> > > +                        compatible = "xilinx.com,reg_abs-axi_bram_ctrl-1.0\0axi_bram_ctrl";
> > > +
> > > +                        firmware {
> > > +                                firmware_product_name = "cmc";
> > > +                                firmware_branch_name = "u50";
> > > +                                firmware_version_major = <0x01>;
> > > +                                firmware_version_minor = <0x00>;
> > > +                        };
> > > +                };
> > > +
> > > +                ep_cmc_intc_00 {
> > > +                        reg = <0x00 0x1e03000 0x00 0x1000>;
> > > +                        pcie_physical_function = <0x00>;
> > > +                        compatible = "xilinx.com,reg_abs-axi_intc-1.0\0axi_intc";
> > > +                        interrupts = <0x04 0x04>;
> > > +                };
> > > +
> > > +                ep_cmc_mutex_00 {
> > > +                        reg = <0x00 0x1e02000 0x00 0x1000>;
> > > +                        pcie_physical_function = <0x00>;
> > > +                        compatible = "xilinx.com,reg_abs-axi_gpio-1.0\0axi_gpio";
> > > +                };
> > > +
> > > +                ep_cmc_regmap_00 {
> > > +                        reg = <0x00 0x1e08000 0x00 0x2000>;
> > > +                        pcie_physical_function = <0x00>;
> > > +                        compatible = "xilinx.com,reg_abs-axi_bram_ctrl-1.0\0axi_bram_ctrl";
> > > +
> > > +                        firmware {
> > > +                                firmware_product_name = "sc-fw";
> > > +                                firmware_branch_name = "u50";
> > > +                                firmware_version_major = <0x05>;
> > > +                        };
> > > +                };
> > > +
> > > +                ep_cmc_reset_00 {
> > > +                        reg = <0x00 0x1e01000 0x00 0x1000>;
> > > +                        pcie_physical_function = <0x00>;
> > > +                        compatible = "xilinx.com,reg_abs-axi_gpio-1.0\0axi_gpio";
> > > +                };
> > > +
> > > +                ep_ddr_mem_calib_00 {
> > > +                        reg = <0x00 0x63000 0x00 0x1000>;
> > > +                        pcie_physical_function = <0x00>;
> > > +                        compatible = "xilinx.com,reg_abs-axi_gpio-1.0\0axi_gpio";
> > > +                };
> > > +
> > > +                ep_debug_bscan_mgmt_00 {
> > > +                        reg = <0x00 0x1e90000 0x00 0x10000>;
> > > +                        pcie_physical_function = <0x00>;
> > > +                        compatible = "xilinx.com,reg_abs-debug_bridge-1.0\0debug_bridge";
> > > +                };
> > > +
> > > +                ep_ert_base_address_00 {
> > > +                        reg = <0x00 0x21000 0x00 0x1000>;
> > > +                        pcie_physical_function = <0x00>;
> > > +                        compatible = "xilinx.com,reg_abs-axi_gpio-1.0\0axi_gpio";
> > > +                };
> > > +
> > > +                ep_ert_command_queue_mgmt_00 {
> > > +                        reg = <0x00 0x40000 0x00 0x10000>;
> > > +                        pcie_physical_function = <0x00>;
> > > +                        compatible = "xilinx.com,reg_abs-ert_command_queue-1.0\0ert_command_queue";
> > > +                };
> > > +
> > > +                ep_ert_command_queue_user_00 {
> > > +                        reg = <0x00 0x40000 0x00 0x10000>;
> > > +                        pcie_physical_function = <0x01>;
> > > +                        compatible = "xilinx.com,reg_abs-ert_command_queue-1.0\0ert_command_queue";
> > > +                };
> > > +
> > > +                ep_ert_firmware_mem_00 {
> > > +                        reg = <0x00 0x30000 0x00 0x8000>;
> > > +                        pcie_physical_function = <0x00>;
> > > +                        compatible = "xilinx.com,reg_abs-axi_bram_ctrl-1.0\0axi_bram_ctrl";
> > > +
> > > +                        firmware {
> > > +                                firmware_product_name = "ert";
> > > +                                firmware_branch_name = "v20";
> > > +                                firmware_version_major = <0x01>;
> > > +                        };
> > > +                };
> > > +
> > > +                ep_ert_intc_00 {
> > > +                        reg = <0x00 0x23000 0x00 0x1000>;
> > > +                        pcie_physical_function = <0x00>;
> > > +                        compatible = "xilinx.com,reg_abs-axi_intc-1.0\0axi_intc";
> > > +                        interrupts = <0x05 0x05>;
> > > +                };
> > > +
> > > +                ep_ert_reset_00 {
> > > +                        reg = <0x00 0x22000 0x00 0x1000>;
> > > +                        pcie_physical_function = <0x00>;
> > > +                        compatible = "xilinx.com,reg_abs-axi_gpio-1.0\0axi_gpio";
> > > +                };
> > > +
> > > +                ep_ert_sched_00 {
> > > +                        reg = <0x00 0x50000 0x00 0x1000>;
> > > +                        pcie_physical_function = <0x01>;
> > > +                        compatible = "xilinx.com,reg_abs-ert_sched-1.0\0ert_sched";
> > > +                        interrupts = <0x09 0x0c>;
> > > +                };
> > > +
> > > +                ep_fpga_configuration_00 {
> > > +                        reg = <0x00 0x1e88000 0x00 0x8000>;
> > > +                        pcie_physical_function = <0x00>;
> > > +                        compatible = "xilinx.com,reg_abs-axi_hwicap-1.0\0axi_hwicap";
> > > +                        interrupts = <0x02 0x02>;
> > > +                };
> > > +
> > > +                ep_icap_reset_00 {
> > > +                        reg = <0x00 0x1f07000 0x00 0x1000>;
> > > +                        pcie_physical_function = <0x00>;
> > > +                        compatible = "xilinx.com,reg_abs-axi_gpio-1.0\0axi_gpio";
> > > +                };
> > > +
> > > +                ep_msix_00 {
> > > +                        reg = <0x00 0x00 0x00 0x20000>;
> > > +                        pcie_physical_function = <0x00>;
> > > +                        compatible = "xilinx.com,reg_abs-msix-1.0\0msix";
> > > +                        pcie_bar_mapping = <0x02>;
> > > +                };
> > > +
> > > +                ep_pcie_link_mon_00 {
> > > +                        reg = <0x00 0x1f05000 0x00 0x1000>;
> > > +                        pcie_physical_function = <0x00>;
> > > +                        compatible = "xilinx.com,reg_abs-axi_gpio-1.0\0axi_gpio";
> > > +                };
> > > +
> > > +                ep_pr_isolate_plp_00 {
> > > +                        reg = <0x00 0x1f01000 0x00 0x1000>;
> > > +                        pcie_physical_function = <0x00>;
> > > +                        compatible = "xilinx.com,reg_abs-axi_gpio-1.0\0axi_gpio";
> > > +                };
> > > +
> > > +                ep_pr_isolate_ulp_00 {
> > > +                        reg = <0x00 0x1000 0x00 0x1000>;
> > > +                        pcie_physical_function = <0x00>;
> > > +                        compatible = "xilinx.com,reg_abs-axi_gpio-1.0\0axi_gpio";
> > > +                };
> > > +
> > > +                ep_uuid_rom_00 {
> > > +                        reg = <0x00 0x64000 0x00 0x1000>;
> > > +                        pcie_physical_function = <0x00>;
> > > +                        compatible = "xilinx.com,reg_abs-axi_bram_ctrl-1.0\0axi_bram_ctrl";
> > > +                };
> > > +
> > > +                ep_xdma_00 {
> > > +                        reg = <0x00 0x00 0x00 0x10000>;
> > > +                        pcie_physical_function = <0x01>;
> > > +                        compatible = "xilinx.com,reg_abs-xdma-1.0\0xdma";
> > > +                        pcie_bar_mapping = <0x02>;
> > > +                };
> > > +        };
> > > +
> > > +  }
> > > +
> > > +
> > > +
> > > +Deployment Models
> > > +=================
> > > +
> > > +Baremetal
> > > +---------
> > > +
> > > +In bare-metal deployments, both MPF and UPF are visible and accessible. The
> > > +xrt-mgmt driver binds to MPF. The xrt-mgmt driver operations are privileged and
> > > +available to system administrator. The full stack is illustrated below::
> > > +
> > > +                            HOST
> > > +
> > > +               [XRT-MGMT]         [XRT-USER]
> > > +                    |                  |
> > > +                    |                  |
> > > +                 +-----+            +-----+
> > > +                 | MPF |            | UPF |
> > > +                 |     |            |     |
> > > +                 | PF0 |            | PF1 |
> > > +                 +--+--+            +--+--+
> > > +          ......... ^................. ^..........
> > > +                    |                  |
> > > +                    |   PCIe DEVICE    |
> > > +                    |                  |
> > > +                 +--+------------------+--+
> > > +                 |         SHELL          |
> > > +                 |                        |
> > > +                 +------------------------+
> > > +                 |         USER           |
> > > +                 |                        |
> > > +                 |                        |
> > > +                 |                        |
> > > +                 |                        |
> > > +                 +------------------------+
> > > +
> > > +
> > > +
> > > +Virtualized
> > > +-----------
> > > +
> > > +In virtualized deployments, the privileged MPF is assigned to the host but the
> > > +unprivileged UPF is assigned to a guest VM via PCIe pass-through. The xrt-mgmt
> > > +driver in host binds to MPF. The xrt-mgmt driver operations are privileged and
> > > +only accessible to the MPF. The full stack is illustrated below::
> > > +
> > > +
> > > +                                 ..............
> > > +                  HOST           .    VM      .
> > > +                                 .            .
> > > +               [XRT-MGMT]        . [XRT-USER] .
> > > +                    |            .     |      .
> > > +                    |            .     |      .
> > > +                 +-----+         .  +-----+   .
> > > +                 | MPF |         .  | UPF |   .
> > > +                 |     |         .  |     |   .
> > > +                 | PF0 |         .  | PF1 |   .
> > > +                 +--+--+         .  +--+--+   .
> > > +          ......... ^................. ^..........
> > > +                    |                  |
> > > +                    |   PCIe DEVICE    |
> > > +                    |                  |
> > > +                 +--+------------------+--+
> > > +                 |         SHELL          |
> > > +                 |                        |
> > > +                 +------------------------+
> > > +                 |         USER           |
> > > +                 |                        |
> > > +                 |                        |
> > > +                 |                        |
> > > +                 |                        |
> > > +                 +------------------------+
> > > +
> > > +
> > > +
> > > +
> > > +
> > > +Platform Security Considerations
> > > +================================
> > > +
> > > +`Security of Alveo Platform <https://xilinx.github.io/XRT/master/html/security.html>`_
> > > +discusses the deployment options and security implications in great detail.
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 056966c9aac9..beeaf0257364 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -7274,6 +7274,17 @@ F:     Documentation/fpga/
> > >   F:   drivers/fpga/
> > >   F:   include/linux/fpga/
> > > 
> > > +FPGA XRT DRIVERS
> > > +M:   Lizhi Hou <lizhi.hou@xilinx.com>
> > > +R:   Max Zhen <max.zhen@xilinx.com>
> > > +R:   Sonal Santan <sonal.santan@xilinx.com>
> > > +L:   linux-fpga@vger.kernel.org
> > > +S:   Supported
> > > +W:   https://github.com/Xilinx/XRT
> > > +F:   Documentation/fpga/xrt.rst
> > > +F:   drivers/fpga/xrt/
> > > +F:   include/uapi/linux/xrt/
> > > +
> > >   FPU EMULATOR
> > >   M:   Bill Metzenthen <billm@melbpc.org.au>
> > >   S:   Maintained
> > > --
> > > 2.27.0
