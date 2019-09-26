Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26423BEFCA
	for <lists+linux-fpga@lfdr.de>; Thu, 26 Sep 2019 12:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725843AbfIZKjj (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 26 Sep 2019 06:39:39 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:40308 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725554AbfIZKjj (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 26 Sep 2019 06:39:39 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8QAcAXT026178;
        Thu, 26 Sep 2019 06:39:13 -0400
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2054.outbound.protection.outlook.com [104.47.36.54])
        by mx0b-00128a01.pphosted.com with ESMTP id 2v6hkcq37p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Sep 2019 06:39:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nBztQqqeolHF87xxFSdUcwoj0jc6rcx1SdVGz17RTjv0ENP8IYNDG4eHHIczq960W0VCWDgc4hMNvtvvqDmwuzuKdMA4YkWznUUGpWh5av8SkHU1h7bDFWUspCV+4YmllvWas2Yrmq81b4qsS3dtejdqxzH0PQ2gBFeAhFAJxSZa6y4S8otxyCAZ8yRqSvLA2ODXp6GKsQurUjeaMLo3uKPkQdYwHSke+D8C/fcufdqOSrL8R+ynia4A8tciKE/oCrcW/AhNTMyAzVBlNwN4qco7OyhQX9aqEALANaLIG5Hkg9kaAKNpaR1VoKsm/Rc0VsUG5li2VpM/K129GDJAng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FfZFKqroEvgSazm3NbMOoQ/m7C/VJgnARB6UMcDJtAE=;
 b=PbtFMxntl0UosSrWd7MH2Hems5uSoLIOvXu5QtvxVQYbvyjbjW9ePEXqvO6EPg7UYpaqGVRgxl70rXGINfay/OSA8AebUTW3MhHjB1eReyGi7LowqQVPeonyP30goOhoS8iKRNXamS8T/uNC3g4bCBR5wDOhIwAct5kv8AJQeRRfWJxM8Ig24WXemWt/bOSC3kILeQxuW+DKFAqzKitvmqnkLvfYWH5Smfn69ciI6ZKbc8pwP3cAN1NQ1dRR0jVCN/wMpS2kHUXQ6+yc+pJcPDpfWI/HaioL59pK8dt1Neau40esSMxc6mzASl+PhvtrjtavpUsPEh9++xmebu9HRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.55) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FfZFKqroEvgSazm3NbMOoQ/m7C/VJgnARB6UMcDJtAE=;
 b=tbHEZ2AaoN33Cm9L6R3zSbmuJ9ExegozFR38VxPvLaXrLmqPaVxmRLSqHsqonxy/4g/NeynZjRraDB1/tkqaNRt2Tdfo2iG9RuXqWGYggB2Zm1rEKZ1E4qcOu7gORBaD9NGgYaS0lVrZexqoPKV4Fijyv/IZgdadLS/0sZY9sqE=
