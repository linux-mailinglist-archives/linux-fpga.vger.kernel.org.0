Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E85E47CE6E
	for <lists+linux-fpga@lfdr.de>; Wed, 22 Dec 2021 09:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243434AbhLVIn6 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 22 Dec 2021 03:43:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243433AbhLVIn6 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 22 Dec 2021 03:43:58 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 356E4C061574
        for <linux-fpga@vger.kernel.org>; Wed, 22 Dec 2021 00:43:58 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id a9so3336857wrr.8
        for <linux-fpga@vger.kernel.org>; Wed, 22 Dec 2021 00:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastree3d-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:subject:from:to:cc:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=4jHGGqjqpvPc518qq762v9FeKmI9nWnLZHs3Ka23Zu8=;
        b=Ah300o3epDhVvNkVK5zGYIjUwFKK17aiEAdQbCn5PYIaCI3rIdfG9xcPiy0xu1+Ga0
         /uP6kF/klADKWS2JGKC2eQ4Yxdo40oJ80yZIAnX+zi/IHT9212lf9TJ+b6fgDX+EeLXd
         rEpBAtiEY8z9ryx/nfOH+luV58bNkro5oFf6XGOdbfYpM+36YggDvIjIcvMZLDQXK/99
         DZcTytS318fWSaVO92b3csVHQxgO8qqP82xYRSwUapnaWlmPw4gnhCFVqfiHQSsvdU9S
         sl/PwvEXB3SwxItg5CNZ9CSoMbj5o+e/OZyipvkap9o/D1aLY5S7Qb6VNu98EyitQgMh
         5/lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=4jHGGqjqpvPc518qq762v9FeKmI9nWnLZHs3Ka23Zu8=;
        b=XbpIp89TQ8iEHa1x+JLFtr33aJUATsLtrx4WeZkEwbgaFIruQSg1B+DE9nPFgQ7brF
         Jxvn64NkCUaOwhbDwWsHS3zrJZctgBbyzbnfmNfgo+YVFdIM6eqmbG2MraIuBs1c2uAn
         BdXeE3Lelhm+oDpVwPGVyLncULjvJYVoqxQkVFqcZaNhEGpSPTeGoZrh/5QBesN+rft+
         LmPYT4+2cydygsXfGeuP+RtEelQs2QOX32NadTLCSZWRAXQEUwL2P7K2ituRon7wRPld
         HReBG0cq1HC8n9Pp8rt6IDOjXBKQ+Z7GCmP0RAZwjr7lr4m29BwoB/abPL/WaHt5qPGn
         qbbQ==
X-Gm-Message-State: AOAM531EdcteYvH07gCkVmVkzfuBTWtJWn0Wd+BN4YZc9nQPciTwVcVv
        XDSxMjabuH1YkAdLAS9miMOBQg==
X-Google-Smtp-Source: ABdhPJwm3uQnh7cRAwIM5FRAdqdqksjZFMXdvIFNsNNtUwGlr9cWLW8AIP53DKgb+pTFRu//zGB7xA==
X-Received: by 2002:adf:aa93:: with SMTP id h19mr1340225wrc.293.1640162636786;
        Wed, 22 Dec 2021 00:43:56 -0800 (PST)
Received: from dls5-laptop.home ([2a02:21b0:644d:b5dd:a74f:423c:6e11:4cb])
        by smtp.gmail.com with ESMTPSA id d22sm1406668wmq.17.2021.12.22.00.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 00:43:56 -0800 (PST)
Message-ID: <23cf0454cadc24bc0fd7d898ab3d4bd4dfd95bac.camel@fastree3d.com>
Subject: Partial reconfiguration on ZynqMP
From:   Simon Doppler <simon.doppler@fastree3d.com>
To:     mdf@kernel.org, trix@redhat.com, michal.simek@xilinx.com,
        linux-fpga@vger.kernel.org
Cc:     Adrian Fiergolski <adrian.fiergolski@fastree3d.com>
Date:   Wed, 22 Dec 2021 09:43:55 +0100
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi everyone,

We are currently trying to use partial reconfiguration for our ZynqMP-
based system (part is xczu6eg) and device-tree overlay based
reconfiguration crashes.
Our Linux system is using 5.10.0-xilinx-v2021.1.

The reconfigurable partition is decoupled from the rest of the design
with an AXI-shutdown manager IP and a DFX decoupler (the
shutdown_requested signal of the AXI shutdown manager is used to drive
the request_shutdown of the DFX decoupler).

The relevant parts of the device tree are:

---- BEGIN SNIP ----
fpga_full: fpga-full {
		status = "okay";
		reconf_region: reconf_region0 {
			  compatible = "fpga-region";
			  fpga-bridges = <&reconf_bridge0>;
		};
       };

reconf_bridge0: reconf_bridge@a0080000  {
			status = "okay";
			compatible = "xlnx,dfx-axi-shutdown-manager-
1.00";
			reg = <0x0 0xa0080000 0x0 0x10>;
			clock-names = "aclk";
			clocks = <&zynqmp_clk 73>;
			bridge-enable = <1>;
		};
---- END SNIP ----

To reconfigure, I tested the following cases:

1. manual reconfiguration: WORKS
   - decouple by writing to the register directly
   - reconfigure directly with the fpga-manager
   - recouple by writing directly to the register
   
2. full reconfiguration with device-tree overlay: WORKS
   - we feed the full bitstream to the FPGA manager
   - using the following device-tree overlay:
---- BEGIN SNIP ----
/dts-v1/;
/plugin/;

&reconf_region {
	firmware-name = "full.bit";
};
---- BEGIN SNIP ----

3. partial reconfiguration with device-tree overlay:
   - we feed the full bitstream to the FPGA manager
   - using the following device-tree overlay:
---- BEGIN SNIP ----
/dts-v1/;
/plugin/;

&reconf_region {
	partial-fpga-config;
	fpga-bridges = <&reconf_bridge0>;
	firmware-name = "partial.bit";
};
---- BEGIN SNIP ----

In this case, the whole system crashes (even the platform cable does
not respond anymore).
When setting an ILA trigger on the write valid signal of the AXI
control path of the AXI Shutdown manager, the ILA appears to trigger
but crashes before the data is shown in the hardware manager window of
Vivado.

When the partial bitstream written by the overlay is already loaded (by
hand, as is case 1), the reconfiguration using an overlay works and the
AXI Shutdown manager is written to as expected.

Do you have an idea on what is going wrong here ?
As I manage to do the reconfiguration by hand, I suspect a
configuration/device-tree/software error.

Best regards

Simon Doppler

