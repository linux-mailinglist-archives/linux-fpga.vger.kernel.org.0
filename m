Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB5721C57B0
	for <lists+linux-fpga@lfdr.de>; Tue,  5 May 2020 16:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729195AbgEEOA6 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 5 May 2020 10:00:58 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:35415 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728076AbgEEOA6 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 5 May 2020 10:00:58 -0400
Received: from localhost.localdomain ([149.172.19.189]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1N1gac-1j7oTV2poG-012335; Tue, 05 May 2020 16:00:46 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Moritz Fischer <mdf@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Jolly Shah <jolly.shah@xilinx.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Wu Hao <hao.wu@intel.com>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fpga: zynqmp: fix modular build
Date:   Tue,  5 May 2020 16:00:11 +0200
Message-Id: <20200505140041.231844-1-arnd@arndb.de>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:YFo2Keel82Z3Gr9OiCXU0VDp+1/XDdwgGNJlJy2n/RdLIDRIZc0
 +Pfq73sv5WYzpOZMomKb9DzWUiBFPZ4MFOTYBqSDi1srwA3OCFw+SgDevVuKNx54TnKlNZ4
 17Fw3HXK50L1rHiL2Wl76lPnXRi9wx4ruvH1Z7ly1cjDIqcB4ZjkKEOEB5UVsiIfSMG1Vwi
 Ha9j65wSILeT73r3xirMw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:jveTGg4pXiI=:xAp0dMXE3xGUv13ll18YaI
 91P3GNbkKv4/LLec+bGaPH7d/Guh+lRoI1+L8o4bUEBymZnuf19N2bW6fA5kXD308qMpz0lbR
 QmBgG91L5kyJyAzozzr9yZgq6kcOF9tObUcLjkTpWs+KH4QKSj5YdW6MLCGpg5pYXc9DV7p1s
 T3YpQsuTl60BrATKn15iFBYXgUiDHdu32gihPaltA9l+0+41JmOzbW3JIVjqbAnXancWUV+54
 stY7G45dMsXMO+saMFvJVhC1NSJJ1uT8K3kZl8ASwkYNnue2kVTecmcN2AgIuIJlYXUS8rNRE
 DiXACQkN4Sa1Q2T3ZNa2wWIZIQ4vBoGjcg/MlMe71vEEWHIRbeuNT/xu/8i6cliZPLwRgD2l8
 w+7KROmOFRNkW0gzWDp+n+LT3rgJT1mwkJvQAeQK5yeSzdTi1gyUs+SN+Mep+qWRETtsaGu/F
 WQTcJ9x8OM1JCrYOK6Lp63YXQX8esAxYiF2vXFKVuQl7O27fQkDq6cU0VETNl7wKvS7J0A8fv
 ezKoE+/PBOT83hkButa1ZuRE9Lo6hJ7nFvy3W6UVE419jppOCbleXuM7nJvbhFZ9MO5BwOXRO
 zinyTlZ40uqGx3OJ+k2VEET5dQvzg9bfaJt70k0THhlm90nmu4NYXi70YMPJvXTbmyM+Eqi/y
 XeSpOLC9DnNtZKMSTR6tn2FIxOVIu5WgDZfeup6FB8NFu3kyZBvhK+CDfV14qmHohma7qcU6E
 CnqyqYdNmgesyhRA+RjSrcPA+bSia/ejOY/mYle3XE6naC8sKaOCHKjKLXfszlDrogQ3tYM+I
 1lRx6fSKE3CIkzFB+i4a4iT39Q6AWIgpAYSzlRK4QIqLXO/bOE=
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Two symbols need to be exported to allow the zynqmp-fpga module
to get loaded dynamically:

ERROR: modpost: "zynqmp_pm_fpga_load" [drivers/fpga/zynqmp-fpga.ko] undefined!
ERROR: modpost: "zynqmp_pm_fpga_get_status" [drivers/fpga/zynqmp-fpga.ko] undefined!

To ensure this is done correctly, also fix the Kconfig dependency
to only allow building the fpga driver when the firmware driver is
either disabled, or when it is reachable. With that, the dependency
on the SoC itself can be removed, and there are no surprises when
the fpga driver is built-in but the firmware a module.

Fixes: 4db8180ffe7c ("firmware: xilinx: Remove eemi ops for fpga related APIs")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/fpga/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index b2408a710662..7cd5a29fc437 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -208,7 +208,7 @@ config FPGA_DFL_PCI
 
 config FPGA_MGR_ZYNQMP_FPGA
 	tristate "Xilinx ZynqMP FPGA"
-	depends on ARCH_ZYNQMP || COMPILE_TEST
+	depends on ZYNQMP_FIRMWARE || (!ZYNQMP_FIRMWARE && COMPILE_TEST)
 	help
 	  FPGA manager driver support for Xilinx ZynqMP FPGAs.
 	  This driver uses the processor configuration port(PCAP)
-- 
2.26.0