Received: from BY5PR03CA0009.namprd03.prod.outlook.com (2603:10b6:a03:1e0::19)
 by DM6PR03MB4058.namprd03.prod.outlook.com (2603:10b6:5:58::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.26; Thu, 26 Sep
 2019 10:39:11 +0000
Received: from BL2NAM02FT064.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::205) by BY5PR03CA0009.outlook.office365.com
 (2603:10b6:a03:1e0::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2305.15 via Frontend
 Transport; Thu, 26 Sep 2019 10:39:10 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BL2NAM02FT064.mail.protection.outlook.com (10.152.77.119) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2284.25
 via Frontend Transport; Thu, 26 Sep 2019 10:39:10 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x8QAd4iQ026163
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 26 Sep 2019 03:39:04 -0700
Received: from nsa.sphairon.box (10.44.3.90) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server (TLS) id 14.3.408.0; Thu, 26 Sep
 2019 06:39:08 -0400
From:   =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
To:     <devicetree@vger.kernel.org>, <linux-fpga@vger.kernel.org>,
        <linux-hwmon@vger.kernel.org>
CC:     Moritz Fischer <mdf@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 2/3] hwmon: Support ADI Fan Control IP
Date:   Thu, 26 Sep 2019 12:39:24 +0200
Message-ID: <20190926103925.194973-3-nuno.sa@analog.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190926103925.194973-1-nuno.sa@analog.com>
References: <20190926103925.194973-1-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.44.3.90]
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(39860400002)(346002)(189003)(199004)(8936002)(50226002)(4326008)(8676002)(246002)(2201001)(45776006)(6116002)(3846002)(110136005)(106002)(50466002)(6306002)(54906003)(30864003)(14444005)(186003)(336012)(16526019)(26005)(2616005)(476003)(486006)(446003)(11346002)(316002)(5660300002)(305945005)(5820100001)(6666004)(356004)(70206006)(70586007)(53416004)(36756003)(7636002)(23676004)(7736002)(76176011)(426003)(126002)(86362001)(966005)(1076003)(2906002)(478600001)(47776003)(2870700001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR03MB4058;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1739dc3e-4010-447f-329c-08d7426dc42f
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(4709080)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM6PR03MB4058;
X-MS-TrafficTypeDiagnostic: DM6PR03MB4058:
X-MS-Exchange-PUrlCount: 1
X-Microsoft-Antispam-PRVS: <DM6PR03MB40589F3B3D014BFB418D144C99860@DM6PR03MB4058.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0172F0EF77
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: GwPLoO5HOoxCLPMU8kGIVWbv4X1hQxekKVsnEpFSr4aJOMV9i3HYpeDtHvxeWjr0Nsg2tV5Lt7km03hbrFVzfehis+XsvQ0Q3R+Mu+lpZDssjkui/EeHoSv8a5BP97T+Sh9snUBMiG+QBmmtilX9tNb8Zp3ZjW3UGYGHosNEZkdtO30ngDVEQKZhbCSxMVWayaiHJ+R10z/EcUGGV7Y9agxXAEI3xODJtu1Wg+miJ/60Rn7VbJc5Dearlzf8kG9EkdgbTXD/u9v8e1bq4SwQsHxCBIE2wMkYxfYls9vNpgor3XoNA6ox1mtnf5f4dNYwajInATooSIpy+jX4IZt5tDbwu+mKxQj5lteGw/M2rEFzq4gTn8wl5gsjzmnCgS3TfHWAf0ZhJ5mDpxZSeA+4J/8rIk6MZoaDf9yFUCe1W+iLLcbmcpAvxqHp0/3EnugB3xw63C/0W3O8Px6OldCxGg==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2019 10:39:10.6020
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1739dc3e-4010-447f-329c-08d7426dc42f
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4058
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-09-26_05:2019-09-25,2019-09-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 clxscore=1015 mlxscore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 spamscore=0 malwarescore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909260100
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

The purpose of this IP Core is to control the fan used for the cooling of a
Xilinx Zynq Ultrascale+ MPSoC without the need of any external temperature
sensors. To achieve this, the IP core uses the PL SYSMONE4 primitive to
obtain the PL temperature and, based on those readings, it then outputs
a PWM signal to control the fan rotation accordingly.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 MAINTAINERS                     |   7 +
 drivers/hwmon/Kconfig           |   9 +
 drivers/hwmon/Makefile          |   1 +
 drivers/hwmon/axi-fan-control.c | 452 ++++++++++++++++++++++++++++++++
 4 files changed, 469 insertions(+)
 create mode 100644 drivers/hwmon/axi-fan-control.c

diff --git a/MAINTAINERS b/MAINTAINERS
index c7035ce2460b..d775c923d23b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2853,6 +2853,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/sound/axentia,*
 F:	sound/soc/atmel/tse850-pcm5142.c
 
+AXI-FAN-CONTROL HARDWARE MONITOR DRIVER
+M:	Nuno Sá <nuno.sa@analog.com>
+W:	http://ez.analog.com/community/linux-device-drivers
+L:	linux-hwmon@vger.kernel.org
+S:	Supported
+F:	drivers/hwmon/axi-fan-control.c
+
 AXXIA I2C CONTROLLER
 M:	Krzysztof Adamski <krzysztof.adamski@nokia.com>
 L:	linux-i2c@vger.kernel.org
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 2ca5668bdb62..2396cc347c47 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -269,6 +269,15 @@ config SENSORS_ASC7621
 	  This driver can also be built as a module. If so, the module
 	  will be called asc7621.
 
+config SENSORS_AXI_FAN_CONTROL
+	tristate "Analog Devices FAN Control HDL Core driver"
+	help
+	  If you say yes here you get support for the Analog Devices
+	  AXI HDL FAN monitoring core.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called axi-fan-control
+
 config SENSORS_K8TEMP
 	tristate "AMD Athlon64/FX or Opteron temperature sensor"
 	depends on X86 && PCI
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index c86ce4d3d36b..ebb1fd2ea82b 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -51,6 +51,7 @@ obj-$(CONFIG_SENSORS_AS370)	+= as370-hwmon.o
 obj-$(CONFIG_SENSORS_ASC7621)	+= asc7621.o
 obj-$(CONFIG_SENSORS_ASPEED)	+= aspeed-pwm-tacho.o
 obj-$(CONFIG_SENSORS_ATXP1)	+= atxp1.o
+obj-$(CONFIG_SENSORS_AXI_FAN_CONTROL) += axi-fan-control.o
 obj-$(CONFIG_SENSORS_CORETEMP)	+= coretemp.o
 obj-$(CONFIG_SENSORS_DA9052_ADC)+= da9052-hwmon.o
 obj-$(CONFIG_SENSORS_DA9055)+= da9055-hwmon.o
diff --git a/drivers/hwmon/axi-fan-control.c b/drivers/hwmon/axi-fan-control.c
new file mode 100644
index 000000000000..f86efc444753
--- /dev/null
+++ b/drivers/hwmon/axi-fan-control.c
@@ -0,0 +1,452 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Fan Control HDL CORE driver
+ *
+ * Copyright 2019 Analog Devices Inc.
+ */
+#include <linux/clk.h>
+#include <linux/fpga/adi-axi-common.h>
+#include <linux/hwmon.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+
+/* register map */
+#define ADI_REG_RSTN		0x0080
+#define ADI_REG_PWM_WIDTH	0x0084
+#define ADI_REG_TACH_PERIOD	0x0088
+#define ADI_REG_TACH_TOLERANCE	0x008c
+#define ADI_REG_PWM_PERIOD	0x00c0
+#define ADI_REG_TACH_MEASUR	0x00c4
+#define ADI_REG_TEMPERATURE	0x00c8
+
+#define ADI_REG_IRQ_MASK	0x0040
+#define ADI_REG_IRQ_PENDING	0x0044
+#define ADI_REG_IRQ_SRC		0x0048
+
+/* IRQ sources */
+#define ADI_IRQ_SRC_PWM_CHANGED		BIT(0)
+#define ADI_IRQ_SRC_TACH_ERR		BIT(1)
+#define ADI_IRQ_SRC_TEMP_INCREASE	BIT(2)
+#define ADI_IRQ_SRC_NEW_MEASUR		BIT(3)
+#define ADI_IRQ_SRC_MASK		GENMASK(3, 0)
+#define ADI_IRQ_MASK_OUT_ALL		0xFFFFFFFFU
+
+#define SYSFS_PWM_MAX			255
+
+struct axi_fan_control_data {
+	struct clk *clk;
+	void __iomem *base;
+	/* tacho period */
+	atomic_t tach;
+	int irq;
+	/* pulses per revolution */
+	u32 ppr;
+	bool hw_pwm_req;
+	bool update_tacho_params;
+	u8 fan_fault;
+};
+
+static inline void axi_fan_control_iowrite(const u32 val, const u32 reg,
+				const struct axi_fan_control_data *ctl)
+{
+	iowrite32(val, ctl->base + reg);
+}
+
+static inline u32 axi_fan_control_ioread(const u32 reg,
+					 const struct axi_fan_control_data *ctl)
+{
+	return ioread32(ctl->base + reg);
+}
+
+static long axi_fan_control_get_pwm_duty(const struct axi_fan_control_data *ctl)
+{
+	u32 pwm_width = axi_fan_control_ioread(ADI_REG_PWM_WIDTH, ctl);
+	u32 pwm_period = axi_fan_control_ioread(ADI_REG_PWM_PERIOD, ctl);
+
+	return DIV_ROUND_CLOSEST(pwm_width * SYSFS_PWM_MAX, pwm_period);
+}
+
+static int axi_fan_control_set_pwm_duty(const long val,
+					struct axi_fan_control_data *ctl)
+{
+	u32 pwm_period = axi_fan_control_ioread(ADI_REG_PWM_PERIOD, ctl);
+	u32 new_width;
+	long __val = clamp_val(val, 0, SYSFS_PWM_MAX);
+
+	new_width = DIV_ROUND_CLOSEST(__val * pwm_period, SYSFS_PWM_MAX);
+
+	axi_fan_control_iowrite(new_width, ADI_REG_PWM_WIDTH, ctl);
+
+	return 0;
+}
+
+static long axi_fan_control_get_fan_rpm(const struct axi_fan_control_data *ctl)
+{
+	unsigned long clk_rate = clk_get_rate(ctl->clk);
+
+	if (!clk_rate)
+		return -EINVAL;
+	/*
+	 * The tacho period should be:
+	 *      TACH = 60/(ppr * rpm), where rpm is revolutions per second
+	 *      and ppr is pulses per revolution.
+	 * Given the tacho period, we can multiply it by the input clock
+	 * so that we know how many clocks we need to have this period.
+	 * From this, we can derive the RPM value.
+	 */
+	return DIV_ROUND_CLOSEST(60 * clk_rate,
+				 ctl->ppr * atomic_read(&ctl->tach));
+}
+
+static int axi_fan_control_read_temp(struct device *dev, u32 attr, long *val)
+{
+	struct axi_fan_control_data *ctl = dev_get_drvdata(dev);
+	long raw_temp;
+
+	switch (attr) {
+	case hwmon_temp_input:
+		raw_temp = axi_fan_control_ioread(ADI_REG_TEMPERATURE, ctl);
+		/*
+		 * The formula for the temperature is:
+		 *      T = (ADC * 501.3743 / 2^bits) - 273.6777
+		 * It's multiplied by 1000 to have milidegrees as
+		 * specified by the hwmon sysfs interface.
+		 */
+		*val = ((raw_temp * 501374) >> 16) - 273677;
+		return 0;
+	default:
+		return -ENOTSUPP;
+	}
+}
+
+static int axi_fan_control_read_fan(struct device *dev, u32 attr, long *val)
+{
+	struct axi_fan_control_data *ctl = dev_get_drvdata(dev);
+
+	switch (attr) {
+	case hwmon_fan_fault:
+		*val = ctl->fan_fault;
+		return 0;
+	case hwmon_fan_input:
+		*val = axi_fan_control_get_fan_rpm(ctl);
+		return 0;
+	default:
+		return -ENOTSUPP;
+	}
+}
+
+static int axi_fan_control_read_pwm(struct device *dev, u32 attr, long *val)
+{
+	struct axi_fan_control_data *ctl = dev_get_drvdata(dev);
+
+	switch (attr) {
+	case hwmon_pwm_input:
+		*val = axi_fan_control_get_pwm_duty(ctl);
+		return 0;
+	default:
+		return -ENOTSUPP;
+	}
+}
+
+static int axi_fan_control_write_pwm(struct device *dev, u32 attr, long val)
+{
+	struct axi_fan_control_data *ctl = dev_get_drvdata(dev);
+
+	switch (attr) {
+	case hwmon_pwm_input:
+		return axi_fan_control_set_pwm_duty(val, ctl);
+	default:
+		return -ENOTSUPP;
+	}
+}
+
+static int axi_fan_control_read_labels(struct device *dev,
+				       enum hwmon_sensor_types type,
+				       u32 attr, int channel, const char **str)
+{
+	switch (type) {
+	case hwmon_fan:
+		*str = "FAN";
+		return 0;
+	case hwmon_temp:
+		*str = "SYSMON4";
+		return 0;
+	default:
+		return -ENOTSUPP;
+	}
+}
+
+static int axi_fan_control_read(struct device *dev,
+				enum hwmon_sensor_types type,
+				u32 attr, int channel, long *val)
+{
+	switch (type) {
+	case hwmon_fan:
+		return axi_fan_control_read_fan(dev, attr, val);
+	case hwmon_pwm:
+		return axi_fan_control_read_pwm(dev, attr, val);
+	case hwmon_temp:
+		return axi_fan_control_read_temp(dev, attr, val);
+	default:
+		return -ENOTSUPP;
+	}
+}
+
+static int axi_fan_control_write(struct device *dev,
+				 enum hwmon_sensor_types type,
+				 u32 attr, int channel, long val)
+{
+	switch (type) {
+	case hwmon_pwm:
+		return axi_fan_control_write_pwm(dev, attr, val);
+	default:
+		return -ENOTSUPP;
+	}
+}
+
+static umode_t axi_fan_control_fan_is_visible(const u32 attr)
+{
+	switch (attr) {
+	case hwmon_fan_input:
+	case hwmon_fan_fault:
+	case hwmon_fan_label:
+		return 0444;
+	default:
+		return 0;
+	}
+}
+
+static umode_t axi_fan_control_pwm_is_visible(const u32 attr)
+{
+	switch (attr) {
+	case hwmon_pwm_input:
+		return 0644;
+	default:
+		return 0;
+	}
+}
+
+static umode_t axi_fan_control_temp_is_visible(const u32 attr)
+{
+	switch (attr) {
+	case hwmon_temp_input:
+	case hwmon_temp_label:
+		return 0444;
+	default:
+		return 0;
+	}
+}
+
+static umode_t axi_fan_control_is_visible(const void *data,
+					  enum hwmon_sensor_types type,
+					  u32 attr, int channel)
+{
+	switch (type) {
+	case hwmon_fan:
+		return axi_fan_control_fan_is_visible(attr);
+	case hwmon_pwm:
+		return axi_fan_control_pwm_is_visible(attr);
+	case hwmon_temp:
+		return axi_fan_control_temp_is_visible(attr);
+	default:
+		return 0;
+	}
+}
+
+static irqreturn_t axi_fan_control_irq_handler(int irq, void *data)
+{
+	struct axi_fan_control_data *ctl = (struct axi_fan_control_data *)data;
+	u32 irq_pending = axi_fan_control_ioread(ADI_REG_IRQ_PENDING, ctl);
+	u32 clear_mask;
+
+	if (irq_pending & ADI_IRQ_SRC_NEW_MEASUR) {
+		u32 new_tach = axi_fan_control_ioread(ADI_REG_TACH_MEASUR,
+						      ctl);
+
+		if (ctl->update_tacho_params) {
+			/* get 25% tolerance */
+			u32 tach_tol = DIV_ROUND_CLOSEST(new_tach * 25, 100);
+			/* set new tacho parameters */
+			axi_fan_control_iowrite(new_tach, ADI_REG_TACH_PERIOD,
+						ctl);
+			axi_fan_control_iowrite(tach_tol,
+						ADI_REG_TACH_TOLERANCE, ctl);
+			ctl->update_tacho_params = false;
+		}
+
+		atomic_set(&ctl->tach, new_tach);
+	}
+
+	if (irq_pending & ADI_IRQ_SRC_PWM_CHANGED) {
+		/*
+		 * if the pwm changes on behalf of software,
+		 * we need to provide new tacho parameters to the core.
+		 * Wait for the next measurement for that...
+		 */
+		if (!ctl->hw_pwm_req)
+			ctl->update_tacho_params = true;
+
+		/* just set this to false even if it is already... */
+		ctl->hw_pwm_req = false;
+	}
+
+	if (irq_pending & ADI_IRQ_SRC_TEMP_INCREASE)
+		/* hardware requested a new pwm */
+		ctl->hw_pwm_req = true;
+
+	if (irq_pending & ADI_IRQ_SRC_TACH_ERR)
+		ctl->fan_fault = 1;
+
+	/* clear all interrupts */
+	clear_mask = irq_pending & ADI_IRQ_SRC_MASK;
+	axi_fan_control_iowrite(clear_mask, ADI_REG_IRQ_PENDING, ctl);
+
+	return IRQ_HANDLED;
+}
+
+static int axi_fan_control_init(struct axi_fan_control_data *ctl,
+				const struct device_node *np)
+{
+	int ret;
+
+	/* get fan pulses per revolution */
+	ret = of_property_read_u32(np, "adi,pulses-per-revolution", &ctl->ppr);
+	if (ret)
+		return ret;
+	/*
+	 * Enable all IRQs
+	 */
+	axi_fan_control_iowrite((ADI_IRQ_MASK_OUT_ALL &
+			~(ADI_IRQ_SRC_NEW_MEASUR | ADI_IRQ_SRC_TACH_ERR |
+			ADI_IRQ_SRC_PWM_CHANGED | ADI_IRQ_SRC_TEMP_INCREASE)),
+			ADI_REG_IRQ_MASK, ctl);
+
+	/* bring the device out of reset */
+	axi_fan_control_iowrite(0x01, ADI_REG_RSTN, ctl);
+
+	return ret;
+}
+
+static const struct hwmon_channel_info *axi_fan_control_info[] = {
+	HWMON_CHANNEL_INFO(pwm, HWMON_PWM_INPUT),
+	HWMON_CHANNEL_INFO(fan, HWMON_F_INPUT | HWMON_F_FAULT | HWMON_F_LABEL),
+	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT | HWMON_T_LABEL),
+	NULL
+};
+
+static const struct hwmon_ops axi_fan_control_hwmon_ops = {
+	.is_visible = axi_fan_control_is_visible,
+	.read = axi_fan_control_read,
+	.write = axi_fan_control_write,
+	.read_string = axi_fan_control_read_labels,
+};
+
+static const struct hwmon_chip_info axi_fan_control_chip_info = {
+	.ops = &axi_fan_control_hwmon_ops,
+	.info = axi_fan_control_info,
+};
+
+static const u32 version_1_0_0 = ADI_AXI_PCORE_VER(1, 0, 'a');
+
+static const struct of_device_id axi_fan_control_of_match[] = {
+	{ .compatible = "adi,axi-fan-control-1.00.a",
+		.data = (void *)&version_1_0_0},
+	{},
+};
+MODULE_DEVICE_TABLE(of, axi_fan_control_of_match);
+
+static int axi_fan_control_probe(struct platform_device *pdev)
+{
+	struct device *hwmon_dev;
+	struct axi_fan_control_data *ctl;
+	const struct of_device_id *id;
+	struct resource *res;
+	u32 version;
+	int ret;
+
+	id = of_match_node(axi_fan_control_of_match, pdev->dev.of_node);
+	if (!id)
+		return -EINVAL;
+
+	ctl = devm_kzalloc(&pdev->dev, sizeof(*ctl), GFP_KERNEL);
+	if (!ctl)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	ctl->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(ctl->base)) {
+		dev_err(&pdev->dev, "ioremap failed with %ld\n",
+			PTR_ERR(ctl->base));
+		return PTR_ERR(ctl->base);
+	}
+
+	ctl->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(ctl->clk)) {
+		dev_err(&pdev->dev, "clk_get failed with %ld\n",
+			PTR_ERR(ctl->clk));
+		return PTR_ERR(ctl->clk);
+	}
+
+	dev_dbg(&pdev->dev, "Re-mapped from 0x%08llX to %p\n",
+		(unsigned long long)res->start, ctl->base);
+
+	version = axi_fan_control_ioread(ADI_AXI_REG_VERSION, ctl);
+	if (ADI_AXI_PCORE_VER_MAJOR(version) !=
+	    ADI_AXI_PCORE_VER_MAJOR((*(u32 *)id->data))) {
+		dev_err(&pdev->dev, "Major version mismatch. Expected %d.%.2d.%c, Reported %d.%.2d.%c\n",
+			ADI_AXI_PCORE_VER_MAJOR((*(u32 *)id->data)),
+			ADI_AXI_PCORE_VER_MINOR((*(u32 *)id->data)),
+			ADI_AXI_PCORE_VER_PATCH((*(u32 *)id->data)),
+			ADI_AXI_PCORE_VER_MAJOR(version),
+			ADI_AXI_PCORE_VER_MINOR(version),
+			ADI_AXI_PCORE_VER_PATCH(version));
+		return -ENODEV;
+	}
+
+	ctl->irq = platform_get_irq(pdev, 0);
+	if (ctl->irq < 0) {
+		dev_err(&pdev->dev, "platform_get_irq failed with %d\n",
+			ctl->irq);
+		return ctl->irq;
+	}
+
+	ret = devm_request_threaded_irq(&pdev->dev, ctl->irq, NULL,
+					axi_fan_control_irq_handler,
+					IRQF_ONESHOT | IRQF_TRIGGER_HIGH,
+					pdev->driver_override, ctl);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to request an irq, %d", ret);
+		return ret;
+	}
+
+	ret = axi_fan_control_init(ctl, pdev->dev.of_node);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to initialize device\n");
+		return ret;
+	}
+
+	hwmon_dev = devm_hwmon_device_register_with_info(&pdev->dev,
+						"axi_fan_control",
+						ctl,
+						&axi_fan_control_chip_info,
+						NULL);
+
+	return PTR_ERR_OR_ZERO(hwmon_dev);
+}
+
+static struct platform_driver axi_fan_control_driver = {
+	.driver = {
+		.name = "axi_fan_control_driver",
+		.of_match_table = axi_fan_control_of_match,
+	},
+	.probe = axi_fan_control_probe,
+};
+module_platform_driver(axi_fan_control_driver);
+
+MODULE_AUTHOR("Nuno Sa <nuno.sa@analog.com>");
+MODULE_DESCRIPTION("Analog Devices Fan Control HDL CORE driver");
+MODULE_LICENSE("GPL");
-- 
2.23.0

